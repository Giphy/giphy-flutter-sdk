package com.giphy.giphy_flutter_sdk

import com.giphy.giphy_flutter_sdk.videoplayeradapter.VideoPlayerAdapterImpl
import com.giphy.sdk.ui.views.GPHVideoPlayerView

object GiphyFlutterSharedVideoPlayer {
    private val gphPlayerDelegate = lazy {
        VideoPlayerAdapterImpl(null, repeatable = true)
    }
    val gphPlayer by gphPlayerDelegate

    // The SDK's onPause() releases the player instead of pausing it, so no player
    // event reports the pause. Video views listen here to report it to Flutter.
    private val pauseListeners = mutableSetOf<(GPHVideoPlayerView) -> Unit>()

    fun addPauseListener(listener: (GPHVideoPlayerView) -> Unit) {
        pauseListeners.add(listener)
    }

    fun removePauseListener(listener: (GPHVideoPlayerView) -> Unit) {
        pauseListeners.remove(listener)
    }

    fun mute() {
        if (gphPlayerDelegate.isInitialized() && gphPlayer.playerView != null) {
            gphPlayer.runInPlayerApplicationLooper {
                gphPlayer.setVolume(0f)
            }
        }
    }

    fun pause() {
        if (gphPlayerDelegate.isInitialized() && gphPlayer.playerView != null) {
            gphPlayer.runInPlayerApplicationLooper {
                // Take the view before pausing: releasing the player may clear it.
                val pausedView = gphPlayer.playerView
                gphPlayer.onPause()
                if (pausedView != null) {
                    pauseListeners.toList().forEach { it(pausedView) }
                }
            }
        }
    }

    fun resume() {
        if (gphPlayerDelegate.isInitialized() && gphPlayer.playerView != null) {
            gphPlayer.runInPlayerApplicationLooper {
                gphPlayer.onResume()
            }
        }
    }
}
