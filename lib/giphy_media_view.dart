import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rendition.dart';
import 'package:giphy_flutter_sdk/dto/misc.dart';

import 'dto/giphy_media.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that is designed to render [GiphyMedia] objects.
///
/// This widget provides a customizable view for displaying a Giphy media item,
/// including options for auto-playing the media, rendition type, resize mode,
/// and more.
class GiphyMediaView extends StatefulWidget {
  /// The controller for managing the Giphy media view.
  final GiphyMediaViewController? controller;

  /// The ID of the media item to display.
  final String? mediaId;

  /// The media item to display.
  final GiphyMedia? media;

  /// A boolean flag indicating whether or not the animation should start automatically when mounted.
  final bool autoPlay;

  /// A rendition type for the view.
  final GiphyRendition renditionType;

  /// Determines how to resize the image when the frame doesn't match the raw image dimensions.
  final GiphyResizeMode resizeMode;

  /// Enable/disable the checkered background for stickers and text media type.
  final bool showCheckeredBackground;

  /// A callback function that will be called when an error occurs whilst attempting to render media.
  final Function(String description)? onError;

  /// Constructs a GiphyMediaView.
  const GiphyMediaView(
      {super.key,
      this.controller,
      this.mediaId,
      this.media,
      this.autoPlay = true,
      this.renditionType = GiphyRendition.fixedWidth,
      this.resizeMode = GiphyResizeMode.cover,
      this.showCheckeredBackground = true,
      this.onError});

  @override
  State<GiphyMediaView> createState() => _GiphyMediaViewState();
}

/// The state for [GiphyMediaView].
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

  /// Pauses the animation.
  Future<void> pause() async {
    if (!_isPlatformViewCreated) {
      if (kDebugMode) {
        print("GiphyMediaView: Platform view is not yet created.");
      }
      return;
    }
    await _channel.invokeMethod('pause');
  }

  /// Resumes the paused animation.
  Future<void> resume() async {
    if (!_isPlatformViewCreated) {
      if (kDebugMode) {
        print("GiphyMediaView: Platform view is not yet created.");
      }
      return;
    }
    await _channel.invokeMethod('resume');
  }

  /// Handles the creation of the platform view.
  ///
  /// Sets up the method channel for communication with the native platform.
  void _onPlatformViewCreated(int viewId) {
    _channel = MethodChannel('com.giphyfluttersdk/mediaView$viewId');
    _channel.setMethodCallHandler(_handleMethodCall);
    _isPlatformViewCreated = true;
    _updatePlatformView();
  }

  /// Handles method calls from the native platform.
  ///
  /// This method processes callbacks for errors.
  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onError':
        if (widget.onError != null) {
          widget.onError!(call.arguments['error'] ?? "unknown");
        }
        break;
    }
  }

  /// Updates the platform view with the current widget properties.
  Future<void> _updatePlatformView() async {
    if (widget.mediaId != null) {
      await _channel.invokeMethod('setMediaId', {'mediaId': widget.mediaId});
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

/// A controller for managing a [GiphyMediaView].
///
/// This class provides methods to pause and resume media playback in the associated
/// GiphyMediaView.
class GiphyMediaViewController {
  _GiphyMediaViewState? _state;

  /// Attaches the controller to a [GiphyMediaView] state.
  void _attach(_GiphyMediaViewState state) {
    _state = state;
  }

  /// Detaches the controller from a [GiphyMediaView] state.
  void _detach() {
    _state = null;
  }

  /// Pauses the animation in the associated [GiphyMediaView].
  Future<void> pause() async => _state?.pause();

  /// Resumes the paused animation in the associated [GiphyMediaView].
  Future<void> resume() async => _state?.resume();
}

