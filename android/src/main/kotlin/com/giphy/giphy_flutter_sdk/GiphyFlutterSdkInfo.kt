package com.giphy.giphy_flutter_sdk

import android.content.Context
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.os.Build

class GiphyFlutterSdkInfo(val context: Context) {
    val name = "FlutterSDK"

    val version: String
        get() {
            var packageInfo: PackageInfo? = null
            try {
                packageInfo =
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                            context.packageManager.getPackageInfo(context.packageName, PackageManager.PackageInfoFlags.of(0))
                        } else {
                            @Suppress("DEPRECATION") context.packageManager.getPackageInfo(context.packageName, 0)
                        }
            } catch (e: PackageManager.NameNotFoundException) {
                e.printStackTrace()
            }

            return packageInfo?.versionName.toString()
        }
}
