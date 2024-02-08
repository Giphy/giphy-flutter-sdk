import 'specs/giphy_flutter_sdk_platform.dart';

class GiphyFlutterSDKConfig {
  String apiKey;
  bool? verificationMode;
  int? videoCacheMaxBytes;

  GiphyFlutterSDKConfig(
      {required this.apiKey, this.verificationMode, this.videoCacheMaxBytes});
}

const int defaultVideoCacheMaxBytes = 100 * 1024 * 1024;

class GiphyFlutterSDK {
  static void configure(GiphyFlutterSDKConfig options) {
    String apiKey = options.apiKey;
    int videoCacheMaxBytes =
        options.videoCacheMaxBytes ?? defaultVideoCacheMaxBytes;
    bool verificationMode = options.verificationMode ?? false;

    GiphyFlutterSdkPlatform.instance
        .configure(apiKey, verificationMode, videoCacheMaxBytes);
  }
}
