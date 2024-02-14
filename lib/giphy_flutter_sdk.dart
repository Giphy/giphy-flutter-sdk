import 'specs/giphy_flutter_sdk_platform_interface.dart';

class GiphyFlutterSDK {
  static void configure({
    required String apiKey,
    bool verificationMode = false,
    Map<String, String>? metadata,
  }) {
    GiphyFlutterSdkPlatform.instance.configure(apiKey, verificationMode);
  }
}
