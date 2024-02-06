import 'package:flutter_test/flutter_test.dart';
import 'package:giphy_flutter_sdk/giphy_flutter_sdk.dart';
import 'package:giphy_flutter_sdk/giphy_flutter_sdk_platform_interface.dart';
import 'package:giphy_flutter_sdk/giphy_flutter_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGiphyFlutterSdkPlatform
    with MockPlatformInterfaceMixin
    implements GiphyFlutterSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final GiphyFlutterSdkPlatform initialPlatform = GiphyFlutterSdkPlatform.instance;

  test('$MethodChannelGiphyFlutterSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGiphyFlutterSdk>());
  });

  test('getPlatformVersion', () async {
    GiphyFlutterSdk giphyFlutterSdkPlugin = GiphyFlutterSdk();
    MockGiphyFlutterSdkPlatform fakePlatform = MockGiphyFlutterSdkPlatform();
    GiphyFlutterSdkPlatform.instance = fakePlatform;

    expect(await giphyFlutterSdkPlugin.getPlatformVersion(), '42');
  });
}
