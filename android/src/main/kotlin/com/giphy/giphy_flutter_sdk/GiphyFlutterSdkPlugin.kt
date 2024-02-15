package com.giphy.giphy_flutter_sdk

import android.content.Context
import android.app.Activity
import androidx.fragment.app.FragmentActivity
import com.giphy.giphy_flutter_sdk.utils.require
import com.giphy.giphy_flutter_sdk.dto.GiphyFlutterTheme
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

import com.giphy.sdk.ui.Giphy
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class GiphyFlutterSdkPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {
    private lateinit var context: Context
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private val giphyDialogHandler = GiphyFlutterDialog()

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.giphyfluttersdk")
        channel.setMethodCallHandler(this)

        giphyDialogHandler.onAttachedToEngine(flutterPluginBinding)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "configure") {
            val apiKey = call.argument<String>("apiKey").require("API key is missing")
            val verificationMode = call.argument<Boolean>("verificationMode") ?: false
            val videoCacheMaxBytes = call.argument<Int>("videoCacheMaxBytes") ?: 0
            configureGiphy(apiKey, verificationMode, videoCacheMaxBytes)
            result.success(null)
        } else {
            result.notImplemented()
        }
    }

    private fun configureGiphy(apiKey: String, verificationMode: Boolean, videoCacheMaxBytes: Int) {
        val appInfo = GiphyFlutterSdkInfo(context)
        Giphy.configure(
                context,
                apiKey,
                verificationMode,
                metadata = hashMapOf(appInfo.name to appInfo.version)
        )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        giphyDialogHandler.onDetachedFromEngine(binding)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        giphyDialogHandler.setActivity(activity as? FragmentActivity)
        GiphyFlutterTheme.getInstance().setActivity(activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
        giphyDialogHandler.setActivity(null)
        GiphyFlutterTheme.getInstance().setActivity(null)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        giphyDialogHandler.setActivity(activity as? FragmentActivity)
        GiphyFlutterTheme.getInstance().setActivity(activity)
    }

    override fun onDetachedFromActivity() {
        activity = null
        giphyDialogHandler.setActivity(null)
        GiphyFlutterTheme.getInstance().setActivity(null)
    }
}
