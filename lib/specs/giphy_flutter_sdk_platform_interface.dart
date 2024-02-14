import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'giphy_flutter_sdk_method_channel.dart';

abstract class GiphyFlutterSdkPlatform extends PlatformInterface {
  GiphyFlutterSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static GiphyFlutterSdkPlatform _instance = GiphyFlutterSdkPlatformChannel();

  static GiphyFlutterSdkPlatform get instance => _instance;

  static set instance(GiphyFlutterSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> configure(
      String apiKey, bool verificationMode) {
    throw UnimplementedError('configure() has not been implemented.');
  }
}
