// Checks the messages the Dart API exchanges with the native side over method channels.
// The native side is replaced by a fake, so these tests run without a device:
//   flutter test

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:giphy_flutter_sdk/dto/giphy_content_type.dart';
import 'package:giphy_flutter_sdk/dto/giphy_media.dart';
import 'package:giphy_flutter_sdk/dto/giphy_media_type.dart';
import 'package:giphy_flutter_sdk/dto/giphy_settings.dart';
import 'package:giphy_flutter_sdk/dto/giphy_theme.dart';
import 'package:giphy_flutter_sdk/giphy_dialog.dart';
import 'package:giphy_flutter_sdk/giphy_flutter_sdk.dart';
import 'package:giphy_flutter_sdk/giphy_video_manager.dart';

import 'fixtures.dart';

const sdkChannel = MethodChannel('com.giphyfluttersdk');
const dialogChannel = MethodChannel('com.giphyfluttersdk/dialog');
const videoManagerChannel = MethodChannel('com.giphyfluttersdk/videoManager');

/// The arguments of the native onMediaSelect callback, as the iOS plugin sends them.
const mediaSelected = <String, Object?>{
  'media': gifFromNative,
  'searchTerm': null,
  'selectedContentType': 'gif',
};

/// Records every call the Dart side sends to the native side, in order, as
/// [channel, method, arguments]. Lists, so `expect` compares the arguments by value.
final sent = <List<Object?>>[];

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final listener = RecordingListener();

  setUp(() {
    sent.clear();
    listener.selected.clear();
    listener.dismissCount = 0;
    for (final channel in [sdkChannel, dialogChannel, videoManagerChannel]) {
      messenger.setMockMethodCallHandler(channel, (call) async {
        sent.add([channel.name, call.method, call.arguments]);
        return null;
      });
    }
    GiphyDialog.instance.addListener(listener);
  });

  tearDown(() {
    GiphyDialog.instance.removeListener(listener);
    for (final channel in [sdkChannel, dialogChannel, videoManagerChannel]) {
      messenger.setMockMethodCallHandler(channel, null);
    }
  });

  /// Delivers a call from the native side to the Dart side, and fails the test if
  /// no Dart handler answered or the handler threw.
  Future<void> sendFromNative(MethodChannel channel, String method,
      [Object? arguments]) async {
    const codec = StandardMethodCodec();
    ByteData? reply;
    await messenger.handlePlatformMessage(
        channel.name, codec.encodeMethodCall(MethodCall(method, arguments)),
        (data) {
      reply = data;
    });
    expect(reply, isNotNull,
        reason: 'No Dart handler answered ${channel.name} $method');
    // Throws a PlatformException if the Dart handler failed.
    codec.decodeEnvelope(reply!);
  }

  group('Dart to native', () {
    test(
        'GiphyFlutterSDK.configure sends the key, verification mode and cache size',
        () async {
      GiphyFlutterSDK.configure(
          apiKey: 'test-key', verificationMode: true, videoCacheMaxBytes: 1024);
      await pumpEventQueue();

      expect(sent, [
        [
          'com.giphyfluttersdk',
          'configure',
          {
            'apiKey': 'test-key',
            'verificationMode': true,
            'videoCacheMaxBytes': 1024.0
          }
        ],
      ]);
    });

    test('GiphyDialog.configure sends the settings', () async {
      final settings = GiphySettings(
        theme: GiphyTheme.dark(),
        mediaTypeConfig: [GiphyContentType.gif, GiphyContentType.clips],
        stickerColumnCount: 4,
      );
      GiphyDialog.instance.configure(settings: settings);
      await pumpEventQueue();

      expect(sent, [
        [
          'com.giphyfluttersdk/dialog',
          'configure',
          {'settings': settings.toJson()}
        ],
      ]);
    });

    test('GiphyDialog.show pauses videos, then shows the dialog', () async {
      GiphyDialog.instance.show();
      await pumpEventQueue();

      expect(sent, [
        ['com.giphyfluttersdk/videoManager', 'pauseAll', null],
        ['com.giphyfluttersdk/dialog', 'show', null],
      ]);
    });

    test('GiphyDialog.hide hides the dialog', () async {
      GiphyDialog.instance.hide();
      await pumpEventQueue();

      expect(sent, [
        ['com.giphyfluttersdk/dialog', 'hide', null]
      ]);
    });

    test('GiphyVideoManager sends mute, pause and resume', () async {
      GiphyVideoManager.instance.muteAll();
      GiphyVideoManager.instance.pauseAll();
      GiphyVideoManager.instance.resume();
      await pumpEventQueue();

      expect(sent, [
        ['com.giphyfluttersdk/videoManager', 'muteAll', null],
        ['com.giphyfluttersdk/videoManager', 'pauseAll', null],
        ['com.giphyfluttersdk/videoManager', 'resume', null],
      ]);
    });
  });

  group('Native to Dart', () {
    test('a media selected in the dialog reaches listeners, parsed', () async {
      await sendFromNative(dialogChannel, 'onMediaSelect', mediaSelected);

      expect(listener.selected, hasLength(1));
      final media = listener.selected.single;
      expect(media.id, 'LRs6P30O9lWaRjzdN0');
      expect(media.type, GiphyMediaType.gif);
      expect(media.images.original?.gifUrl,
          'https://media.giphy.com/media/LRs6P30O9lWaRjzdN0/giphy.gif');
    });

    test('a dismissed dialog reaches listeners', () async {
      await sendFromNative(dialogChannel, 'onDismiss');

      expect(listener.dismissCount, 1);
      expect(listener.selected, isEmpty);
    });

    test('a removed listener gets nothing', () async {
      GiphyDialog.instance.removeListener(listener);
      await sendFromNative(dialogChannel, 'onDismiss');
      await sendFromNative(dialogChannel, 'onMediaSelect', mediaSelected);

      expect(listener.dismissCount, 0);
      expect(listener.selected, isEmpty);
    });
  });
}

class RecordingListener implements GiphyMediaSelectionListener {
  final selected = <GiphyMedia>[];
  var dismissCount = 0;

  @override
  void onMediaSelect(GiphyMedia media) => selected.add(media);

  @override
  void onDismiss() => dismissCount++;
}
