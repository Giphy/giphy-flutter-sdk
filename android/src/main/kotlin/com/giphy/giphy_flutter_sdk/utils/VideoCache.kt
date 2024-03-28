package com.giphy.giphy_flutter_sdk.utils

import android.content.Context
import com.giphy.giphy_flutter_sdk.videoplayeradapter.VideoCacheImpl
import com.giphy.giphy_flutter_sdk.videoplayeradapter.VideoCache

fun initializeVideoCache(context: Context, maxBytes: Long): VideoCacheImpl? {
    @Suppress("USELESS_IS_CHECK")
    if (maxBytes > 0 && VideoCacheImpl is VideoCache) {
        VideoCacheImpl.initialize(context, maxBytes)
        return VideoCacheImpl
    }

    return null
}