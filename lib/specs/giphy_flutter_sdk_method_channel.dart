import 'package:flutter/services.dart';
import 'giphy_flutter_sdk_platform_interface.dart';

/// A platform-specific implementation of the GiphyFlutterSdk using a MethodChannel.
///
/// This class communicates with the native platform using the MethodChannel
/// 'com.giphyfluttersdk'. It provides a method to configure the Giphy SDK
/// with the necessary settings.
class GiphyFlutterSdkPlatformChannel extends GiphyFlutterSdkPlatform {
  /// The MethodChannel used to interact with the native platform.
  static const MethodChannel _channel = MethodChannel('com.giphyfluttersdk');

  /// Configures the Giphy SDK with the given settings.
  ///
  /// This method sends a 'configure' method call to the native platform with
  /// the specified API key, verification mode, and optional video cache size.
  ///
  /// [apiKey] The API key for the Giphy SDK.
  /// [verificationMode] A boolean indicating whether verification mode is enabled.
  /// [videoCacheMaxBytes] An optional parameter specifying the video cache size for ExoPlayer on the Android platform.
  /// Note: If videoCacheMaxBytes is 0, the cache initialization will be skipped, and Giphy Clips will not work.
  /// You may want to skip this setting if you use another version of ExoPlayer that is not compatible with the Giphy SDK but still wish to receive gifs from Giphy.
  @override
  Future<void> configure(
      String apiKey, bool verificationMode, double? videoCacheMaxBytes) async {
    await _channel.invokeMethod('configure', {
      'apiKey': apiKey,
      'verificationMode': verificationMode,
      'videoCacheMaxBytes': videoCacheMaxBytes,
    });
  }
}

