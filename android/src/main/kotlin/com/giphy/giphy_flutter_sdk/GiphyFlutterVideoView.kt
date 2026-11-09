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
    // The media last asked for, by ID or as an object. A lookup for any other ID is stale.
    private var requestedMediaId: String? = null
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
                            "code" to GiphyFlutterVideoPlaybackState.Playing.code
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
                        channel.invokeMethod("onMute", null)
                    } else {
                        channel.invokeMethod("onUnmute", null)
                    }
                }

                is GPHVideoPlayerState.Unknown -> {
                    channel.invokeMethod(
                        "onPlaybackStateChanged", mapOf(
                            "code" to GiphyFlutterVideoPlaybackState.Unknown.code
                        )
                    )
                }

                else -> {
                }
            }

            if (::view.isInitialized && view.videoPlayer?.paused == true) {
                channel.invokeMethod(
                    "onPlaybackStateChanged", mapOf(
                        "code" to GiphyFlutterVideoPlaybackState.Paused.code
                    )
                )
            }
        } else {
            flutterStateSynchronized = false
        }
    }

    private val pauseListener: (GPHVideoPlayerView) -> Unit = { pausedView ->
        if (::view.isInitialized && pausedView == view) {
            channel.invokeMethod(
                "onPlaybackStateChanged", mapOf(
                    "code" to GiphyFlutterVideoPlaybackState.Paused.code
                )
            )
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
        GiphyFlutterSharedVideoPlayer.addPauseListener(pauseListener)
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
        requestedMediaId = mediaId
        if (mediaId == null) {
            return
        }

        GPHCore.gifById(mediaId) { result, e ->
            // The view may have been disposed, or given other media, while the lookup ran.
            // Loading the media then would start playback that nobody sees.
            if (mediaId != requestedMediaId) {
                return@gifById
            }
            loadedMedia = result?.data ?: return@gifById
            syncMedia()
            e?.let {
                Log.d("Error while fetching GIF: %s", e.localizedMessage)
            }
        }
    }

    private fun setMedia(media: Media?) {
        requestedMediaId = media?.id
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
        // A lookup still running must not load media into this view.
        requestedMediaId = null
        channel.setMethodCallHandler(null)
        GiphyFlutterSharedVideoPlayer.removePauseListener(pauseListener)
        if (::view.isInitialized) {
            // The view can't report anything any more, so stop listening before pausing.
            view.videoPlayer?.removeListener(playerListener)
            if (isViewPlayerActive()) {
                view.videoPlayer?.onPause()
                // Otherwise GiphyFlutterSharedVideoPlayer.resume() would load the media into this disposed view.
                view.videoPlayer?.playerView = null
            }
        }
    }

}