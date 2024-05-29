# Contributing

We want this community to be friendly and respectful to each other. Please follow it in all your interactions with the
project.

## Development workflow

### Install dependencies

To get started with the project, run `flutter pub get` in the root directory to install the required dependencies for each package:

```sh
flutter pub get
```

To edit the Swift files, open `example/ios/Runner.xcworkspace` in XCode and find the source
files at `Pods > Development Pods > giphy_flutter_sdk`.

To edit the Kotlin files, open `example/android` in Android studio and find the source files at `giphy_flutter_sdk`
under `Android`.

While developing, you can run the [example app](/example/) to test your changes. Any changes you make in your library's
Dart and the native code will be reflected in the example app.

### Run the example app

- To run the example application, you need to configure the GIPHY API keys. To do this,
  you can copy the `config.example.dart` file and fill in the necessary variables:
  ```sh
  cp example/lib/config_example.dart/ example/lib/config.dart
  ```

- To list all available devices IDs:
  ```sh
  flutter devices
  ```

- Run the example app:
  ```sh
  cd example && flutter run -d YOUR_DEVICE_ID && cd ..
  ```


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
