import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'giphy_video_manager_method_channel.dart';

/// An abstract class representing the platform interface for GiphyVideoManager.
///
/// This class extends [PlatformInterface] and provides the basic structure for
/// interacting with the video manager of the Giphy SDK on different platforms.
/// It includes methods to mute, pause, and resume video playback.
abstract class GiphyVideoManagerPlatform extends PlatformInterface {
  /// Constructs a GiphyVideoManagerPlatform.
  ///
  /// This constructor initializes the platform interface with a unique token.
  GiphyVideoManagerPlatform() : super(token: _token);

  /// The unique token for verifying platform implementations.
  static final Object _token = Object();

  /// The default instance of [GiphyVideoManagerPlatform].
  ///
  /// This instance is initially set to [GiphyVideoManagerMethodChannel].
  static GiphyVideoManagerPlatform _instance = GiphyVideoManagerMethodChannel();

  /// Gets the current instance of [GiphyVideoManagerPlatform].
  ///
  /// This getter returns the current platform-specific implementation of the
  /// Giphy video manager.
  static GiphyVideoManagerPlatform get instance => _instance;

  /// Sets the current instance of [GiphyVideoManagerPlatform].
  ///
  /// This setter allows changing the platform-specific implementation of the
  /// Giphy video manager. It verifies the new instance using the platform interface token.
  static set instance(GiphyVideoManagerPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Mutes all video playback.
  ///
  /// This method should be implemented by platform-specific subclasses to mute
  /// all video playback.
  Future<void> muteAll() async {
    throw UnimplementedError('muteAll() has not been implemented.');
  }

  /// Pauses all video playback.
  ///
  /// This method should be implemented by platform-specific subclasses to pause
  /// all video playback.
  Future<void> pauseAll() async {
    throw UnimplementedError('pauseAll() has not been implemented.');
  }

  /// Resumes video playback.
  ///
  /// This method should be implemented by platform-specific subclasses to resume
  /// video playback.
  Future<void> resume() async {
    throw UnimplementedError('resume() has not been implemented.');
  }
}

