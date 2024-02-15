package com.giphy.giphy_flutter_sdk.dto

import com.giphy.sdk.core.models.enums.RatingType
import com.giphy.sdk.core.models.enums.RenditionType
import com.giphy.sdk.ui.GPHContentType
import com.giphy.sdk.ui.GPHSettings
import com.giphy.sdk.ui.drawables.ImageFormat
import com.giphy.sdk.ui.themes.GPHTheme

fun HashMap<String, Any?>.toGPHSettings(): GPHSettings {
    return GPHSettings(
        theme = GiphyFlutterTheme.getInstance().toGPHTheme(this["theme"] as HashMap<String, Any?>),
        mediaTypeConfig = (this["mediaTypeConfig"] as? List<*>)?.mapNotNull { it as? String }
            ?.map { it.toGPHContentType() }?.toTypedArray() ?: arrayOf(
            GPHContentType.recents,
            GPHContentType.gif,
            GPHContentType.sticker,
            GPHContentType.text,
            GPHContentType.emoji,
            GPHContentType.clips
        ),
        showConfirmationScreen = this["showConfirmationScreen"] as? Boolean ?: false,
        showAttribution = this["showAttribution"] as? Boolean ?: true,
        rating = (this["rating"] as? String)?.toRatingType() ?: RatingType.pg13,
        renditionType = (this["renditionType"] as? String)?.toRenditionType(),
        clipsPreviewRenditionType = (this["clipsPreviewRenditionType"] as? String)?.toRenditionType(),
        confirmationRenditionType = (this["confirmationRenditionType"] as? String)?.toRenditionType(),
        showCheckeredBackground = this["showCheckeredBackground"] as? Boolean ?: false,
        stickerColumnCount = this["stickerColumnCount"] as? Int ?: 2,
        selectedContentType = (this["selectedContentType"] as? String)?.toGPHContentType()
            ?: GPHContentType.gif,
        showSuggestionsBar = this["showSuggestionsBar"] as? Boolean ?: true,
        suggestionsBarFixedPosition = this["suggestionsBarFixedPosition"] as? Boolean ?: false,
        enableDynamicText = this["enableDynamicText"] as? Boolean ?: false,
        enablePartnerProfiles = this["enablePartnerProfiles"] as? Boolean ?: true,
        imageFormat = (this["fileFormat"] as? String)?.toImageFormat() ?: ImageFormat.WEBP,
        disableEmojiVariations = this["disableEmojiVariations"] as? Boolean ?: false
    )
}

fun String.toGPHContentType(): GPHContentType {
    return GPHContentType.values().first { it.name.equals(this, ignoreCase = true) }
}

fun String.toRatingType(): RatingType {
    return RatingType.values().first { it.name.equals(this, ignoreCase = true) }
}

fun String.toRenditionType(): RenditionType? {
    return RenditionType.values().firstOrNull() { it.name.equals(this, ignoreCase = true) }
}

fun String.toImageFormat(): ImageFormat {
    return ImageFormat.values().first { it.name.equals(this, ignoreCase = true) }
}
