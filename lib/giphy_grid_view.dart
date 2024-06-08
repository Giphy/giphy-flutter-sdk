import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dto/giphy_content_request.dart';
import 'dto/giphy_rendition.dart';
import 'dto/giphy_theme.dart';
import 'dto/misc.dart';

import 'dto/giphy_media.dart';

/// Customizable implementation of the Giphy Grid only solution.
///
/// This widget provides a customizable grid view of Giphy content, including
/// options for cell padding, preview rendition type, content request, orientation,
/// and more. It also supports callbacks for content updates, media selection,
/// and scrolling events.
class GiphyGridView extends StatefulWidget {
  /// Spacing between rendered GIFs.
  final double cellPadding;

  /// The rendition type for Giphy clips preview.
  final GiphyClipsRendition clipsPreviewRenditionType;

  /// An object describing a content request to the Giphy API.
  final GiphyContentRequest content;

  /// If true, the emoji variations drawer is not rendered.
  final bool disableEmojiVariations;

  /// Display content in equally sized cells (for stickers only).
  final bool fixedSizeCells;

  /// Tells the scroll direction of the grid.
  final GiphyDirection orientation;

  /// A rendition type for the grid.
  final GiphyRendition renditionType;

  /// Number of lanes in the grid.
  final int? spanCount;

  /// Show/Hide checkered background for stickers in the grid.
  final bool showCheckeredBackground;

  /// The theme for the Giphy grid view.
  final GiphyTheme theme;

  /// Callback for content updates.
  final Function(int resultCount)? onContentUpdate;

  /// Callback for media selection.
  final Function(GiphyMedia media)? onMediaSelect;

  /// Callback for scroll events.
  final Function(double offset)? onScroll;

  /// Constructs a GiphyGridView.
  const GiphyGridView(
      {super.key,
      this.cellPadding = 8,
      this.clipsPreviewRenditionType = GiphyClipsRendition.fixedWidth,
      required this.content,
      this.disableEmojiVariations = false,
      this.fixedSizeCells = false,
      this.orientation = GiphyDirection.vertical,
      this.renditionType = GiphyRendition.fixedWidth,
      this.spanCount,
      this.showCheckeredBackground = false,
      this.theme = GiphyTheme.automaticTheme,
      this.onContentUpdate,
      this.onMediaSelect,
      this.onScroll});

  @override
  State<GiphyGridView> createState() => _GiphyGridViewState();
}

/// The state for [GiphyGridView].
class _GiphyGridViewState extends State<GiphyGridView> {
  late MethodChannel _channel;
  bool _isPlatformViewCreated = false;

  @override
  void didUpdateWidget(GiphyGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool needsUpdate = oldWidget.cellPadding != widget.cellPadding ||
        oldWidget.clipsPreviewRenditionType !=
            widget.clipsPreviewRenditionType ||
        oldWidget.content != widget.content ||
        oldWidget.disableEmojiVariations != widget.disableEmojiVariations ||
        oldWidget.fixedSizeCells != widget.fixedSizeCells ||
        oldWidget.orientation != widget.orientation ||
        oldWidget.renditionType != widget.renditionType ||
        oldWidget.spanCount != widget.spanCount ||
        oldWidget.showCheckeredBackground != widget.showCheckeredBackground ||
        oldWidget.theme != widget.theme;
    if (_isPlatformViewCreated && needsUpdate) {
      _updatePlatformView();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return UiKitView(
        viewType: 'com.giphyfluttersdk/gridView',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'com.giphyfluttersdk/gridView',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      return const Text('This platform is not supported');
    }
  }

  /// Handles the creation of the platform view.
  ///
  /// Sets up the method channel for communication with the native platform.
  void _onPlatformViewCreated(int viewId) {
    _channel = MethodChannel('com.giphyfluttersdk/gridView$viewId');
    _channel.setMethodCallHandler(_handleMethodCall);
    _isPlatformViewCreated = true;
    _updatePlatformView();
  }

  /// Handles method calls from the native platform.
  ///
  /// This method processes callbacks for content updates, media selection, and scrolling.
  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onContentUpdate':
        if (widget.onContentUpdate != null) {
          widget.onContentUpdate!(
            call.arguments['resultCount'] ?? 0,
          );
        }
        break;
      case 'onMediaSelect':
        if (widget.onMediaSelect != null) {
          widget.onMediaSelect!(
            GiphyMedia.fromJson(call.arguments['media'] ?? {}),
          );
        }
        break;
      case 'onScroll':
        if (widget.onScroll != null) {
          widget.onScroll!(
            call.arguments['offset'] ?? 0,
          );
        }
        break;
    }
  }

  /// Updates the platform view with the current widget properties.
  Future<void> _updatePlatformView() async {
    await _channel
        .invokeMethod('setCellPadding', {'cellPadding': widget.cellPadding});
    await _channel.invokeMethod('setClipsPreviewRenditionType', {
      'renditionType':
          GiphyRenditionUtil.toStringValue(widget.clipsPreviewRenditionType)
    });
    await _channel
        .invokeMethod('setContent', {'content': widget.content.toJson()});
    await _channel.invokeMethod('setDisableEmojiVariations',
        {'disableEmojiVariations': widget.disableEmojiVariations});
    await _channel.invokeMethod(
        'setFixedSizeCells', {'fixedSizeCells': widget.fixedSizeCells});
    await _channel.invokeMethod('setOrientation', {
      'orientation': GiphyDirectionExtension.toStringValue(widget.orientation)
    });
    await _channel.invokeMethod('setRenditionType', {
      'renditionType': GiphyRenditionUtil.toStringValue(widget.renditionType)
    });
    if (widget.spanCount != null) {
      await _channel
          .invokeMethod('setSpanCount', {'spanCount': widget.spanCount});
    }
    await _channel.invokeMethod('setShowCheckeredBackground',
        {'showCheckeredBackground': widget.showCheckeredBackground});

    await _channel.invokeMethod('setTheme', {'theme': widget.theme.toJson()});
  }
}

