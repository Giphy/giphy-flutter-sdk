@file:Suppress("UNCHECKED_CAST")

package com.giphy.giphy_flutter_sdk.dto

import com.giphy.sdk.core.models.Asset
import com.giphy.sdk.core.models.Assets
import com.giphy.sdk.core.models.Image
import com.giphy.sdk.core.models.Images
import com.giphy.sdk.core.models.Media
import com.giphy.sdk.core.models.User
import com.giphy.sdk.core.models.Video
import com.giphy.sdk.core.models.enums.MediaType
import com.giphy.sdk.core.models.enums.RatingType
import com.giphy.sdk.core.models.enums.RenditionType
import com.giphy.sdk.ui.utils.aspectRatio
import java.text.ParseException
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.TimeZone

// region Media

val dateFormat = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'", Locale.US).apply {
    timeZone = TimeZone.getTimeZone("UTC")
}

fun Media.toHashMap(): HashMap<String, Any?> {
    return hashMapOf(
        "id" to this.id,
        "type" to this.type?.name,
        "slug" to this.slug,
        "url" to this.url,
        "bitlyGifUrl" to this.bitlyGifUrl,
        "bitlyUrl" to this.bitlyUrl,
        "embedUrl" to this.embedUrl,
        "source" to this.source,
        "title" to this.title,
        "rating" to this.rating?.name,
        "contentUrl" to this.contentUrl,
        "tags" to this.tags,
        "featuredTags" to this.featuredTags,
        "user" to this.user?.toHashMap(),
        "images" to this.images.toHashMap(),
        "video" to this.video?.toHashMap(),
        "analyticsResponsePayload" to this.analyticsResponsePayload,
        "sourceTld" to this.sourceTld,
        "sourcePostUrl" to this.sourcePostUrl,
        "updateDate" to this.updateDate?.let { dateFormat.format(it) },
        "createDate" to this.createDate?.let { dateFormat.format(it) },
        "importDate" to this.importDate?.let { dateFormat.format(it) },
        "trendingDate" to this.trendingDate?.let { dateFormat.format(it) },
        "isHidden" to this.isHidden,
        "isRemoved" to this.isRemoved,
        "isCommunity" to this.isCommunity,
        "isAnonymous" to this.isAnonymous,
        "isFeatured" to this.isFeatured,
        "isRealtime" to this.isRealtime,
        "isIndexable" to this.isIndexable,
        "isSticker" to this.isSticker,
        "isDynamic" to this.isDynamic,
        "isVideo" to (this.type == MediaType.video),
        "animatedTextStyle" to this.animatedTextStyle,
        "hasAttributions" to this.hasAttributions,
        "altText" to this.altText,
        "variation" to this.variation,
        "variationCount" to this.variationCount,
        "aspectRatio" to this.aspectRatio,
        "userDictionary" to this.userDictionary
    )
}

fun HashMap<String, Any?>.toMediaType(): MediaType? =
    (this["type"] as? String)?.let { MediaType.valueOf(it) }

fun HashMap<String, Any?>.toRating(): RatingType? =
    (this["rating"] as? String)?.let { RatingType.valueOf(it) }

