import 'package:giphy_flutter_sdk/dto/giphy_settings.dart';
import 'package:giphy_flutter_sdk/specs/giphy_dialog_platform_interface.dart';

import 'dto/giphy_media.dart';
import 'giphy_video_manager.dart';

abstract class GiphyMediaSelectionListener {
  void onMediaSelect(GiphyMedia media);

  void onDismiss();
}

class GiphyDialog {
  GiphyDialog._privateConstructor() {
    _setupCallbacks();
  }

  static final GiphyDialog _instance = GiphyDialog._privateConstructor();

  static GiphyDialog get instance => _instance;
  final List<GiphyMediaSelectionListener> _listeners = [];

  void _setupCallbacks() {
    GiphyDialogPlatform.instance.registerOnMediaSelectCallback(
        (GiphyMedia media, String searchTerm, String selectedContentType) {
      _notifyMediaSelected(media);
    });

    GiphyDialogPlatform.instance.registerOnDismissCallback(() {
      _notifyDismissed();
    });
  }

  void configure({GiphySettings? settings}) {
    final Map<String, dynamic> config = {'settings': settings?.toJson()};
    GiphyDialogPlatform.instance.configure(config);
  }

  void show() {
    GiphyVideoManager.instance.pauseAll();
    GiphyDialogPlatform.instance.show();
  }

  void hide() {
    GiphyDialogPlatform.instance.hide();
  }

  void addListener(GiphyMediaSelectionListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(GiphyMediaSelectionListener listener) {
    _listeners.remove(listener);
  }

  void _notifyMediaSelected(GiphyMedia media) {
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
