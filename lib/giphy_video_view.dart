import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:giphy_flutter_sdk/giphy_video_manager.dart';

import 'dto/giphy_media.dart';
import 'dto/giphy_video_view_playback_state.dart';

class GiphyVideoView extends StatefulWidget {
  final String? mediaId;
  final GiphyMedia? media;
  final bool autoPlay;
  final bool muted;

  final Function()? onMute;
  final Function()? onUnmute;
  final Function(GiphyVideoViewPlaybackState state)? onPlaybackStateChanged;
  final Function(String description)? onError;

  const GiphyVideoView(
      {Key? key,
      this.mediaId,
      this.media,
      this.autoPlay = true,
      this.muted = false,
      this.onMute,
      this.onUnmute,
      this.onPlaybackStateChanged,
      this.onError})
      : super(key: key);

  @override
  State<GiphyVideoView> createState() => _GiphyVideoViewState();
}

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

  Future<void> pause() async {
    if (!_isPlatformViewCreated) {
      print("GiphyVideoView: Platform view is not yet created.");
      return;
    }
    await _channel.invokeMethod('pause');
  }

  Future<void> resume() async {
    if (!_isPlatformViewCreated) {
      print("GiphyVideoView: Platform view is not yet created.");
      return;
    }
    await _channel.invokeMethod('resume');
  }

  void _onPlatformViewCreated(int viewId) {
    _channel = MethodChannel('com.giphyfluttersdk/videoView$viewId');
    _channel.setMethodCallHandler(_handleMethodCall);
    _isPlatformViewCreated = true;
    _updatePlatformView();
  }

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
