package com.giphy.giphy_flutter_sdk

import android.content.Context
import android.util.Log
import android.view.View
import com.giphy.giphy_flutter_sdk.dto.GiphyFlutterVideoPlaybackState
import com.giphy.giphy_flutter_sdk.dto.toMedia
import com.giphy.giphy_flutter_sdk.utils.require
import com.giphy.sdk.core.GPHCore
import com.giphy.sdk.core.models.Media
import com.giphy.sdk.ui.utils.GPHAbstractVideoPlayer
import com.giphy.sdk.ui.utils.GPHPlayerStateListener
import com.giphy.sdk.ui.utils.GPHVideoPlayerState
import com.giphy.sdk.ui.views.GPHVideoPlayerView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

internal class GiphyFlutterVideoView(
    context: Context?,
    messenger: BinaryMessenger,
    viewId: Int,
    params: Map<String, Any>?
) : PlatformView {
    private lateinit var view: GPHVideoPlayerView
    private val channel = MethodChannel(messenger, "com.giphyfluttersdk/videoView$viewId")

    private var loadedMedia: Media? = null
    private var autoPlay: Boolean = true
    private var muted = false
    private var flutterStateSynchronized = false

    private val playerListener: GPHPlayerStateListener = {
        if (isViewPlayerActive()) {
            when (it) {
                is GPHVideoPlayerState.Ready -> {
                    syncFlutterState()
                    channel.invokeMethod(
                        "onPlaybackStateChanged", mapOf(
                            "code" to GiphyFlutterVideoPlaybackState.ReadyToPlay.code
                        )
                    )
                }

                is GPHVideoPlayerState.Playing -> {
                    channel.invokeMethod(
                        "onPlaybackStateChanged", mapOf(
                            "state" to GiphyFlutterVideoPlaybackState.Playing.code
                        )
                    )
                }

                is GPHVideoPlayerState.Error -> {
                    channel.invokeMethod(
                        "onError", mapOf(
                            "error" to it.details
                        )
                    )
                }

                is GPHVideoPlayerState.MuteChanged -> {
                    if (it.muted) {
                        channel.invokeMethod("onUnmute", null)
                    } else {
                        channel.invokeMethod("onMute", null)
                    }
                }

                is GPHVideoPlayerState.Unknown -> {
                    channel.invokeMethod(
                        "onPlaybackStateChanged", mapOf(
                            "state" to GiphyFlutterVideoPlaybackState.Unknown.code
                        )
                    )
                }

                else -> {
                }
            }

            if (::view.isInitialized && view.videoPlayer?.paused == true) {
                channel.invokeMethod(
                    "onPlaybackStateChanged", mapOf(
                        "state" to GiphyFlutterVideoPlaybackState.Paused.code
                    )
                )
            }
        } else {
            flutterStateSynchronized = false
        }
    }

    init {
        view = object : GPHVideoPlayerView(context.require("Context must not be null")) {
            override fun didBecomeActiveByClick() {
                super.didBecomeActiveByClick()
                this@GiphyFlutterVideoView.muted = false
            }

            override fun prepare(media: Media, player: GPHAbstractVideoPlayer) {
                super.prepare(media, player)
                videoPlayer?.addListener(playerListener)
            }
        }
        view.videoPlayer = GiphyFlutterSharedVideoPlayer.gphPlayer
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

                "setMuted" -> {
                    muted = call.argument<Boolean?>("muted") ?: false
                    setMuted(muted)
                    result.success(null)
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun setAutoPlay(value: Boolean?) {
        if (value == autoPlay) {
            return
        }
        autoPlay = value ?: false
        if (::view.isInitialized && isViewPlayerActive()) {
            if (!autoPlay) {
                view.videoPlayer?.onPause()
            }
        }
    }

    fun setMuted(value: Boolean?) {
        if (value == muted) {
            return
        }
        muted = value ?: false
        updateVolume()
    }

    private fun setMediaWithId(mediaId: String?) {
        if (mediaId == null) {
            return
        }

        GPHCore.gifById(mediaId) { result, e ->
            loadedMedia = result?.data ?: return@gifById
            syncMedia()
            e?.let {
                Log.d("Error while fetching GIF: %s", e.localizedMessage)
            }
        }
    }

    private fun setMedia(media: Media?) {
        loadedMedia = media
        syncMedia()
    }

    private fun syncMedia() {
        if (::view.isInitialized && loadedMedia != null ) {
            view.preloadFirstFrame(loadedMedia!!)
            GiphyFlutterSharedVideoPlayer.gphPlayer.loadMedia(
                loadedMedia!!,
                view = view,
                autoPlay = this.autoPlay
            )
        }
    }

    private fun syncFlutterState() {
        if (flutterStateSynchronized) {
            return
        }
        updateVolume()
        flutterStateSynchronized = true
    }

    private fun isViewPlayerActive(): Boolean {
        return (::view.isInitialized && view.videoPlayer?.playerView == this.view)
    }

    private fun updateVolume() {
        if (!isViewPlayerActive()) {
            return
        }

        if (::view.isInitialized && muted) {
            if (view.videoPlayer?.getVolume() != 0f) view.videoPlayer?.setVolume(0f)
        } else {
            if (view.videoPlayer?.getVolume() != 1f) view.videoPlayer?.setVolume(1f)
        }
    }

    override fun getView(): View {
        return view
    }

    override fun dispose() {
        channel.setMethodCallHandler(null)
        if (isViewPlayerActive()) {
            if (::view.isInitialized) {
                view.videoPlayer?.onPause()
            }
        }
        if (::view.isInitialized) {
            view.videoPlayer?.removeListener(playerListener)
        }
    }

}