import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'giphy_flutter_sdk_platform_interface.dart';

/// An implementation of [GiphyFlutterSdkPlatform] that uses method channels.
class MethodChannelGiphyFlutterSdk extends GiphyFlutterSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('giphy_flutter_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
