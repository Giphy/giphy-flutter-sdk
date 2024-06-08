import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'giphy_flutter_sdk_method_channel.dart';

/// An abstract class representing the platform interface for GiphyFlutterSdk.
///
/// This class extends [PlatformInterface] and provides the basic structure for
/// interacting with the Giphy SDK on different platforms. It includes a method
/// for configuring the SDK.
abstract class GiphyFlutterSdkPlatform extends PlatformInterface {
  /// Constructs a GiphyFlutterSdkPlatform.
  ///
  /// This constructor initializes the platform interface with a unique token.
  GiphyFlutterSdkPlatform() : super(token: _token);

  /// The unique token for verifying platform implementations.
  static final Object _token = Object();

  /// The default instance of [GiphyFlutterSdkPlatform].
  ///
  /// This instance is initially set to [GiphyFlutterSdkPlatformChannel].
  static GiphyFlutterSdkPlatform _instance = GiphyFlutterSdkPlatformChannel();

  /// Gets the current instance of [GiphyFlutterSdkPlatform].
  ///
  /// This getter returns the current platform-specific implementation of the
  /// Giphy SDK.
  static GiphyFlutterSdkPlatform get instance => _instance;

  /// Sets the current instance of [GiphyFlutterSdkPlatform].
  ///
  /// This setter allows changing the platform-specific implementation of the
  /// Giphy SDK. It verifies the new instance using the platform interface token.
  static set instance(GiphyFlutterSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Configures the Giphy SDK with the given settings.
  ///
  /// This method should be implemented by platform-specific subclasses to configure
  /// the Giphy SDK with the specified API key, verification mode, and optional video cache size.
  ///
  /// [apiKey] The API key for the Giphy SDK.
  /// [verificationMode] A boolean indicating whether verification mode is enabled.
  /// [videoCacheMaxBytes] An optional parameter specifying the video cache size for ExoPlayer on the Android platform.
  /// Note: If videoCacheMaxBytes is 0, the cache initialization will be skipped, and Giphy Clips will not work.
  /// You may want to skip this setting if you use another version of ExoPlayer that is not compatible with the Giphy SDK but still wish to receive gifs from Giphy.
  Future<void> configure(
      String apiKey, bool verificationMode, double? videoCacheMaxBytes) {
    throw UnimplementedError('configure() has not been implemented.');
  }
}

