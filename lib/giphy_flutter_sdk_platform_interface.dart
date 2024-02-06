import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'giphy_flutter_sdk_method_channel.dart';

abstract class GiphyFlutterSdkPlatform extends PlatformInterface {
  /// Constructs a GiphyFlutterSdkPlatform.
  GiphyFlutterSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static GiphyFlutterSdkPlatform _instance = MethodChannelGiphyFlutterSdk();

  /// The default instance of [GiphyFlutterSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelGiphyFlutterSdk].
  static GiphyFlutterSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GiphyFlutterSdkPlatform] when
  /// they register themselves.
  static set instance(GiphyFlutterSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
