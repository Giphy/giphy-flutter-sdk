import 'package:flutter/services.dart';
import '../dto/giphy_media.dart';
import 'giphy_dialog_platform_interface.dart';

/// A platform-specific implementation of the GiphyDialog using a MethodChannel.
///
/// This class communicates with the native platform using the MethodChannel
/// 'com.giphyfluttersdk/dialog'. It handles method calls from the platform
/// and provides methods to configure, show, and hide the GiphyDialog.
class GiphyDialogMethodChannel extends GiphyDialogPlatform {
  /// The MethodChannel used to interact with the native platform.
  static const MethodChannel _channel =
      MethodChannel('com.giphyfluttersdk/dialog');

  /// Constructs a GiphyDialogMethodChannel.
  ///
  /// Sets up the method call handler to handle calls from the native platform.
  GiphyDialogMethodChannel() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  /// Handles method calls from the native platform.
  ///
  /// This method is called whenever a method call is received from the native
  /// platform. It processes the 'onMediaSelect' and 'onDismiss' methods and
  /// invokes the appropriate callbacks if they are set.
  ///
  /// [call] The method call received from the native platform.
  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onMediaSelect':
        if (onMediaSelectCallback != null) {
          onMediaSelectCallback!(
            GiphyMedia.fromJson(call.arguments['media'] ?? {}),
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

  /// Configures the GiphyDialog with the given [config] settings.
  ///
  /// This method sends a 'configure' method call to the native platform with
  /// the specified configuration.
  ///
  /// [config] A map of configuration settings for the GiphyDialog.
  @override
  Future<void> configure(Map<String, dynamic> config) async {
    await _channel.invokeMethod('configure', config);
  }

  /// Shows the GiphyDialog.
  ///
  /// This method sends a 'show' method call to the native platform to display
  /// the GiphyDialog.
  @override
  Future<void> show() async {
    await _channel.invokeMethod('show');
  }

  /// Hides the GiphyDialog.
  ///
  /// This method sends a 'hide' method call to the native platform to hide the
  /// GiphyDialog.
  @override
  Future<void> hide() async {
    await _channel.invokeMethod('hide');
  }
}

