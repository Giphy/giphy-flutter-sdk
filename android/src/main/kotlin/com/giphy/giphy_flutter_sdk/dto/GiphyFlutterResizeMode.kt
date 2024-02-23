package com.giphy.giphy_flutter_sdk.dto

enum class GiphyFlutterResizeMode {
    CENTER,
    CONTAIN,
    COVER,
    STRETCH;

    companion object {
        val DEFAULT_MODE = COVER

        fun fromString(value: String?): GiphyFlutterResizeMode? {
            return when (value) {
                "center" -> CENTER
                "contain" -> CONTAIN
                "cover" -> COVER
                "stretch" -> STRETCH
                else -> null
            }
        }
    }
}