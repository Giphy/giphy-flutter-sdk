package com.giphy.giphy_flutter_sdk

import android.content.Context
import com.giphyfluttersdk.BuildConfig

class GiphyFlutterSdkInfo(val context: Context) {
    val name = "FlutterSDK"

    val version: String
        get() {
            return BuildConfig.SDK_VERSION
        }
}
