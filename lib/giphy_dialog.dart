import 'package:giphy_flutter_sdk/dto/giphy_settings.dart';
import 'package:giphy_flutter_sdk/specs/giphy_dialog_platform_interface.dart';

abstract class MediaSelectionListener {
  void onMediaSelect(String media);
  void onDismiss();
}

class GiphyDialog {
  GiphyDialog._privateConstructor() {
    _setupCallbacks();
  }
  static final GiphyDialog _instance = GiphyDialog._privateConstructor();
  static GiphyDialog get instance => _instance;
  final List<MediaSelectionListener> _listeners = [];

  void _setupCallbacks() {
    GiphyDialogPlatform.instance.registerOnMediaSelectCallback((String media, String searchTerm, String selectedContentType) {
      _notifyMediaSelected(media);
    });

    GiphyDialogPlatform.instance.registerOnDismissCallback(() {
      _notifyDismissed();
    });
  }

  void configure({
    GiphySettings? settings,
    Map<String, String>? metadata,
  }) {
    final Map<String, dynamic> config = {
      'settings': settings?.toJson(),
      'metadata': metadata,
    };
    GiphyDialogPlatform.instance.configure(config);
  }

  void show() {
    GiphyDialogPlatform.instance.show();
  }

  void hide() {
    GiphyDialogPlatform.instance.hide();
  }

  void addListener(MediaSelectionListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(MediaSelectionListener listener) {
    _listeners.remove(listener);
  }

  void _notifyMediaSelected(String media) {
    for (var listener in _listeners) {
      listener.onMediaSelect(media);
    }
  }

  void _notifyDismissed() {
    for (var listener in _listeners) {
      listener.onDismiss();
    }
  }
}
