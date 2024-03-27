import 'package:giphy_flutter_sdk/specs/giphy_video_manager_platform_interface.dart';

class GiphyVideoManager {
  static final GiphyVideoManager _instance =
      GiphyVideoManager._privateConstructor();

  GiphyVideoManager._privateConstructor();

  static GiphyVideoManager get instance => _instance;

  void muteAll() {
    GiphyVideoManagerPlatform.instance.muteAll();
  }

  void pauseAll() {
    GiphyVideoManagerPlatform.instance.pauseAll();
  }

  void resume() {
    GiphyVideoManagerPlatform.instance.resume();
  }
}
