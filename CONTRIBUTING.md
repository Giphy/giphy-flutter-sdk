# Contributing

We want this community to be friendly and respectful to each other. Please follow it in all your interactions with the
project.

## Development workflow

### Install dependencies

Developing the plugin needs Flutter 3.47.0 or newer, because the example app builds for Android with AGP 9 built-in
Kotlin. Apps that use the plugin don't have this requirement.

To get started with the project, run `flutter pub get` in the root directory to install the required dependencies for each package:

```sh
flutter pub get
```

To edit the Swift files, open `example/ios/Runner.xcworkspace` in Xcode and find the package source
files under `Flutter > giphy_flutter_sdk`, or edit them directly in `ios/giphy_flutter_sdk/Sources/giphy_flutter_sdk`.

To edit the Kotlin files, open `example/android` in Android studio and find the source files at `giphy_flutter_sdk`
under `Android`.

While developing, you can run the [example app](/example/) to test your changes. Any changes you make in your library's
Dart and the native code will be reflected in the example app.

### Run the example app

- To run the example application, you need to configure the GIPHY API keys. To do this,
  you can copy the `config_example.dart` file and fill in the necessary variables:
  ```sh
  cp example/lib/config_example.dart example/lib/config.dart
  ```

- To list all available devices IDs:
  ```sh
  flutter devices
  ```

- Run the example app:
  ```sh
  cd example && flutter run -d YOUR_DEVICE_ID && cd ..
  ```

- The iOS example uses Swift Package Manager. If you turn it off to test the CocoaPods route, Flutter generates
  `example/ios/Podfile` from its template, which has a `target 'RunnerTests'` block. The example has no `RunnerTests`
  target, so delete that block before running `pod install`.

### Linting and tests

We use the [Dart analyzer](https://dart.dev/tools/analysis) for static analysis, Dart
[unit tests](https://docs.flutter.dev/testing/overview#unit-tests) for the plugin's Dart code, and Flutter
[integration tests](https://docs.flutter.dev/testing/integration-tests) to test the plugin against the
native GIPHY SDKs.

Make sure your code passes the analyzer and the unit tests. Run the following to verify:

```sh
flutter analyze --no-fatal-infos
flutter test
```

The unit tests live in `test/` and need no device. They check the messages the Dart API sends to and receives from
the native side, and the JSON format of settings, content requests, themes and media.

Also before doing a release you should run the integration tests locally, on an iOS simulator and an Android emulator:

```sh
cd example && flutter test integration_test -d YOUR_DEVICE_ID && cd ..
```

The integration tests live in `example/integration_test/` and run in the example app, so they need:

- ✅ The GIPHY API keys in `example/lib/config.dart` (see [Run the example app](#run-the-example-app))
- ✅ Network access, because they load live GIPHY content
- ✅ A booted iOS Simulator or Android emulator (list them with `flutter devices`)

Flutter tests can't tap inside native views, so each test checks what the native side reports back: grid content
loaded, video playback state, errors. The dialog and media view tests check a screenshot instead and run on iOS only
for now.

### Publishing to pub.dev

- *note* While we welcome feedback and prs, publishing new versions of the project to pub.dev is reserved for GIPHY engineers. 

- Dry Run to validate and ensure that everything is set up correctly before performing the actual publication
  ```sh
  flutter pub publish --dry-run
  ```

- Authenticate Using pub
  ```sh
  flutter pub login
  ```

- Publish
  ```sh
  flutter pub publish
  ```

### Scripts

- `scripts/sdk.sh bump android`: update the GIPHY Android SDK to the latest version.
- `scripts/sdk.sh bump ios`: update the GIPHY iOS SDK to the latest version.
- `scripts/sdk.sh bump`: increment the Flutter package patch version in `pubspec.yaml`.
- `scripts/sdk.sh bump patch`: explicitly increment the Flutter package patch version in `pubspec.yaml`.
- `scripts/sdk.sh bump minor`: increment the Flutter package minor version in `pubspec.yaml` and reset patch to `0`.
- `scripts/sdk.sh bump major`: increment the Flutter package major version in `pubspec.yaml` and reset minor and patch to `0`.
- `scripts/sdk.sh bump 1.2.3`: set the Flutter package version in `pubspec.yaml` to an exact version.
- `scripts/sdk.sh clean`: clean generated build artifacts and caches for the SDK package and example app. This runs `flutter clean` for the root package and example app, runs `./gradlew clean` for the example Android app, and removes generated Flutter, Gradle, CocoaPods, SwiftPM, and iOS build artifacts.
- `scripts/sdk.sh clean --with-lockfiles`: also remove `pubspec.lock`, `example/ios/Podfile.lock`, and SwiftPM `Package.resolved` files when you need fresh dependency resolution.
- `scripts/sdk.sh publish-dry-run`: run `flutter pub publish --dry-run` from the SDK package root.
- `scripts/sdk.sh publish`: run `flutter pub publish` from the SDK package root.

### Sending a pull request

> **Working on your first pull request?** You can learn how from this _free_
>
series: [How to Contribute to an Open Source Project on GitHub](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github).

When you're sending a pull request:

- Prefer small pull requests focused on one change.
- Verify that linters and tests are passing.
- Review the documentation to make sure it looks good.
- Follow the pull request template when opening a pull request.
- For pull requests that change the API or implementation, discuss with maintainers first by opening an issue.
