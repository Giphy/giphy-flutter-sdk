import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'giphy_video_manager_method_channel.dart';

abstract class GiphyVideoManagerPlatform extends PlatformInterface {
  GiphyVideoManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static GiphyVideoManagerPlatform _instance = GiphyVideoManagerMethodChannel();

  static GiphyVideoManagerPlatform get instance => _instance;

  static set instance(GiphyVideoManagerPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  Future<void> muteAll() async {
    throw UnimplementedError('muteAll() has not been implemented.');
  }

  Future<void> pauseAll() async {
    throw UnimplementedError('pauseAll() has not been implemented.');
  }

  Future<void> resume() async {
    throw UnimplementedError('resume() has not been implemented.');
  }
}
