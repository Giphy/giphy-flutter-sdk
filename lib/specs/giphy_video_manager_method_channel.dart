import 'package:flutter/services.dart';

import 'giphy_video_manager_platform_interface.dart';

class GiphyVideoManagerMethodChannel extends GiphyVideoManagerPlatform {
  static const MethodChannel _channel =
      MethodChannel('com.giphyfluttersdk/videoManager');

  @override
  Future<void> muteAll() async {
    await _channel.invokeMethod('muteAll');
  }

  @override
  Future<void> pauseAll() async {
    await _channel.invokeMethod('pauseAll');
  }

  @override
  Future<void> resume() async {
    await _channel.invokeMethod('resume');
  }
}
