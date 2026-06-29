## 1.1.1

### Native SDKs

- Giphy Android SDK [v2.5.1](https://github.com/Giphy/giphy-android-sdk/releases/tag/v2.5.1)
- Giphy iOS SDK [v2.3.2](https://github.com/Giphy/giphy-ios-sdk/releases/tag/2.3.2)


## 1.1.0

### Build System
- Migrate Android Gradle setup toward AGP 9 built-in Kotlin support.
- The plugin now uses AGP built-in Kotlin on AGP 9+ when built-in Kotlin is enabled.
- The plugin still falls back to the Kotlin Gradle Plugin for AGP < 9.
- For compatibility, AGP 9+ consumers that explicitly set `android.builtInKotlin=false` also use the Kotlin Gradle Plugin fallback. Those builds may still show AGP's KGP deprecation warning for `:giphy_flutter_sdk`.
- AGP 9+ consumers can keep `android.newDsl=false` for Flutter's temporary legacy DSL compatibility, but should leave built-in Kotlin enabled to avoid the SDK KGP warning.
- Android Java/Kotlin compilation now targets JVM 17.
- The Android plugin default `GiphyFlutterSDK.compileSdkVersion` is now 34.
- Update the Android example project Gradle setup for AGP 9 and Flutter 3.44 compatibility.
- Add iOS Swift Package Manager support for the plugin while keeping CocoaPods support for existing consumers.
- Migrate the iOS example app from CocoaPods to Flutter Swift Package Manager integration.

### Developer Tooling
- Add `scripts/sdk.sh clean` to remove generated Flutter, Gradle, CocoaPods, SwiftPM, and iOS build artifacts from the SDK package and example app.
- Update `scripts/sdk.sh bump ios` to keep the iOS `Package.swift` dependency version in sync with the podspec.
- Add `scripts/sdk.sh bump [patch|minor|major|x.y.z]` to update the Flutter package version in `pubspec.yaml`.
- Add `scripts/sdk.sh publish-dry-run` and `scripts/sdk.sh publish` helpers for pub.dev publishing.

### Bug Fixes
- Address [Android build fails: giphy_flutter_sdk defaults to compileSdk 33 but dependencies require compileSdk 34+](https://github.com/Giphy/giphy-flutter-sdk/issues/59)
- Address [Migrate Android Gradle setup to AGP 9 built-in Kotlin support](https://github.com/Giphy/giphy-flutter-sdk/issues/60)
- Address [Support for Swift Package Manager](https://github.com/Giphy/giphy-flutter-sdk/issues/61)

## 1.0.9

### Native SDKs

- Giphy Android SDK [v2.4.2](https://github.com/Giphy/giphy-android-sdk/releases/tag/v2.4.2)
- Giphy iOS SDK [v2.3.2](https://github.com/Giphy/giphy-ios-sdk/releases/tag/2.3.2)

### Bug Fixes
- Address [Some stickers are returning as GiphyMediaType.text on iOS](https://github.com/Giphy/giphy-flutter-sdk/issues/56)

## 1.0.8

### Native SDKs

- Giphy Android SDK [v2.4.2](https://github.com/Giphy/giphy-android-sdk/releases/tag/v2.4.2)
- Giphy iOS SDK [v2.3.1](https://github.com/Giphy/giphy-ios-sdk/releases/tag/2.3.1)

### Bug Fixes
- Address [Selecting Explicit Gifs and Stickers does not return on iOS](https://github.com/Giphy/giphy-flutter-sdk/issues/54)

## 1.0.7

### Native SDKs

- Giphy Android SDK [v2.4.1](https://github.com/Giphy/giphy-android-sdk/releases/tag/v2.4.1)
- Giphy iOS SDK [v2.3.1](https://github.com/Giphy/giphy-ios-sdk/releases/tag/2.3.1)

### Bug Fixes
- Address [disableEmojiVariations does not work on iOS](https://github.com/Giphy/giphy-flutter-sdk/issues/51)
- Address [Bottom safe area not respected / covered up by GiphyDialog on Android](https://github.com/Giphy/giphy-flutter-sdk/issues/52)

## 1.0.6

### Native SDKs

- Giphy Android SDK [v2.4.1](https://github.com/Giphy/giphy-android-sdk/releases/tag/v2.4.1)
- Giphy iOS SDK [v2.3.0](https://github.com/Giphy/giphy-ios-sdk/releases/tag/2.3.0)

### Bug Fixes
- Address [Selecting Emoji does not return on iOS](https://github.com/Giphy/giphy-flutter-sdk/issues/47)

## 1.0.5

### Native SDKs

- Giphy Android SDK [v2.3.17](https://github.com/Giphy/giphy-android-sdk/releases/tag/v2.3.17)
- Giphy iOS SDK [v2.2.16](https://github.com/Giphy/giphy-ios-sdk/releases/tag/2.2.16)
  
### Features

- [android] Add Edge-To-Edge support ([cb32804](https://github.com/Giphy/giphy-flutter-sdk/commit/cb3280480adb6d7abdb63e518049c75d758b0e86))

## 1.0.4

### Native SDKs

- Giphy Android SDK [v2.3.16](https://github.com/Giphy/giphy-android-sdk/releases/tag/v2.3.16)
- Giphy iOS SDK [v2.2.16](https://github.com/Giphy/giphy-ios-sdk/releases/tag/v2.2.16)

## 1.0.3

### Native SDKs

- Giphy Android SDK [v2.3.16](https://github.com/Giphy/giphy-android-sdk/releases/tag/v2.3.16)
- Giphy iOS SDK [v2.2.15](https://github.com/Giphy/giphy-ios-sdk/releases/tag/v2.2.15)

### Bug Fixes
- Address [The method 'toARGB32' isn't defined for the class 'Color'](https://github.com/Giphy/giphy-flutter-sdk/issues/40)

## 1.0.2

### Native SDKs

- Giphy Android SDK [v2.3.16](https://github.com/Giphy/giphy-android-sdk/releases/tag/v2.3.16)
- Giphy iOS SDK [v2.2.15](https://github.com/Giphy/giphy-ios-sdk/releases/tag/v2.2.15)

### Static Analysis
- Address Static Analysis issues

### Documentation
- Update the minimum required Xcode version.

### Build System
* bump Android AGP version from 7.3.0 to 8.1.0
* bump Android Gradle version from 8.0 to 8.3
* bump Kotlin version from 1.7.10 to 1.9.0

### Bug Fixes
* Remove the package from the AndroidManifest file 
based on the following PRs:
    - [#34](https://github.com/Giphy/giphy-flutter-sdk/pull/34)
    - [#32](https://github.com/Giphy/giphy-flutter-sdk/pull/32)

## 1.0.1

### Native SDKs

- Giphy Android SDK [v2.3.15](https://github.com/Giphy/giphy-android-sdk/releases/tag/v2.3.15)
- Giphy iOS SDK [v2.2.13](https://github.com/Giphy/giphy-ios-sdk/releases/tag/v2.2.13)

### Static Analysis
- Address Static Analysis issues

### Bug Fixes
- Add support for Xcode 16

## 1.0.0

### Native SDKs

- Giphy Android SDK [v2.3.15](https://github.com/Giphy/giphy-android-sdk/releases/tag/v2.3.15)
- Giphy iOS SDK [v2.2.10](https://github.com/Giphy/giphy-ios-sdk/releases/tag/v2.2.10)

### Documentation
- Add dartdoc comments

### Bug Fixes
- The GiphyMediaView: No Error Handling ([#25](https://github.com/Giphy/giphy-flutter-sdk/issues/25)) ([3cdee1e](https://github.com/Giphy/giphy-flutter-sdk/commit/3cdee1e93a401cb11ad9bfd71a7a667803c01c77))

## 0.1.2

### Native SDKs

- Giphy Android SDK [v2.3.13](https://github.com/Giphy/giphy-android-sdk/releases/tag/v2.3.13)
- Giphy iOS SDK [v2.2.9](https://github.com/Giphy/giphy-ios-sdk/releases/tag/v2.2.9)
