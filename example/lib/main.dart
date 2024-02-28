import 'dart:io';

import 'package:flutter/material.dart';
import 'package:giphy_flutter_sdk/dto/giphy_content_type.dart';
import 'package:giphy_flutter_sdk/dto/giphy_media.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rating.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rendition.dart';
import 'package:giphy_flutter_sdk/dto/giphy_settings.dart';
import 'package:giphy_flutter_sdk/dto/giphy_theme.dart';
import 'package:giphy_flutter_sdk/giphy_dialog.dart';
import 'package:giphy_flutter_sdk/giphy_media_view.dart';
import 'package:giphy_flutter_sdk/giphy_flutter_sdk.dart';
import 'config.dart' as config;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements GiphyMediaSelectionListener {
  Media? _selectedMedia;
  final controller = GiphyMediaViewController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    GiphyDialog.instance.addListener(this);
  }

  @override
  void dispose() {
    GiphyDialog.instance.removeListener(this);
    super.dispose();
  }

  void initPlatformState() {
    try {
      Map<String, String> platformApiKeyMap = {
        'android': config.androidGiphyApiKey,
        'iOS': config.iOSGiphyApiKey,
      };

      String? platform = Platform.isAndroid
          ? 'android'
          : Platform.isIOS
              ? 'iOS'
              : null;
      if (platform != null && platformApiKeyMap.containsKey(platform)) {
        String? apiKey = platformApiKeyMap[platform];
        if (apiKey == null) {
          throw Exception('API key for $platform is null');
        }
        GiphyFlutterSDK.configure(apiKey: apiKey);
      } else {
        throw Exception('Unsupported platform or API key not configured');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Giphy example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: showGiphyDialog,
                child: const Text('Open Giphy Dialog'),
              ),
              if (_selectedMedia != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AspectRatio(
                    aspectRatio: _selectedMedia?.aspectRatio ?? 1.0,
                    child: GiphyMediaView(
                        controller: controller,
                        media: _selectedMedia,
                        autoPlay: true,
                        renditionType: GiphyRendition.fixedWidth),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.pause();
                      },
                      child: const Text('Pause'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        controller.resume();
                      },
                      child: const Text('Resume'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void showGiphyDialog() {
    GiphyTheme theme = GiphyTheme.fromPreset(
        preset: GiphyThemePreset.automatic,
        searchTextColor: Colors.amberAccent);
    GiphyDialog.instance.configure(
        settings: GiphySettings(
            theme: theme,
            mediaTypeConfig: [
              GiphyContentType.gif,
              GiphyContentType.sticker,
            ],
            rating: GiphyRating.pg13,
            renditionType: GiphyRendition.fixedWidth,
            stickerColumnCount: 2,
            showSuggestionsBar: true));
    GiphyDialog.instance.show();
  }

  @override
  void onMediaSelect(Media media) {
    setState(() {
      _selectedMedia = media;
    });
  }

  @override
  void onDismiss() {
    print("Giphy dialog dismissed");
  }
}
