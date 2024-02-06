
import 'giphy_flutter_sdk_platform_interface.dart';

class GiphyFlutterSdk {
  Future<String?> getPlatformVersion() {
    return GiphyFlutterSdkPlatform.instance.getPlatformVersion();
  }
}
