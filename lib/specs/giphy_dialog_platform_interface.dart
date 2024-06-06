import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../dto/giphy_media.dart';
import 'giphy_dialog_method_channel.dart';

/// An abstract class representing the platform interface for GiphyDialog.
///
/// This class extends [PlatformInterface] and provides the basic structure for
/// interacting with the GiphyDialog on different platforms. It includes methods
/// for configuration, showing, and hiding the dialog, as well as handling
/// callbacks for media selection and dialog dismissal.
abstract class GiphyDialogPlatform extends PlatformInterface {
  /// Constructs a GiphyDialogPlatform.
  ///
  /// This constructor initializes the platform interface with a unique token.
  GiphyDialogPlatform() : super(token: _token);

  /// The unique token for verifying platform implementations.
  static final Object _token = Object();

  /// The default instance of [GiphyDialogPlatform].
  ///
  /// This instance is initially set to [GiphyDialogMethodChannel].
  static GiphyDialogPlatform _instance = GiphyDialogMethodChannel();

  /// Gets the current instance of [GiphyDialogPlatform].
  ///
  /// This getter returns the current platform-specific implementation of the
  /// GiphyDialog.
  static GiphyDialogPlatform get instance => _instance;

  /// Sets the current instance of [GiphyDialogPlatform].
  ///
  /// This setter allows changing the platform-specific implementation of the
  /// GiphyDialog. It verifies the new instance using the platform interface token.
  static set instance(GiphyDialogPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Callback for handling media selection events.
  ///
  /// This callback is invoked when a media item is selected in the GiphyDialog.
  Function(GiphyMedia media, String searchTerm, String selectedContentType)?
      onMediaSelectCallback;

  /// Callback for handling dialog dismissal events.
  ///
  /// This callback is invoked when the GiphyDialog is dismissed.
  Function()? onDismissCallback;

  /// Registers a callback for media selection events.
  ///
  /// This method allows setting a callback function that will be called when a
  /// media item is selected in the GiphyDialog.
  ///
  /// [callback] The function to call when a media item is selected.
  void registerOnMediaSelectCallback(
      Function(GiphyMedia media, String searchTerm, String selectedContentType)
          callback) {
    onMediaSelectCallback = callback;
  }

  /// Registers a callback for dialog dismissal events.
  ///
  /// This method allows setting a callback function that will be called when the
  /// GiphyDialog is dismissed.
  ///
  /// [callback] The function to call when the dialog is dismissed.
  void registerOnDismissCallback(Function() callback) {
    onDismissCallback = callback;
  }

  /// Configures the GiphyDialog with the given [config] settings.
  ///
  /// This method should be implemented by platform-specific subclasses to configure
  /// the GiphyDialog with the specified configuration.
  ///
  /// [config] A map of configuration settings for the GiphyDialog.
  Future<void> configure(Map<String, dynamic> config) async {
    throw UnimplementedError('configure() has not been implemented.');
  }

  /// Shows the GiphyDialog.
  ///
  /// This method should be implemented by platform-specific subclasses to display
  /// the GiphyDialog.
  Future<void> show() async {
    throw UnimplementedError('show() has not been implemented.');
  }

  /// Hides the GiphyDialog.
  ///
  /// This method should be implemented by platform-specific subclasses to hide
  /// the GiphyDialog.
  Future<void> hide() async {
    throw UnimplementedError('hide() has not been implemented.');
  }
}

