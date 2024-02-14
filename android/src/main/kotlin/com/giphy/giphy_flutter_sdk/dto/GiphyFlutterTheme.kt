package com.giphy.giphy_flutter_sdk.dto

import android.graphics.Color
import com.giphy.sdk.ui.themes.GPHCustomTheme
import com.giphy.sdk.ui.themes.GPHTheme
import android.app.Activity
import android.content.res.Configuration

fun String.toGPHTheme(): GPHTheme {
    return GPHTheme.values().first { it.name.equals(this, ignoreCase = true) }
}

class GiphyFlutterTheme private constructor() {

    private var activity: Activity? = null
    fun setActivity(activity: Activity?) {
        this.activity = activity
    }

    fun toGPHTheme(hashMap: HashMap<String, Any?>): GPHTheme {
        var theme = (hashMap["preset"] as? String ?: "automatic").toGPHTheme()

        val currentNightMode = activity?.let {
            it.resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK
        }
        val lightMode =
            (listOf(Configuration.UI_MODE_NIGHT_NO, Configuration.UI_MODE_NIGHT_UNDEFINED).contains(
                currentNightMode
            ))

        fun GPHCustomTheme.applyColorProperty(
            propertyName: String,
            applyProperty: GPHCustomTheme.(Int) -> Unit
        ) {
            (hashMap[propertyName] as? Long)?.let { colorLong ->
                applyProperty(colorLong.toInt())
            }
        }

        GPHCustomTheme.apply {
            if ((theme == GPHTheme.Automatic && lightMode) || theme == GPHTheme.Light) {
                applyLightThemeProps();
            } else if ((theme == GPHTheme.Automatic && !lightMode) || theme == GPHTheme.Dark) {
                applyDarkThemeProps();
            }
            theme = GPHTheme.Custom

            applyColorProperty("handleBarColor") { handleBarColor = it }
            applyColorProperty("emojiDrawerGradientBottomColor") { emojiDrawerGradientBottomColor = it }
            applyColorProperty("emojiDrawerGradientTopColor") { emojiDrawerGradientTopColor = it }
            applyColorProperty("emojiDrawerSeparatorColor") { emojiDrawerSeparatorColor = it }
            applyColorProperty("searchBackButtonColor") { searchBackButtonColor = it }
            applyColorProperty("searchBarBackgroundColor") { searchBarBackgroundColor = it }
            applyColorProperty("searchPlaceholderTextColor") { searchPlaceholderTextColor = it }
            applyColorProperty("searchTextColor") { searchTextColor = it }
            applyColorProperty("suggestionCellBackgroundColor") { suggestionCellBackgroundColor = it }
            applyColorProperty("suggestionCellTextColor") { suggestionCellTextColor = it }
            applyColorProperty("tabBarSwitchDefaultColor") { tabBarSwitchDefaultColor = it }
            applyColorProperty("tabBarSwitchSelectedColor") { tabBarSwitchSelectedColor = it }
            applyColorProperty("confirmationBackButtonColor") { confirmationBackButtonColor = it }
            applyColorProperty("confirmationSelectButtonColor") { confirmationSelectButtonColor = it }
            applyColorProperty("confirmationSelectButtonTextColor") { confirmationSelectButtonTextColor = it }
            applyColorProperty("confirmationViewOnGiphyColor") { confirmationViewOnGiphyColor = it }
            applyColorProperty("usernameColor") { usernameColor = it }
            applyColorProperty("backgroundColor") { backgroundColor = it }
            applyColorProperty("defaultTextColor") { defaultTextColor = it }
            applyColorProperty("dialogOverlayBackgroundColor") { dialogOverlayBackgroundColor = it }
            applyColorProperty("retryButtonBackgroundColor") { retryButtonBackgroundColor = it }
            applyColorProperty("retryButtonTextColor") { retryButtonTextColor = it }
        }

        return theme
    }

    companion object {
        @Volatile
        private var instance: GiphyFlutterTheme? = null

        fun getInstance(): GiphyFlutterTheme =
            instance ?: synchronized(this) {
                instance ?: GiphyFlutterTheme().also { instance = it }
            }
    }
}
