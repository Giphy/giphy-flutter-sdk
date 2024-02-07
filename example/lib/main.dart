import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:giphy_flutter_sdk/giphy_flutter_sdk.dart';

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

  void initPlatformState() {
    try {
      GiphyFlutterSDKConfig config = GiphyFlutterSDKConfig(
        apiKey: 'YOUR_API_KEY', // Replace with your actual API key
        // Optional: Set verificationMode and videoCacheMaxBytes
      );

      GiphyFlutterSDK.configure(config);
    } catch (e) {
      // Handle any exceptions here
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
                onPressed: () {
                  //GiphyFlutterSDK.show();
                },
                child: Text('Open Giphy'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
