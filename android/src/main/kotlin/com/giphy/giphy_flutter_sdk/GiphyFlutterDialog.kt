package com.giphy.giphy_flutter_sdk

import android.content.Context
import android.view.ViewGroup
import android.view.Window
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.updateLayoutParams
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import androidx.fragment.app.FragmentManager
import com.giphy.giphy_flutter_sdk.dto.toGPHSettings
import com.giphy.giphy_flutter_sdk.dto.toHashMap
import com.giphy.giphy_flutter_sdk.utils.getVideoPlayerFactory
import com.giphy.sdk.core.models.Media
import com.giphy.sdk.ui.GPHContentType
import com.giphy.sdk.ui.GPHSettings
import com.giphy.sdk.ui.views.GiphyDialogFragment
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class GiphyFlutterDialog : MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private var activity: FragmentActivity? = null

    private var settings: GPHSettings = GPHSettings()
    private var gifsDialog: GiphyDialogFragment? = null

    private fun initializeDialog() {
        gifsDialog = GiphyDialogFragment.newInstance(
            settings,
            videoPlayer = getVideoPlayerFactory()
        )
    }

    private fun getGifSelectionListener() = object : GiphyDialogFragment.GifSelectionListener {
        override fun onGifSelected(
            media: Media, searchTerm: String?, selectedContentType: GPHContentType
        ) {
            channel.invokeMethod(
                "onMediaSelect", mapOf(
                    "media" to media.toHashMap(),
                    "searchTerm" to searchTerm,
                    "selectedContentType" to selectedContentType.name
                )
            )
        }

        override fun onDismissed(selectedContentType: GPHContentType) {
            channel.invokeMethod("onDismiss", null)
        }

        override fun didSearchTerm(term: String) {}
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "configure" -> configure(call, result)
            "show" -> show(result)
            "hide" -> hide(result)
            else -> result.notImplemented()
        }
    }

    private fun configure(call: MethodCall, result: MethodChannel.Result) {
        settings =
            call.argument<HashMap<String, Any?>>("settings")?.toGPHSettings() ?: GPHSettings()
        result.success(null)
    }

    private fun show(result: MethodChannel.Result) {
        val fragmentManager = activity?.supportFragmentManager
        if (fragmentManager == null) {
            result.error("-1", "Can't obtain supportFragmentManager", null)
            return
        }
        initializeDialog()
        gifsDialog!!.gifSelectionListener = getGifSelectionListener()
        if (settings.enableEdgeToEdge) {
            fragmentManager.registerFragmentLifecycleCallbacks(
                object : FragmentManager.FragmentLifecycleCallbacks() {
                    override fun onFragmentResumed(fm: FragmentManager, f: Fragment) {
                        if (f === gifsDialog) {
                            fragmentManager.unregisterFragmentLifecycleCallbacks(this)
                            (f as? DialogFragment)?.dialog?.window?.let { dialogWindow ->
                                applyDialogBottomInsets(dialogWindow)
                            }
                        }
                    }
                },
                false
            )
        }
        gifsDialog!!.show(fragmentManager, "giphy_view")
        result.success(null)
    }

    private fun applyDialogBottomInsets(dialogWindow: Window) {
        dialogWindow.decorView.post {
            val rootView = dialogWindow.decorView.findViewById<ViewGroup>(android.R.id.content) ?: return@post
            val bottomPadding = ViewCompat.getRootWindowInsets(dialogWindow.decorView)
                ?.getInsets(WindowInsetsCompat.Type.navigationBars())
                ?.bottom ?: 0

            val outerContainer = rootView.getChildAt(0) as? ViewGroup ?: return@post
            outerContainer.updateLayoutParams<ViewGroup.MarginLayoutParams> {
                bottomMargin = 0
            }

            val giphyDialogView = outerContainer.getChildAt(0) as? ViewGroup ?: return@post
            val innerInterceptor = giphyDialogView.getChildAt(0) as? ViewGroup ?: return@post
            val roundedConstraint = innerInterceptor.getChildAt(0) as? ViewGroup ?: return@post
            val mediaTypeView = roundedConstraint.getChildAt(0) ?: return@post

            mediaTypeView.setPadding(
                mediaTypeView.paddingLeft,
                mediaTypeView.paddingTop,
                mediaTypeView.paddingRight,
                bottomPadding
            )
            mediaTypeView.updateLayoutParams<ViewGroup.LayoutParams> {
                height = mediaTypeView.height + bottomPadding
            }
        }
    }

    private fun hide(result: MethodChannel.Result) {
        gifsDialog?.dismiss()
        result.success(null)
    }

    fun setActivity(activity: FragmentActivity?) {
        this.activity = activity
    }

    fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.giphyfluttersdk/dialog")
        channel.setMethodCallHandler(this)
    }

    fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
