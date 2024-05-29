import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dto/giphy_content_request.dart';
import 'dto/giphy_rendition.dart';
import 'dto/giphy_theme.dart';
import 'dto/misc.dart';

import 'dto/giphy_media.dart';

class GiphyGridView extends StatefulWidget {
  final double cellPadding;
  final GiphyClipsRendition clipsPreviewRenditionType;
  final GiphyContentRequest content;
  final bool disableEmojiVariations;
  final bool fixedSizeCells;
  final GiphyDirection orientation;
  final GiphyRendition renditionType;
  final int? spanCount;
  final bool showCheckeredBackground;
  final GiphyTheme theme;

  final Function(int resultCount)? onContentUpdate;
  final Function(GiphyMedia media)? onMediaSelect;
  final Function(double offset)? onScroll;

  const GiphyGridView(
      {Key? key,
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
      this.onScroll})
      : super(key: key);

  @override
  State<GiphyGridView> createState() => _GiphyGridViewState();
}

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

  void _onPlatformViewCreated(int viewId) {
    _channel = MethodChannel('com.giphyfluttersdk/gridView$viewId');
    _channel.setMethodCallHandler(_handleMethodCall);
    _isPlatformViewCreated = true;
    _updatePlatformView();
  }

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
