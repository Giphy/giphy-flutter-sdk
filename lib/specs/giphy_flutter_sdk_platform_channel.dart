import 'package:flutter/services.dart';
import 'giphy_flutter_sdk_platform.dart';

class GiphyFlutterSdkPlatformChannel extends GiphyFlutterSdkPlatform {
  static const MethodChannel _channel = MethodChannel('giphy_flutter_sdk');

  @override
  Future<void> configure(
      String apiKey, bool verificationMode, int videoCacheMaxBytes) async {
    await _channel.invokeMethod('configure', {
      'apiKey': apiKey,
      'verificationMode': verificationMode,
      'videoCacheMaxBytes': videoCacheMaxBytes,
    });
  }
}
