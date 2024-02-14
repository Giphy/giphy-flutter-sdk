import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'giphy_dialog_method_channel.dart';

abstract class GiphyDialogPlatform extends PlatformInterface {
  GiphyDialogPlatform() : super(token: _token);

  static final Object _token = Object();

  static GiphyDialogPlatform _instance = GiphyDialogMethodChannel();

  static GiphyDialogPlatform get instance => _instance;

  static set instance(GiphyDialogPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  // TODO: replace media with its corresponding type
  Function(String media, String searchTerm, String selectedContentType)?
      onMediaSelectCallback;
  Function()? onDismissCallback;

  void registerOnMediaSelectCallback(
      Function(String media, String searchTerm, String selectedContentType)
          callback) {
    onMediaSelectCallback = callback;
  }

  void registerOnDismissCallback(Function() callback) {
    onDismissCallback = callback;
  }

  Future<void> configure(Map<String, dynamic> config) async {
    throw UnimplementedError('configure() has not been implemented.');
  }

  Future<void> show() async {
    throw UnimplementedError('show() has not been implemented.');
  }

  Future<void> hide() async {
    throw UnimplementedError('hide() has not been implemented.');
  }
}
