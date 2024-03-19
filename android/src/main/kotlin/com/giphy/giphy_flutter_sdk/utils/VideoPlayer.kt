package com.giphy.giphy_flutter_sdk.utils

import com.giphy.sdk.ui.views.GPHVideoPlayerView
import com.giphy.giphy_flutter_sdk.videoplayeradapter.VIDEO_PLAYER_ADAPTER_STUB_IMPL
import com.giphy.giphy_flutter_sdk.videoplayeradapter.VideoPlayerAdapterImpl

fun getVideoPlayerFactory(): ((GPHVideoPlayerView?, Boolean, Boolean) -> VideoPlayerAdapterImpl)? {
    if (VIDEO_PLAYER_ADAPTER_STUB_IMPL) {
        return null
    }

    return { playerView: GPHVideoPlayerView?, repeatable: Boolean, showCaptions: Boolean ->
        VideoPlayerAdapterImpl(playerView, repeatable, showCaptions)
    }
}