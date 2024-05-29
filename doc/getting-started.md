## Getting Started

### Requirements

- A Giphy Android SDK key from the [Giphy Developer Portal](https://developers.giphy.com/dashboard/?create=true).
  Please remember, you should use a separate key for every platform (Android, iOS, Web) you add our SDKs to.

- Android:
  - Giphy SDK only supports projects that have been upgraded
    to [androidx](https://developer.android.com/jetpack/androidx/)
  - Requires `minSdkVersion` 21
- iOS:
  - iOS 13.0 or later
  - Xcode 12 and later 

### Installation

Add the dependency

```
dependencies:
  giphy_flutter_sdk: any
```
*note* `any` pulls in the most recent official release by default

Install the Plugin
```
flutter pub get
```

Feel free to open an [issue](https://github.com/Giphy/giphy-flutter-sdk/issues) here in this repo if you run into
any problems.

### Basic Usage

We offer two solutions for the SDK user interface - pre-built templates which handle the entirety of the GIPHY experience, and a [Grid-Only implementation](https://developers.giphy.com/docs/sdk#grid) which allows for more customization.

See [customization](https://developers.giphy.com/docs/sdk#grid) to determine what's best for you.

- use [Giphy Dialog](api.md#giphydialog) for the plug and play GIPHY experience ([example](api.md#example-2)).
- use [Giphy Grid View](api.md#giphygridview) for a more customizable solution ([example](api.md#example-3)).
