import 'package:flutter/services.dart';

import 'giphy_video_manager_platform_interface.dart';

/// A platform-specific implementation of the GiphyVideoManager using a MethodChannel.
///
/// This class communicates with the native platform using the MethodChannel
/// 'com.giphyfluttersdk/videoManager'. It provides methods to mute, pause,
/// and resume video playback.
class GiphyVideoManagerMethodChannel extends GiphyVideoManagerPlatform {
  /// The MethodChannel used to interact with the native platform.
  static const MethodChannel _channel =
      MethodChannel('com.giphyfluttersdk/videoManager');

  /// Mutes all video playback.
  ///
  /// This method sends a 'muteAll' method call to the native platform to mute
  /// all video playback.
  @override
  Future<void> muteAll() async {
    await _channel.invokeMethod('muteAll');
  }

  /// Pauses all video playback.
  ///
  /// This method sends a 'pauseAll' method call to the native platform to pause
  /// all video playback.
  @override
  Future<void> pauseAll() async {
    await _channel.invokeMethod('pauseAll');
  }

  /// Resumes video playback.
  ///
  /// This method sends a 'resume' method call to the native platform to resume
  /// video playback.
  @override
  Future<void> resume() async {
    await _channel.invokeMethod('resume');
  }
}