fun HashMap<String, Any?>.toMedia(): Media {
    fun parseDate(key: String): Date? = this[key]?.let {
        try {
            dateFormat.parse(it as String)
        } catch (e: ParseException) {
            null
        }
    }

    return Media(id = this["id"] as? String ?: "",
        type = this.toMediaType(),
        slug = this["slug"] as? String,
        url = this["url"] as? String,
        bitlyGifUrl = this["bitlyGifUrl"] as? String,
        bitlyUrl = this["bitlyUrl"] as? String,
        embedUrl = this["embedUrl"] as? String,
        source = this["source"] as? String,
        title = this["title"] as? String,
        rating = this.toRating(),
        contentUrl = this["contentUrl"] as? String,
        tags = this["tags"] as? List<String>,
        featuredTags = this["featuredTags"] as? List<String>,
        user = (this["user"] as? HashMap<String, Any?>)?.toUser(),
        images = (this["images"] as? HashMap<String, Any?>)?.toImages() ?: Images(),
        video = (this["video"] as? HashMap<String, Any?>)?.toVideo(),
        analyticsResponsePayload = this["analyticsResponsePayload"] as? String,
        sourceTld = this["sourceTld"] as? String,
        sourcePostUrl = this["sourcePostUrl"] as? String,
        updateDate = parseDate("updateDate"),
        createDate = parseDate("createDate"),
        importDate = parseDate("importDate"),
        trendingDate = parseDate("trendingDate"),
        isHidden = this["isHidden"] as? Boolean ?: false,
        isRemoved = this["isRemoved"] as? Boolean ?: false,
        isCommunity = this["isCommunity"] as? Boolean ?: false,
        isAnonymous = this["isAnonymous"] as? Boolean ?: false,
        isFeatured = this["isFeatured"] as? Boolean ?: false,
        isRealtime = this["isRealtime"] as? Boolean ?: false,
        isIndexable = this["isIndexable"] as? Boolean ?: false,
        isSticker = this["isSticker"] as? Boolean ?: false,
        isDynamic = this["isDynamic"] as? Boolean ?: false,
        animatedTextStyle = this["animatedTextStyle"] as? String,
        hasAttributions = this["hasAttributions"] as? Boolean ?: false,
        altText = this["altText"] as? String,
        variation = this["variation"] as? String,
        variationCount = this["variationCount"] as? Int,
        userDictionary = (this["userDictionary"] as? Map<String, Any?>)?.mapValues { it.value.toString() }
            ?.let { HashMap(it) })
}

// endregion

// region User
fun User.toHashMap(): HashMap<String, Any?> {
    return hashMapOf(
        "id" to this.id,
        "avatarUrl" to this.avatarUrl,
        "avatar" to this.avatar,
        "bannerUrl" to this.bannerUrl,
        "bannerImage" to this.bannerImage,
        "profileUrl" to this.profileUrl,
        "username" to this.username,
        "displayName" to this.displayName,
        "email" to this.email,
        "twitter" to this.twitter,
        "isPublic" to this.isPublic,
        "attributionDisplayName" to this.attributionDisplayName,
        "name" to this.name,
        "description" to this.description,
        "aboutBio" to this.aboutBio,
        "facebookUrl" to this.facebookUrl,
        "twitterUrl" to this.twitterUrl,
        "instagramUrl" to this.instagramUrl,
        "tumblrUrl" to this.tumblrUrl,
        "tiktokUrl" to this.tiktokUrl,
        "youtubeUrl" to this.youtubeUrl,
        "isSuppressChrome" to this.isSuppressChrome,
        "websiteUrl" to this.websiteUrl,
        "websiteDisplayUrl" to this.websiteDisplayUrl,
        "verified" to this.verified,
        "isStaff" to this.isStaff,
        "userType" to this.userType
    )
}

fun HashMap<String, Any?>.toUser(): User {
    return User(
        id = this["id"] as? String ?: "",
        avatarUrl = this["avatarUrl"] as? String,
        avatar = this["avatar"] as? String,
        bannerUrl = this["bannerUrl"] as? String,
        bannerImage = this["bannerImage"] as? String,
        profileUrl = this["profileUrl"] as? String,
        username = this["username"] as? String ?: "",
        displayName = this["displayName"] as? String,
        email = this["email"] as? String,
        twitter = this["twitter"] as? String,
        isPublic = this["isPublic"] as? Boolean ?: false,
        attributionDisplayName = this["attributionDisplayName"] as? String,
        name = this["name"] as? String,
        description = this["description"] as? String,
        aboutBio = this["aboutBio"] as? String,
        facebookUrl = this["facebookUrl"] as? String,
        twitterUrl = this["twitterUrl"] as? String,
        instagramUrl = this["instagramUrl"] as? String,
        tumblrUrl = this["tumblrUrl"] as? String,
        tiktokUrl = this["tiktokUrl"] as? String,
        youtubeUrl = this["youtubeUrl"] as? String,
        isSuppressChrome = this["isSuppressChrome"] as? Boolean ?: false,
        websiteUrl = this["websiteUrl"] as? String,
        websiteDisplayUrl = this["websiteDisplayUrl"] as? String,
        verified = this["verified"] as? Boolean ?: false,
        isStaff = this["isStaff"] as? Boolean ?: false,
        userType = this["userType"] as? String
    )
}

