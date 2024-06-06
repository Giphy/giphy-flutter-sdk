import 'package:giphy_flutter_sdk/dto/giphy_settings.dart';
import 'package:giphy_flutter_sdk/specs/giphy_dialog_platform_interface.dart';

import 'dto/giphy_media.dart';
import 'giphy_video_manager.dart';

/// An abstract class designed to handle events from the Giphy dialog.
///
/// To use GiphyMediaSelectionListener, implement this abstract class in your widget state.
abstract class GiphyMediaSelectionListener {
  /// Called when a media item is selected in the GiphyDialog.
  ///
  /// [media] The media item that was selected.
  void onMediaSelect(GiphyMedia media);

  /// Called when the GiphyDialog is dismissed.
  void onDismiss();
}

/// Singleton, which provides pre-built templates that handle the entirety of the GIPHY experience.
///
/// This class provides methods to configure, show, and hide the GiphyDialog,
/// and to add or remove listeners for media selection and dialog dismissal events.
class GiphyDialog {
  /// Private constructor for the singleton instance.
  ///
  /// This constructor sets up the callbacks for media selection and dialog dismissal.
  GiphyDialog._privateConstructor() {
    _setupCallbacks();
  }

  /// The singleton instance of GiphyDialog.
  static final GiphyDialog _instance = GiphyDialog._privateConstructor();

  /// Gets the singleton instance of GiphyDialog.
  static GiphyDialog get instance => _instance;

  /// A list of listeners for media selection and dialog dismissal events.
  final List<GiphyMediaSelectionListener> _listeners = [];

  /// Sets up the callbacks for media selection and dialog dismissal.
  ///
  /// These callbacks notify the listeners when a media item is selected or the dialog is dismissed.
  void _setupCallbacks() {
    GiphyDialogPlatform.instance.registerOnMediaSelectCallback(
        (GiphyMedia media, String searchTerm, String selectedContentType) {
      _notifyMediaSelected(media);
    });

    GiphyDialogPlatform.instance.registerOnDismissCallback(() {
      _notifyDismissed();
    });
  }

  /// Configures the GiphyDialog with the given settings.
  ///
  /// [settings] The settings for configuring the GiphyDialog.
  void configure({GiphySettings? settings}) {
    final Map<String, dynamic> config = {'settings': settings?.toJson()};
    GiphyDialogPlatform.instance.configure(config);
  }

  /// Shows the GiphyDialog.
  ///
  /// This method pauses all clips playback before showing the dialog.
  void show() {
    GiphyVideoManager.instance.pauseAll();
    GiphyDialogPlatform.instance.show();
  }

  /// Hides the GiphyDialog.
  void hide() {
    GiphyDialogPlatform.instance.hide();
  }

  /// Adds a listener for media selection and dialog dismissal events.
  ///
  /// [listener] The listener to add.
  void addListener(GiphyMediaSelectionListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  /// Removes a listener for media selection and dialog dismissal events.
  ///
  /// [listener] The listener to remove.
  void removeListener(GiphyMediaSelectionListener listener) {
    _listeners.remove(listener);
  }

  /// Notifies all listeners that a media item has been selected.
  ///
  /// [media] The media item that was selected.
  void _notifyMediaSelected(GiphyMedia media) {
    for (var listener in _listeners) {
      listener.onMediaSelect(media);
    }
  }

  /// Notifies all listeners that the GiphyDialog has been dismissed.
  void _notifyDismissed() {
    for (var listener in _listeners) {
      listener.onDismiss();
    }
  }
}

