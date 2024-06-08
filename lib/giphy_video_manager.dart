import 'package:giphy_flutter_sdk/specs/giphy_video_manager_platform_interface.dart';

/// A singleton class for managing [GiphyVideoView] players
///
/// This class provides methods to mute, pause, and resume all video playback
/// in the Giphy SDK. It interacts with the platform-specific implementation
/// through [GiphyVideoManagerPlatform].
class GiphyVideoManager {
  /// The singleton instance of [GiphyVideoManager].
  static final GiphyVideoManager _instance =
  GiphyVideoManager._privateConstructor();

  /// Private constructor for the singleton instance.
  GiphyVideoManager._privateConstructor();

  /// Gets the singleton instance of [GiphyVideoManager].
  static GiphyVideoManager get instance => _instance;

  /// Mute active [GiphyVideoView] player.
  ///
  /// This method sends a mute request to the platform-specific implementation.
  void muteAll() {
    GiphyVideoManagerPlatform.instance.muteAll();
  }

  /// Pause active [GiphyVideoView] player.
  ///
  /// This method sends a pause request to the platform-specific implementation.
  void pauseAll() {
    GiphyVideoManagerPlatform.instance.pauseAll();
  }

  /// Resume the playback.
  ///
  /// This method sends a resume request to the platform-specific implementation.
  void resume() {
    GiphyVideoManagerPlatform.instance.resume();
  }
}

