// Integration tests for the plugin against the real native GIPHY SDK.
//
// They need network access and an API key in lib/config.dart (see CONTRIBUTING.md).
// Run on a simulator, emulator or device:
//   cd example && flutter test integration_test -d <device-id>
//
// Flutter tests can't tap inside native views. Each test instead waits for evidence
// that the native side did its job: callbacks it sends back (content loaded, playback
// state, errors) or, where the plugin sends none, a screenshot of the native views.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:giphy_flutter_sdk/dto/giphy_content_request.dart';
import 'package:giphy_flutter_sdk/dto/giphy_content_type.dart';
import 'package:giphy_flutter_sdk/dto/giphy_media_type.dart';
import 'package:giphy_flutter_sdk/dto/giphy_settings.dart';
import 'package:giphy_flutter_sdk/dto/giphy_theme.dart';
import 'package:giphy_flutter_sdk/dto/giphy_video_view_playback_state.dart';
import 'package:giphy_flutter_sdk/giphy_dialog.dart';
import 'package:giphy_flutter_sdk/giphy_flutter_sdk.dart';
import 'package:giphy_flutter_sdk/giphy_grid_view.dart';
import 'package:giphy_flutter_sdk/giphy_media_view.dart';
import 'package:giphy_flutter_sdk/giphy_video_manager.dart';
import 'package:giphy_flutter_sdk/giphy_video_view.dart';
import 'package:giphy_flutter_sdk_example/config.dart' as config;
import 'package:giphy_flutter_sdk_example/main.dart';
import 'package:integration_test/integration_test.dart';

// Stable media also used by the native SDK's UI tests.
const gifId = 'LRs6P30O9lWaRjzdN0';
const stickerId = 'fTzaoGWaMwBzG6o7Ds';
const missingId = 'noSuchGiphyMediaId000';

// Integration tests have no default timeout; bound every test.
const testTimeout = Timeout(Duration(minutes: 2));

// On iOS the screenshot includes native views and the presented dialog. On Android
// that hasn't been verified, so the screenshot-based tests are skipped there.
final screenshotsShowNativeViews = Platform.isIOS;

