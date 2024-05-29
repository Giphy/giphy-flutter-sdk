package com.giphy.giphy_flutter_sdk

import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.common.StandardMessageCodec
import android.content.Context
import io.flutter.plugin.common.BinaryMessenger

class GiphyFlutterGridViewFactory(private val messenger: BinaryMessenger) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String, Any>?
        return GiphyFlutterGridView(context, messenger, viewId, creationParams)
    }
}