// endregion

// region Images
fun Image.toHashMap(): HashMap<String, Any?> {
    return hashMapOf(
        "gifUrl" to this.gifUrl,
        "width" to this.width,
        "height" to this.height,
        "gifSize" to this.gifSize,
        "frames" to this.frames,
        "mp4Url" to this.mp4Url,
        "mp4Size" to this.mp4Size,
        "webPUrl" to this.webPUrl,
        "webPSize" to this.webPSize,
        "mediaId" to this.mediaId,
        "renditionType" to this.renditionType?.name
    )
}

fun HashMap<String, Any?>.toRenditionType(): RenditionType? =
    (this["renditionType"] as? String)?.let { RenditionType.valueOf(it) }

fun HashMap<String, Any?>.toImage(): Image {
    return Image(
        gifUrl = this["gifUrl"] as? String ?: "",
        width = this["width"] as? Int ?: 0,
        height = this["height"] as? Int ?: 0,
        gifSize = this["gifSize"] as? Int ?: 0,
        frames = this["frames"] as? Int ?: 0,
        mp4Url = this["mp4Url"] as? String,
        mp4Size = this["mp4Size"] as? Int ?: 0,
        webPUrl = this["webPUrl"] as? String,
        webPSize = this["webPSize"] as? Int ?: 0,
        mediaId = this["mediaId"] as? String,
        renditionType = this.toRenditionType()
    )
}

fun Images.toHashMap(): HashMap<String, Any?> {
    val map = hashMapOf<String, Any?>(
        "mediaId" to this.mediaId
    )
    this.fixedHeight?.let { map["fixedHeight"] = it.toHashMap() }
    this.fixedHeightStill?.let { map["fixedHeightStill"] = it.toHashMap() }
    this.fixedHeightDownsampled?.let { map["fixedHeightDownsampled"] = it.toHashMap() }
    this.fixedWidth?.let { map["fixedWidth"] = it.toHashMap() }
    this.fixedWidthStill?.let { map["fixedWidthStill"] = it.toHashMap() }
    this.fixedWidthDownsampled?.let { map["fixedWidthDownsampled"] = it.toHashMap() }
    this.fixedHeightSmall?.let { map["fixedHeightSmall"] = it.toHashMap() }
    this.fixedHeightSmallStill?.let { map["fixedHeightSmallStill"] = it.toHashMap() }
    this.fixedWidthSmall?.let { map["fixedWidthSmall"] = it.toHashMap() }
    this.fixedWidthSmallStill?.let { map["fixedWidthSmallStill"] = it.toHashMap() }
    this.downsized?.let { map["downsized"] = it.toHashMap() }
    this.downsizedStill?.let { map["downsizedStill"] = it.toHashMap() }
    this.downsizedLarge?.let { map["downsizedLarge"] = it.toHashMap() }
    this.downsizedMedium?.let { map["downsizedMedium"] = it.toHashMap() }
    this.original?.let { map["original"] = it.toHashMap() }
    this.originalStill?.let { map["originalStill"] = it.toHashMap() }
    this.looping?.let { map["looping"] = it.toHashMap() }
    this.preview?.let { map["preview"] = it.toHashMap() }
    this.downsizedSmall?.let { map["downsizedSmall"] = it.toHashMap() }

    return map
}