final apiKey =
    Platform.isIOS ? config.iOSGiphyApiKey : config.androidGiphyApiKey;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    GiphyFlutterSDK.configure(apiKey: apiKey);
  });

  testWidgets('example app shows its main screen', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Show Dialog'), findsOneWidget);
    expect(find.text('Dialog Settings'), findsOneWidget);
  }, timeout: testTimeout);

  testWidgets('dialog appears with custom settings and goes away on hide',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold()));
    await tester.pumpAndSettle();
    final screen =
        Offset.zero & tester.view.physicalSize / tester.view.devicePixelRatio;
    final lowerHalf =
        Rect.fromLTRB(0, screen.height / 2, screen.width, screen.height);
    final before = await Shot.capture(binding, tester);

    GiphyDialog.instance.configure(
      settings: GiphySettings(
        theme: GiphyTheme.dark(),
        mediaTypeConfig: GiphyContentType.values,
        showConfirmationScreen: true,
        stickerColumnCount: 2,
        enableDynamicText: true,
      ),
    );
    GiphyDialog.instance.show();
    await waitForScreen(
        binding,
        tester,
        // Measured on iOS: the dialog changes ~99% of the screen. Its frame alone has
        // ~60 colors in the lower half; with media loaded, 900+.
        (shot) =>
            shot.changedFraction(before, screen) > 0.5 &&
            shot.distinctColors(lowerHalf) > 300,
        reason: 'the GIPHY dialog to appear with media');

    GiphyDialog.instance.hide();
    await waitForScreen(
        binding, tester, (shot) => shot.changedFraction(before, screen) < 0.02,
        reason: 'the GIPHY dialog to close');
  }, skip: !screenshotsShowNativeViews, timeout: testTimeout);

  testWidgets('grid view loads trending GIFs, then search results',
      (tester) async {
    var resultCount = 0;
    Widget grid(GiphyContentRequest content) => MaterialApp(
          home: Scaffold(
            body: GiphyGridView(
              content: content,
              onContentUpdate: (count) => resultCount = count,
            ),
          ),
        );

    await tester.pumpWidget(grid(GiphyContentRequest.trendingGifs()));
    await waitFor(tester, () => resultCount > 0,
        reason: 'trending GIFs to load in the grid');

    resultCount = 0;
    await tester.pumpWidget(grid(GiphyContentRequest.search(
        mediaType: GiphyMediaType.sticker, searchQuery: 'cat')));
    await waitFor(tester, () => resultCount > 0,
        reason: 'sticker search results to load in the grid');
  }, timeout: testTimeout);

  testWidgets('media view renders a GIF and a sticker by ID', (tester) async {
    final errors = <String>[];
    final controller = GiphyMediaViewController();
    // SafeArea keeps the status bar and home indicator out of the measured areas.
    Widget page({required bool withMedia}) => MaterialApp(
          home: Scaffold(
            body: SafeArea(
                child: Column(children: [
              Expanded(
                child: SizedBox.expand(
                  key: const Key('gif'),
                  child: withMedia
                      ? GiphyMediaView(
                          mediaId: gifId,
                          controller: controller,
                          showCheckeredBackground: false,
                          onError: errors.add,
                        )
                      : null,
                ),
              ),
              Expanded(
                child: SizedBox.expand(
                  key: const Key('sticker'),
                  child: withMedia
                      ? GiphyMediaView(
                          mediaId: stickerId,
                          showCheckeredBackground: false,
                          onError: errors.add,
                        )
                      : null,
                ),
              ),
            ])),
          ),
        );

    await tester.pumpWidget(page(withMedia: false));
    await tester.pumpAndSettle();
    final gifArea = tester.getRect(find.byKey(const Key('gif')));
    final stickerArea = tester.getRect(find.byKey(const Key('sticker')));

    await tester.pumpWidget(page(withMedia: true));
    await waitForScreen(binding, tester, (shot) {
      if (errors.isNotEmpty) fail('Media view reported: ${errors.join(', ')}');
      // Measured on iOS: an empty or never-loaded view has 1 color; the loaded GIF
      // ~1100 and the sticker ~500.
      return shot.distinctColors(gifArea) > 200 &&
          shot.distinctColors(stickerArea) > 100;
    }, reason: 'the GIF and the sticker to render');

    await controller.pause();
    await controller.resume();
    expect(errors, isEmpty);
  }, skip: !screenshotsShowNativeViews, timeout: testTimeout);

  testWidgets('media view reports an error for an unknown ID', (tester) async {
    String? error;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GiphyMediaView(mediaId: missingId, onError: (e) => error = e),
      ),
    ));
    await waitFor(tester, () => error != null,
        reason: 'the native SDK to report the unknown media ID');
  }, timeout: testTimeout);

  testWidgets('media view ignores the answer for media it no longer shows',
      (tester) async {
    final errors = <String>[];
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GiphyMediaView(mediaId: '${missingId}1', onError: errors.add),
      ),
    ));

    // An unknown ID that fails shows the native view exists and answers.
    await waitFor(tester, () => errors.isNotEmpty,
        reason: 'the first unknown media ID to fail');

    // Ask for another unknown ID and replace it right away, before its lookup can fail.
    // The calls go straight to the view's channel: changing the widget twice would
    // wait for a frame in between, which on an emulator can outlast the lookup.
    errors.clear();
    final channel =
        MethodChannel('com.giphyfluttersdk/mediaView${nativeViewId(tester)}');
    unawaited(channel.invokeMethod('setMediaId', {'mediaId': '${missingId}2'}));
    await channel.invokeMethod('setMediaId', {'mediaId': gifId});
    await tester.pump(const Duration(seconds: 5));

    expect(errors, isEmpty,
        reason: 'The view reported the lookup for media it no longer shows');
  }, timeout: testTimeout);

  testWidgets('video view plays, mutes, pauses and resumes a clip',
      (tester) async {
    final clipId = await trendingClipId();
    final states = <GiphyVideoViewPlaybackState>[];
    final muteEvents = <String>[];
    final errors = <String>[];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GiphyVideoView(
          mediaId: clipId,
          autoPlay: true,
          muted: false,
          onPlaybackStateChanged: states.add,
          onMute: () => muteEvents.add('mute'),
          onUnmute: () => muteEvents.add('unmute'),
          onError: errors.add,
        ),
      ),
    ));
    await waitFor(
        tester, () => states.contains(GiphyVideoViewPlaybackState.playing),
        reason: 'clip $clipId to start playing');

    // Muting a clip that plays with sound must report onMute, not onUnmute.
    muteEvents.clear();
    GiphyVideoManager.instance.muteAll();
    await waitFor(tester, () => muteEvents.isNotEmpty,
        reason: 'the clip to report that it was muted');
    expect(muteEvents.first, 'mute');

    states.clear();
    GiphyVideoManager.instance.pauseAll();
    await waitFor(
        tester, () => states.contains(GiphyVideoViewPlaybackState.paused),
        reason: 'clip to pause');

    states.clear();
    GiphyVideoManager.instance.resume();
    await waitFor(
        tester, () => states.contains(GiphyVideoViewPlaybackState.playing),
        reason: 'clip to resume');

    expect(errors, isEmpty);
  }, timeout: testTimeout);

  testWidgets(
      'video view pauses in the background and plays again in the foreground',
      (tester) async {
    final clipId = await trendingClipId();
    final states = <GiphyVideoViewPlaybackState>[];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GiphyVideoView(
          mediaId: clipId,
          autoPlay: true,
          muted: true,
          onPlaybackStateChanged: states.add,
        ),
      ),
    ));
    await waitFor(
        tester, () => states.contains(GiphyVideoViewPlaybackState.playing),
        reason: 'clip $clipId to start playing');

    states.clear();
    sendAppLifecycleState(AppLifecycleState.paused);
    // A paused app draws no frames, so wait without pumping.
    await waitForCallback(
        () => states.contains(GiphyVideoViewPlaybackState.paused),
        reason: 'the clip to pause in the background');

    states.clear();
    sendAppLifecycleState(AppLifecycleState.resumed);
    await waitFor(
        tester, () => states.contains(GiphyVideoViewPlaybackState.playing),
        reason: 'the clip to play again in the foreground');
  }, timeout: testTimeout);
}

