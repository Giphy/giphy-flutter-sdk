import 'dart:io' show Platform;
import 'package:giphy_flutter_sdk/dto/giphy_rendition.dart';
import 'package:giphy_flutter_sdk/dto/misc.dart';

import 'dto/giphy_media.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GiphyMediaView extends StatefulWidget {
  final GiphyMediaViewController? controller;
  final String? mediaId;
  final GiphyMedia? media;
  final bool autoPlay;
  final GiphyRendition renditionType;
  final GiphyResizeMode resizeMode;
  final bool showCheckeredBackground;

  const GiphyMediaView({
    Key? key,
    this.controller,
    this.mediaId,
    this.media,
    this.autoPlay = true,
    this.renditionType = GiphyRendition.fixedWidth,
    this.resizeMode = GiphyResizeMode.cover,
    this.showCheckeredBackground = true,
  }) : super(key: key);

  @override
  State<GiphyMediaView> createState() => _GiphyMediaViewState();
}

class _GiphyMediaViewState extends State<GiphyMediaView> {
  late MethodChannel _channel;
  bool _isPlatformViewCreated = false;

  @override
  void initState() {
    super.initState();
    widget.controller?._attach(this);
  }

  @override
  void dispose() {
    widget.controller?._detach();
    super.dispose();
  }

  @override
  void didUpdateWidget(GiphyMediaView oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool needsUpdate = oldWidget.mediaId != widget.mediaId ||
        oldWidget.media?.id != widget.media?.id ||
        oldWidget.autoPlay != widget.autoPlay ||
        oldWidget.renditionType != widget.renditionType ||
        oldWidget.resizeMode != widget.resizeMode ||
        oldWidget.showCheckeredBackground != widget.showCheckeredBackground;
    if (_isPlatformViewCreated && needsUpdate) {
      _updatePlatformView();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return UiKitView(
        viewType: 'com.giphyfluttersdk/mediaView',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'com.giphyfluttersdk/mediaView',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      return const Text('This platform is not supported');
    }
  }

  Future<void> pause() async {
    if (!_isPlatformViewCreated) {
      print("GiphyMediaView: Platform view is not yet created.");
      return;
    }
    await _channel.invokeMethod('pause');
  }

  Future<void> resume() async {
    if (!_isPlatformViewCreated) {
      print("GiphyMediaView: Platform view is not yet created.");
      return;
    }
    await _channel.invokeMethod('resume');
  }

  void _onPlatformViewCreated(int viewId) {
    _channel = MethodChannel('com.giphyfluttersdk/mediaView$viewId');
    _isPlatformViewCreated = true;
    _updatePlatformView();
  }

  Future<void> _updatePlatformView() async {
    if (widget.mediaId != null) {
      await _channel
          .invokeMethod('setMediaWithId', {'mediaId': widget.mediaId});
    } else if (widget.media != null) {
      await _channel
          .invokeMethod('setMedia', {'media': widget.media?.toJson()});
    }
    await _channel.invokeMethod('setAutoPlay', {'autoPlay': widget.autoPlay});
    await _channel.invokeMethod('setRenditionType', {
      'renditionType': GiphyRenditionUtil.toStringValue(widget.renditionType)
    });
    await _channel.invokeMethod('setResizeMode', {
      'resizeMode': GiphyResizeModeExtension.toStringValue(widget.resizeMode)
    });
    await _channel.invokeMethod('setShowCheckeredBackground',
        {'showCheckeredBackground': widget.showCheckeredBackground});
  }
}

class GiphyMediaViewController {
  _GiphyMediaViewState? _state;

  void _attach(_GiphyMediaViewState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  Future<void> pause() async => _state?.pause();

  Future<void> resume() async => _state?.resume();
}
