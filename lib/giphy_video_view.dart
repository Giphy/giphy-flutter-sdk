import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:giphy_flutter_sdk/giphy_video_manager.dart';

import 'dto/giphy_media.dart';
import 'dto/giphy_video_view_playback_state.dart';

/// A widget that makes it easy to play back [GiphyMedia] clips video assets.
///
/// This widget provides a customizable view for displaying a Giphy video,
/// including options for auto-playing the video, muting, and handling various
/// callbacks for mute/unmute, playback state changes, and errors.
/// The GiphyVideoView will only work for [GiphyMedia] where the isVideo property is true.
///
/// Note: GiphyVideoView has no advanced features for playback, volume, and buffering control.
/// If you need some advanced features, you can easily integrate clips with other more advanced video players.
class GiphyVideoView extends StatefulWidget {
  /// The ID of the media item to display.
  final String? mediaId;

  /// The media item to display.
  final GiphyMedia? media;

  /// Set it to true to start the video automatically.
  final bool autoPlay;

  /// Set to true or false to mute or unmute the player.
  final bool muted;

  /// A callback function that will be called when media is muted.
  final Function()? onMute;

  /// A callback function that will be called when media is unmuted.
  final Function()? onUnmute;

  /// A callback function that will be called when playback state changes.
  final Function(GiphyVideoViewPlaybackState state)? onPlaybackStateChanged;

  /// A callback function that will be called when an error occurs whilst attempting to play media.
  final Function(String description)? onError;

  /// Constructs a GiphyVideoView.
  const GiphyVideoView(
      {super.key,
        this.mediaId,
        this.media,
        this.autoPlay = true,
        this.muted = false,
        this.onMute,
        this.onUnmute,
        this.onPlaybackStateChanged,
        this.onError});

  @override
  State<GiphyVideoView> createState() => _GiphyVideoViewState();
}

/// The state for [GiphyVideoView].
class _GiphyVideoViewState extends State<GiphyVideoView>
    with WidgetsBindingObserver {
  late MethodChannel _channel;
  bool _isPlatformViewCreated = false;
  AppLifecycleState? _lastAppState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (_lastAppState == AppLifecycleState.resumed &&
        state == AppLifecycleState.paused) {
      // App is transitioning from foreground to background
      GiphyVideoManager.instance.pauseAll();
    } else if (_lastAppState == AppLifecycleState.paused &&
        state == AppLifecycleState.resumed) {
      // App is transitioning from background to foreground
      GiphyVideoManager.instance.resume();
      GiphyVideoManager.instance.muteAll();
    }
    _lastAppState = state;
  }

  @override
  void didUpdateWidget(GiphyVideoView oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool needsUpdate = oldWidget.mediaId != widget.mediaId ||
        oldWidget.media?.id != widget.media?.id;
    if (_isPlatformViewCreated && needsUpdate) {
      _updatePlatformView();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return UiKitView(
        viewType: 'com.giphyfluttersdk/videoView',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'com.giphyfluttersdk/videoView',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      return const Text('This platform is not supported');
    }
  }

  /// Pauses the video playback.
  Future<void> pause() async {
    if (!_isPlatformViewCreated) {
      if (kDebugMode) {
        print("GiphyVideoView: Platform view is not yet created.");
      }
      return;
    }
    await _channel.invokeMethod('pause');
  }

  /// Resumes the video playback.
  Future<void> resume() async {
    if (!_isPlatformViewCreated) {
      if (kDebugMode) {
        print("GiphyVideoView: Platform view is not yet created.");
      }
      return;
    }
    await _channel.invokeMethod('resume');
  }

  /// Handles the creation of the platform view.
  ///
  /// Sets up the method channel for communication with the native platform.
  void _onPlatformViewCreated(int viewId) {
    _channel = MethodChannel('com.giphyfluttersdk/videoView$viewId');
    _channel.setMethodCallHandler(_handleMethodCall);
    _isPlatformViewCreated = true;
    _updatePlatformView();
  }

  /// Handles method calls from the native platform.
  ///
  /// This method processes callbacks for mute/unmute, playback state changes, and errors.
  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onMute':
        if (widget.onMute != null) {
          widget.onMute!();
        }
        break;
      case 'onUnmute':
        if (widget.onUnmute != null) {
          widget.onUnmute!();
        }
        break;
      case 'onPlaybackStateChanged':
        if (widget.onPlaybackStateChanged != null) {
          widget.onPlaybackStateChanged!(
            GiphyVideoViewPlaybackStateExtension.fromIntValue(
                call.arguments['code'] ?? 0),
          );
        }
        break;
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
    await _channel.invokeMethod('setMuted', {'muted': widget.muted});
  }
}