/// Sends the lifecycle message the engine sends when the app changes state. Flutter then
/// reports every step in between to observers, as it does on a device.
void sendAppLifecycleState(AppLifecycleState state) {
  ui.channelBuffers.push('flutter/lifecycle',
      const StringCodec().encodeMessage(state.toString())!, (_) {});
}

/// Waits in real time, without pumping frames, until [condition] is true.
Future<void> waitForCallback(bool Function() condition,
    {required String reason,
    Duration timeout = const Duration(seconds: 30)}) async {
  final deadline = DateTime.now().add(timeout);
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      fail('Timed out after ${timeout.inSeconds}s waiting for $reason');
    }
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
}

/// Pumps frames until [condition] is true, failing after [timeout].
Future<void> waitFor(WidgetTester tester, bool Function() condition,
    {required String reason,
    Duration timeout = const Duration(seconds: 30)}) async {
  final deadline = DateTime.now().add(timeout);
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      fail('Timed out after ${timeout.inSeconds}s waiting for $reason');
    }
    await tester.pump(const Duration(milliseconds: 250));
  }
}

/// The platform view ID of the only native view on screen.
int nativeViewId(WidgetTester tester) => Platform.isIOS
    ? tester.allRenderObjects
        .whereType<RenderUiKitView>()
        .single
        .viewController
        .id
    : tester.allRenderObjects
        .whereType<RenderAndroidView>()
        .single
        .controller
        .viewId;

