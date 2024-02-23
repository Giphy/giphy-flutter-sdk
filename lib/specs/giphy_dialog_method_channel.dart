import 'package:flutter/services.dart';
import '../dto/giphy_media.dart';
import 'giphy_dialog_platform_interface.dart';

class GiphyDialogMethodChannel extends GiphyDialogPlatform {
  static const MethodChannel _channel = MethodChannel('com.giphyfluttersdk/dialog');

  GiphyDialogMethodChannel() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onMediaSelect':
        if (onMediaSelectCallback != null) {
          Media m = Media.fromJson(call.arguments['media']);

          onMediaSelectCallback!(
            Media.fromJson(call.arguments['media'] ?? {}),
            call.arguments['searchTerm'] ?? "",
            call.arguments['selectedContentType'],
          );
        }
        break;
      case 'onDismiss':
        if (onDismissCallback != null) {
          onDismissCallback!();
        }
        break;
    }
  }

  @override
  Future<void> configure(Map<String, dynamic> config) async {
    await _channel.invokeMethod('configure', config);
  }

  @override
  Future<void> show() async {
    await _channel.invokeMethod('show');
  }

  @override
  Future<void> hide() async {
    await _channel.invokeMethod('hide');
  }
}
