import 'package:flutter/services.dart';
import 'giphy_flutter_sdk_platform_interface.dart';

class GiphyFlutterSdkPlatformChannel extends GiphyFlutterSdkPlatform {
  static const MethodChannel _channel = MethodChannel('com.giphyfluttersdk');

  @override
  Future<void> configure(
      String apiKey, bool verificationMode) async {
    await _channel.invokeMethod('configure', {
      'apiKey': apiKey,
      'verificationMode': verificationMode,
    });
  }
}
