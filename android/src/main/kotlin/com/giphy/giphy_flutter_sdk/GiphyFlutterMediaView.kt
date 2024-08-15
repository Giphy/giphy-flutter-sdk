package com.giphy.giphy_flutter_sdk

import android.annotation.SuppressLint
import android.content.Context
import android.util.Log
import android.view.View
import com.facebook.drawee.drawable.ScalingUtils
import com.giphy.giphy_flutter_sdk.dto.GiphyFlutterResizeMode
import com.giphy.giphy_flutter_sdk.dto.GiphyApiException
import com.giphy.giphy_flutter_sdk.dto.toMedia
import com.giphy.giphy_flutter_sdk.dto.toRenditionType
import com.giphy.giphy_flutter_sdk.utils.require
import com.giphy.sdk.core.GPHCore
import com.giphy.sdk.core.models.Media
import com.giphy.sdk.core.models.enums.RenditionType
import com.giphy.sdk.ui.utils.aspectRatio
import com.giphy.sdk.ui.views.GPHMediaView
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView

internal class GiphyFlutterMediaView(
    context: Context?,
    messenger: BinaryMessenger,
    viewId: Int,
    params: Map<String, Any>?
) : PlatformView {
    private val view: GPHMediaView
    private val channel = MethodChannel(messenger, "com.giphyfluttersdk/mediaView$viewId")

    private var loadedMedia: Media? = null
    private var autoPlay: Boolean = true
    private var renditionType = RenditionType.fixedWidth
    private var resizeMode = GiphyFlutterResizeMode.DEFAULT_MODE

    init {
        view = GPHMediaView(context.require("Context must not be null"))
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "setMediaId" -> {
                    setMediaWithId(call.argument<String>("mediaId"))
                    result.success(null)
                }

                "setMedia" -> {
                    setMedia(call.argument<HashMap<String, Any?>>("media")?.toMedia())
                    result.success(null)
                }

                "setAutoPlay" -> {
                    setAutoPlay(call.argument<Boolean?>("autoPlay"))
                    result.success(null)
                }

                "setRenditionType" -> {
                    setRenditionType(call.arguments as? HashMap<String, Any?>)
                    result.success(null)
                }

                "setResizeMode" -> {
                    setResizeMode(call.argument<String?>("resizeMode"))
                    result.success(null)
                }

                "setShowCheckeredBackground" -> {
                    setShowCheckeredBackground(call.argument<Boolean?>("showCheckeredBackground"))
                    result.success(null)
                }

                "pause" -> {
                    view.pause()
                    result.success(null)
                }

                "resume" -> {
                    view.play()
                    result.success(null)
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun setAutoPlay(value: Boolean?) {
        if (value != null) {
            autoPlay = value
        }
    }

    @SuppressLint("LongLogTag")
    private fun setMediaWithId(mediaId: String?) {
        if (mediaId == null) {
            return
        }

        GPHCore.gifById(mediaId) { result, e ->
            loadedMedia = result?.data
            syncMedia()
            e?.let {
                val exception = GiphyApiException(it)
                val errorMessage = exception.errorMessage
                channel.invokeMethod(
                    "onError", mapOf(
                        "error" to exception.errorMessage
                    )
                )
            }
        }
    }

    private fun setMedia(media: Media?) {
        loadedMedia = media
        syncMedia()
    }

    private fun setRenditionType(map: HashMap<String, Any?>?) {
        renditionType = map?.toRenditionType() ?: RenditionType.fixedWidth
        syncMedia()
    }

    private fun setResizeMode(value: String?) {
        resizeMode = GiphyFlutterResizeMode.fromString(value) ?: GiphyFlutterResizeMode.DEFAULT_MODE
        adjustResizeMode()
        syncMedia()
    }

    private fun setShowCheckeredBackground(value: Boolean?) {
        view.isBackgroundVisible = value ?: true
        syncMedia()
    }

    private fun syncMedia() {
        if (loadedMedia != null) {
            view.setMedia(loadedMedia, renditionType)
        }
        view.aspectRatio = loadedMedia?.aspectRatio ?: view.aspectRatio
        if (!autoPlay) {
            view.pause()
        }
    }

    private fun adjustResizeMode() {
        when (resizeMode) {
            GiphyFlutterResizeMode.CENTER -> {
                view.scaleType = ScalingUtils.ScaleType.CENTER_INSIDE
            }

            GiphyFlutterResizeMode.CONTAIN -> {
                view.scaleType = ScalingUtils.ScaleType.FIT_CENTER
            }

            GiphyFlutterResizeMode.COVER -> {
                view.scaleType = ScalingUtils.ScaleType.CENTER_CROP
            }

            GiphyFlutterResizeMode.STRETCH -> {
                view.scaleType = ScalingUtils.ScaleType.FIT_XY
            }
        }
    }

    override fun getView(): View {
        return view
    }

    override fun dispose() {
        view.recycle()
        channel.setMethodCallHandler(null)
    }

}
