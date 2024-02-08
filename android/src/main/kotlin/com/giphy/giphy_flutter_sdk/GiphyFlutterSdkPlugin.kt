package com.giphy.giphy_flutter_sdk

import android.content.Context
import com.giphy.giphy_flutter_sdk.GiphyFlutterSdkInfo
import com.giphy.giphy_flutter_sdk.utils.require
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

import com.giphy.sdk.ui.Giphy

class GiphyFlutterSdkPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
  private lateinit var context: Context
  private lateinit var channel: MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "giphy_flutter_sdk")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if (call.method == "configure") {
      val apiKey = call.argument<String>("apiKey").require("API key is missing")
      val verificationMode = call.argument<Boolean>("verificationMode") ?: false
      val videoCacheMaxBytes = call.argument<Int>("videoCacheMaxBytes") ?: 0
      configureGiphy(apiKey, verificationMode, videoCacheMaxBytes)
      result.success(null)
    } else {
      result.notImplemented()
    }
  }

  private fun configureGiphy(apiKey: String, verificationMode: Boolean, videoCacheMaxBytes: Int) {
    val appInfo = GiphyFlutterSdkInfo(context)
    Giphy.configure(
            context,
            apiKey,
            verificationMode,
            metadata = hashMapOf(appInfo.name to appInfo.version)
    )
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}