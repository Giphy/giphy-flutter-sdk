import 'specs/giphy_flutter_sdk_platform_interface.dart';

/// A class for configuring the Giphy Flutter SDK.
///
/// This class provides a static method to configure the Giphy SDK with the
/// necessary settings such as the API key, verification mode, and optional clips
/// cache size.
class GiphyFlutterSDK {
  /// Configures the Giphy SDK with the given settings.
  ///
  /// This method sends a configuration request to the platform-specific implementation
  /// of the Giphy SDK.
  ///
  /// [apiKey] The API key for the Giphy SDK.
  /// [verificationMode] A boolean indicating whether verification mode is enabled.
  /// [videoCacheMaxBytes] An optional parameter specifying the video cache size for ExoPlayer on the Android platform.
  /// Note: If videoCacheMaxBytes is 0, the cache initialization will be skipped, and Giphy Clips will not work.
  /// You may want to skip this setting if you use another version of ExoPlayer that is not compatible with the Giphy SDK but still wish to receive gifs from Giphy.
  static void configure(
      {required String apiKey,
      bool verificationMode = false,
      double? videoCacheMaxBytes}) {
    GiphyFlutterSdkPlatform.instance
        .configure(apiKey, verificationMode, videoCacheMaxBytes);
  }
}

