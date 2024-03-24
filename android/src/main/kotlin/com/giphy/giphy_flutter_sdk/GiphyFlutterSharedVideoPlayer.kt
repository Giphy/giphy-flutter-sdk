package com.giphy.giphy_flutter_sdk

import com.giphy.giphy_flutter_sdk.videoplayeradapter.VideoPlayerAdapterImpl

object GiphyFlutterSharedVideoPlayer {
    private val gphPlayerDelegate = lazy {
        VideoPlayerAdapterImpl(null, repeatable = true)
    }
    val gphPlayer by gphPlayerDelegate

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
                gphPlayer.onPause()
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