fun HashMap<String, Any?>.toImages(): Images {
    return Images(
        mediaId = this["mediaId"] as? String ?: "",
        fixedHeight = (this["fixedHeight"] as? HashMap<String, Any?>)?.toImage(),
        fixedHeightStill = (this["fixedHeightStill"] as? HashMap<String, Any?>)?.toImage(),
        fixedHeightDownsampled = (this["fixedHeightDownsampled"] as? HashMap<String, Any?>)?.toImage(),
        fixedWidth = (this["fixedWidth"] as? HashMap<String, Any?>)?.toImage(),
        fixedWidthStill = (this["fixedWidthStill"] as? HashMap<String, Any?>)?.toImage(),
        fixedWidthDownsampled = (this["fixedWidthDownsampled"] as? HashMap<String, Any?>)?.toImage(),
        fixedHeightSmall = (this["fixedHeightSmall"] as? HashMap<String, Any?>)?.toImage(),
        fixedHeightSmallStill = (this["fixedHeightSmallStill"] as? HashMap<String, Any?>)?.toImage(),
        fixedWidthSmall = (this["fixedWidthSmall"] as? HashMap<String, Any?>)?.toImage(),
        fixedWidthSmallStill = (this["fixedWidthSmallStill"] as? HashMap<String, Any?>)?.toImage(),
        downsized = (this["downsized"] as? HashMap<String, Any?>)?.toImage(),
        downsizedStill = (this["downsizedStill"] as? HashMap<String, Any?>)?.toImage(),
        downsizedLarge = (this["downsizedLarge"] as? HashMap<String, Any?>)?.toImage(),
        downsizedMedium = (this["downsizedMedium"] as? HashMap<String, Any?>)?.toImage(),
        original = (this["original"] as? HashMap<String, Any?>)?.toImage(),
        originalStill = (this["originalStill"] as? HashMap<String, Any?>)?.toImage(),
        looping = (this["looping"] as? HashMap<String, Any?>)?.toImage(),
        preview = (this["preview"] as? HashMap<String, Any?>)?.toImage(),
        downsizedSmall = (this["downsizedSmall"] as? HashMap<String, Any?>)?.toImage()
    )
}


// endregion

// region Video

fun Asset.toHashMap(): HashMap<String, Any?> {
    return hashMapOf(
        "width" to this.width, "height" to this.height, "url" to this.url, "format" to this.format
    )
}

fun HashMap<String, Any?>.toAsset(): Asset {
    return Asset(
        width = this["width"] as? Int ?: 0,
        height = this["height"] as? Int ?: 0,
        url = this["url"] as? String ?: "",
        format = this["format"] as? String
    )
}


fun Assets.toHashMap(): HashMap<String, Any?> {
    val map = hashMapOf<String, Any?>()

    this.source?.let { map["source"] = it.toHashMap() }
    this.size360p?.let { map["360p"] = it.toHashMap() }
    this.size480p?.let { map["480p"] = it.toHashMap() }
    this.size720p?.let { map["720p"] = it.toHashMap() }
    this.size1080p?.let { map["1080p"] = it.toHashMap() }
    this.size4k?.let { map["4k"] = it.toHashMap() }

    return map
}

fun HashMap<String, Any?>.toAssets(): Assets {
    return Assets(
        source = (this["source"] as? HashMap<String, Any?>)?.toAsset(),
        size360p = (this["360p"] as? HashMap<String, Any?>)?.toAsset(),
        size480p = (this["480p"] as? HashMap<String, Any?>)?.toAsset(),
        size720p = (this["720p"] as? HashMap<String, Any?>)?.toAsset(),
        size1080p = (this["1080p"] as? HashMap<String, Any?>)?.toAsset(),
        size4k = (this["4k"] as? HashMap<String, Any?>)?.toAsset()
    )
}


fun Video.toHashMap(): HashMap<String, Any?> {
    val map = hashMapOf<String, Any?>(
        "duration" to this.duration
    )
    this.assets?.let { map["assets"] = it.toHashMap() }
    return map
}

fun HashMap<String, Any?>.toVideo(): Video {
    return Video(
        duration = this["duration"] as? Float ?: 0f,
        assets = (this["assets"] as? HashMap<String, Any?>)?.toAssets()
    )
}


// endregion
