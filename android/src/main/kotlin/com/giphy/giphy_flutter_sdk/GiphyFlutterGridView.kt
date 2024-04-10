package com.giphy.giphy_flutter_sdk

import android.content.Context
import android.view.View
import com.giphy.giphy_flutter_sdk.dto.GiphyFlutterTheme
import com.giphy.giphy_flutter_sdk.dto.toHashMap
import com.giphy.giphy_flutter_sdk.dto.toRating
import com.giphy.giphy_flutter_sdk.dto.toRenditionType
import com.giphy.giphy_flutter_sdk.utils.require
import com.giphy.sdk.core.models.Media
import com.giphy.sdk.core.models.enums.MediaType
import com.giphy.sdk.core.models.enums.RatingType
import com.giphy.sdk.core.models.enums.RenditionType
import com.giphy.sdk.ui.GPHRequestType
import com.giphy.sdk.ui.pagination.GPHContent
import com.giphy.sdk.ui.views.GPHGridCallback
import com.giphy.sdk.ui.views.GPHSearchGridCallback
import com.giphy.sdk.ui.views.GifView
import com.giphy.sdk.ui.views.GiphyGridView
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView

internal class GiphyFlutterGridView(
    context: Context?,
    messenger: BinaryMessenger,
    viewId: Int,
    params: Map<String, Any>?
) : PlatformView {
    private val view: GiphyGridView
    private val channel = MethodChannel(messenger, "com.giphyfluttersdk/gridView$viewId")
    
    init {
        view = GiphyGridView(context.require("Context must not be null"))
        view.callback = object : GPHGridCallback {
            override fun contentDidUpdate(resultCount: Int) {
                channel.invokeMethod(
                    "onContentUpdate", mapOf(
                        "resultCount" to resultCount
                    )
                )
            }

            override fun didSelectMedia(media: Media) {
                channel.invokeMethod(
                    "onMediaSelect", mapOf(
                        "media" to media.toHashMap()
                    )
                )
            }
        }

        view.searchCallback = object : GPHSearchGridCallback {
            override fun didTapUsername(username: String) {
                // pass
            }

            override fun didLongPressCell(cell: GifView) {
                // pass
            }

            override fun didScroll(dx: Int, dy: Int) {
                channel.invokeMethod(
                    "onScroll", mapOf(
                        "offset" to dy.toDouble()
                    )
                )
            }
        }

        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "setContent" -> {
                    call.argument<HashMap<String, Any?>>("content")?.let {
                        setContent(it)
                    }
                    result.success(null)
                }

                "setCellPadding" -> {
                    setCellPadding(call.argument<Double>("cellPadding"))
                    result.success(null)
                }

                "setDisableEmojiVariations" -> {
                    setDisableEmojiVariations(call.argument<Boolean>("disableEmojiVariations"))
                    result.success(null)
                }

                "setFixedSizeCells" -> {
                    setFixedSizeCells(call.argument<Boolean>("fixedSizeCells"))
                    result.success(null)
                }

                "setOrientation" -> {
                    setOrientation(call.argument<String>("orientation"))
                    result.success(null)
                }

                "setSpanCount" -> {
                    setSpanCount(call.argument<Int>("spanCount"))
                    result.success(null)
                }

                "setRenditionType" -> {
                    setRenditionType(call.arguments as? HashMap<String, Any?>)
                    result.success(null)
                }

                "setClipsPreviewRenditionType" -> {
                    setClipsPreviewRenditionType(call.arguments as? HashMap<String, Any?>)
                    result.success(null)
                }

                "setShowCheckeredBackground" -> {
                    setShowCheckeredBackground(call.argument<Boolean>("showCheckeredBackground"))
                    result.success(null)
                }

                "setTheme" -> {
                    setTheme(call.arguments as? HashMap<String, Any?>)
                    result.success(null)
                }

                else -> result.success(null)//result.notImplemented()
            }
        }
    }

    private fun setContent(value: HashMap<String, Any?>) {
        val content = GPHContent()

        val requestType = (value["requestType"] as? String)
        if (requestType != null) {
            content.requestType = GPHRequestType.values().firstOrNull { it.name == requestType }
                ?: GPHRequestType.search

            if (content.requestType == GPHRequestType.recents) {
                view.content = GPHContent.recents
                return
            }
        }
        content.rating = value.toRating() ?: RatingType.pg13

        (value["searchQuery"] as? String)?.let {
            content.searchQuery = it
        }

        (value["mediaType"] as? String)?.let {
            content.mediaType = MediaType.valueOf(it)
        }

        view.content = content
    }

    private fun setCellPadding(value: Double?) {
        if (value != null) {
            view.cellPadding = value.toInt()
        }
    }

    private fun setDisableEmojiVariations(value: Boolean?) {
        if (value != null) {
            view.disableEmojiVariations = value
        }
    }

    private fun setFixedSizeCells(value: Boolean?) {
        if (value != null) {
            view.fixedSizeCells = value
        }
    }

    private fun setOrientation(value: String?) {
        view.direction = when (value) {
            "horizontal" -> GiphyGridView.HORIZONTAL
            "vertical" -> GiphyGridView.VERTICAL
            else -> GiphyGridView.VERTICAL
        }
    }

    private fun setSpanCount(value: Int?) {
        if (value != null) {
            view.spanCount = value
        }
    }

    private fun setRenditionType(map: HashMap<String, Any?>?) {
        view.renditionType = map?.toRenditionType() ?: RenditionType.fixedWidth
    }

    private fun setClipsPreviewRenditionType(map: HashMap<String, Any?>?) {
        view.clipsPreviewRenditionType = map?.toRenditionType() ?: RenditionType.fixedWidth
    }

    private fun setShowCheckeredBackground(value: Boolean?) {
        view.showCheckeredBackground = value ?: false
    }

    private fun setTheme(map: HashMap<String, Any?>?) {
        val value = map ?: return
        view.theme =
            GiphyFlutterTheme.getInstance().toGPHTheme(value["theme"] as HashMap<String, Any?>)
    }

    override fun getView(): View {
        return view
    }

    override fun dispose() {
        channel.setMethodCallHandler(null)
        view.callback = null
        view.searchCallback = null
    }

}
