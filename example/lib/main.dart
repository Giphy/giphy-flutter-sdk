import 'dart:io';

import 'package:flutter/material.dart';
import 'package:giphy_flutter_sdk/giphy_flutter_sdk.dart';
import 'package:giphy_flutter_sdk_example/main_screen.dart';
import 'config.dart' as config;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
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
          title: const Text('Giphy example app'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: const MainScreen(),
      ),
    );
  }
}
