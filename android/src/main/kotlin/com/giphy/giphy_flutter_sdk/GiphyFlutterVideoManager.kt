package com.giphy.giphy_flutter_sdk

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class GiphyFlutterVideoManager : MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "muteAll" -> muteAll(result)
            "pauseAll" -> pauseAll(result)
            "resume" -> resume(result)
            else -> result.notImplemented()
        }
    }

    private fun muteAll(result: MethodChannel.Result) {
        GiphyFlutterSharedVideoPlayer.mute()
        result.success(null)
    }

    private fun pauseAll(result: MethodChannel.Result) {
        GiphyFlutterSharedVideoPlayer.pause()
        result.success(null)
    }

    private fun resume(result: MethodChannel.Result) {
        GiphyFlutterSharedVideoPlayer.resume()
        result.success(null)
    }

    fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.giphyfluttersdk/videoManager")
        channel.setMethodCallHandler(this)
    }

    fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}