/// Takes screenshots until one satisfies [condition], failing after [timeout].
Future<void> waitForScreen(IntegrationTestWidgetsFlutterBinding binding,
    WidgetTester tester, bool Function(Shot shot) condition,
    {required String reason,
    Duration timeout = const Duration(seconds: 30)}) async {
  final deadline = DateTime.now().add(timeout);
  while (!condition(await Shot.capture(binding, tester))) {
    if (DateTime.now().isAfter(deadline)) {
      fail('Timed out after ${timeout.inSeconds}s waiting for $reason');
    }
    await tester.pump(const Duration(milliseconds: 500));
  }
}

/// A screenshot of the whole screen, including native views, as RGBA pixels.
class Shot {
  Shot._(this.pixels, this.width, this.height, this.scale);

  final Uint8List pixels;
  final int width;
  final int height;

  /// Screenshot pixels per logical pixel.
  final double scale;

  static var _count = 0;

  static Future<Shot> capture(
      IntegrationTestWidgetsFlutterBinding binding, WidgetTester tester) async {
    final png = await binding.takeScreenshot('shot-${_count++}');
    final codec = await ui.instantiateImageCodec(Uint8List.fromList(png));
    ui.Image? image;
    try {
      image = (await codec.getNextFrame()).image;
      final rgba = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      final logicalWidth =
          tester.view.physicalSize.width / tester.view.devicePixelRatio;
      return Shot._(rgba!.buffer.asUint8List(), image.width, image.height,
          image.width / logicalWidth);
    } finally {
      // Polling takes many screenshots; release the native image memory now.
      image?.dispose();
      codec.dispose();
    }
  }

  /// Fraction of sampled pixels in [area] that differ noticeably from [other].
  double changedFraction(Shot other, Rect area) {
    var changed = 0, total = 0;
    _sample(area, (i) {
      total++;
      if ((pixels[i] - other.pixels[i]).abs() > 40 ||
          (pixels[i + 1] - other.pixels[i + 1]).abs() > 40 ||
          (pixels[i + 2] - other.pixels[i + 2]).abs() > 40) {
        changed++;
      }
    });
    return total == 0 ? 0 : changed / total;
  }

  /// Number of distinct colors (4 bits per channel) among sampled pixels in [area].
  /// A solid background has one; a loaded GIF or sticker has hundreds.
  int distinctColors(Rect area) {
    final colors = <int>{};
    _sample(area, (i) {
      colors.add((pixels[i] >> 4) << 8 |
          (pixels[i + 1] >> 4) << 4 |
          pixels[i + 2] >> 4);
    });
    return colors.length;
  }

  void _sample(Rect area, void Function(int index) visit) {
    final left = (area.left * scale).round().clamp(0, width);
    final right = (area.right * scale).round().clamp(0, width);
    final top = (area.top * scale).round().clamp(0, height);
    final bottom = (area.bottom * scale).round().clamp(0, height);
    for (var y = top; y < bottom; y += 4) {
      for (var x = left; x < right; x += 4) {
        visit((y * width + x) * 4);
      }
    }
  }
}

/// Fetches the ID of a currently trending clip, so the test doesn't depend on
/// one clip staying online. Gives up after [timeout] and aborts the request.
Future<String> trendingClipId(
    {Duration timeout = const Duration(seconds: 20)}) async {
  final client = HttpClient()..connectionTimeout = timeout;
  try {
    return await () async {
      final request = await client.getUrl(Uri.https('api.giphy.com',
          '/v1/clips/trending', {'api_key': apiKey, 'limit': '1'}));
      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();
      if (response.statusCode != HttpStatus.ok) {
        throw StateError('Clips request failed: HTTP ${response.statusCode}');
      }
      final clips = jsonDecode(body)['data'] as List;
      if (clips.isEmpty) throw StateError('No trending clips returned');
      return clips.first['id'] as String;
    }()
        .timeout(timeout, onTimeout: () {
      client.close(force: true);
      throw TimeoutException('Trending clips request', timeout);
    });
  } finally {
    client.close(force: true);
  }
}
