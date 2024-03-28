package com.giphy.giphy_flutter_sdk.videoplayeradapter

import android.content.Context

interface VideoCache {
  fun initialize(context: Context, maxBytes: Long = (100 * 1024 * 1024).toLong()) {}
}

interface FakeVideoCache: VideoCache
