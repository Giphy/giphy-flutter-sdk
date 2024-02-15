import 'dart:io';

import 'package:flutter/material.dart';
import 'package:giphy_flutter_sdk/dto/giphy_content_type.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rendition.dart';
import 'package:giphy_flutter_sdk/dto/giphy_settings.dart';
import 'package:giphy_flutter_sdk/dto/giphy_theme.dart';
import 'package:giphy_flutter_sdk/giphy_dialog.dart';
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

class _MyAppState extends State<MyApp> implements MediaSelectionListener {
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
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Hello'),
              ElevatedButton(
                onPressed: showGiphyDialog,
                child: Text('Open Giphy'),
              ),
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
            renditionType: GiphyRendition.fixedWidth,
            stickerColumnCount: 4,
            showSuggestionsBar: false,
            mediaTypeConfig: [GiphyContentType.sticker, GiphyContentType.gif]));
    GiphyDialog.instance.show();
  }

  @override
  void onMediaSelect(String media) {
    print("Selected media: $media");
  }

  @override
  void onDismiss() {
    print("Giphy dialog dismissed");
  }
}
