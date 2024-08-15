## API Reference

- [GiphySDK](#giphyfluttersdk)
- [GiphyDialog](#giphydialog)
- [GiphyMediaView](#giphymediaview)
- [GiphyVideoView](#giphyvideoview)
- [GiphyVideoManager](#giphyvideomanager)
- [GiphyGridView](#giphygridview)
- [GiphyContent](#giphycontent)
- [GiphyTheme](#giphytheme)

## GiphyFlutterSDK

Contains methods for configuring basic parameters, such as API keys.

### </> configure: `void configure({required String apiKey, bool verificationMode = false})`

Configure basic settings of GIPHY SDK.

#### Options

| Option             | Description                                                                                                                                                                                                                                                                                                                                                                                                      | Type     | Default             | Platform                        |
|--------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|---------------------|---------------------------------|
| apiKey             | Android or iOS SDK key. Please remember, you should use a separate key for every platform (Android, iOS) you add our SDKs to.                                                                                                                                                                                                                                                                                    | `string` | `None`              | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| videoCacheMaxBytes | A number that defines the video cache size for ExoPlayer on the Android platform. <br/> `Note`: If `videoCacheMaxBytes` is 0, the cache initialization will be skipped, and [Giphy Clips](https://developers.giphy.com/docs/clips) will not work. You may want to skip this setting if you use another version of ExoPlayer that is not compatible with the Giphy SDK but still wish to receive gifs from Giphy. | `double` | `100 * 1024 * 1024` | ✅&nbsp;Android <br/> ❌&nbsp;iOS |

#### Example

```dart

import 'package:giphy_flutter_sdk/giphy_flutter_sdk.dart';

String? apiKey;
if (Platform.isAndroid) {
  apiKey = '*************'; // Android SDK key
} else if (Platform.isIOS) {
  apiKey = '*************'; // iOS SDK key
} else {
  throw Exception('Unsupported platform');
}
if (apiKey.isEmpty) {
  throw Exception('API key for the platform is null or not configured');
}
GiphyFlutterSDK.configure(apiKey: apiKey);
```

## GiphyDialog

Singleton, which provides pre-built templates that handle the entirety of the GIPHY experience.

### </> configure: `configure({GiphySettings? settings}`

Configure the `GiphyDialog` view and behavior.

#### Options

| Option                    | Description                                                                                                                                                                                                                                                                                                                                                                                    | Type                                                      | Default                                                                                 | Platform                        |
|---------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------|-----------------------------------------------------------------------------------------|---------------------------------|
| clipsPreviewRenditionType | Certain renditions (cases of the [`GiphyRendition`](../lib/dto/giphy_rendition.dart) enum) are not available for Clips. As a result, if you set the renditionType property of the [GiphyDialog](#giphydialog) to an unsupported rendition type, clips previews may not play back correctly in the grid. To account for this limitation, we created this property specifically to work with clips. | [`GiphyClipsRendition`](../lib/dto/giphy_rendition.dart#L23)     | `.FixedWidth`                                                                           | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| confirmationRenditionType | A rendition type for the confirmation screen.                                                                                                                                                                                                                                                                                                                                                  | [`GiphyRendition`](../lib/dto/giphy_rendition.dart)          | `.Original`                                                                             | ✅&nbsp;Android <br/> ❌&nbsp;iOS |
| enableDynamicText         | Allows to create animated text results for search queries where there are no matching results in GIPHY's library. [Learn more](./animated.md)                                                                                                                                                                                                                                                  | `bool`                                                 | `false`                                                                                 | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| fileFormat                  | A file format for the grid.                                                                                                                                                                                                                                                                                                                                                                      | [`GiphyFileFormat`](../lib/dto/giphy_file_format.dart)  | `.webp`                                                                                  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| mediaTypeConfig           | Type(s) of content to be displayed in the dialog. <br/> `Note`: Emoji only is not available for the carousel layout option.                                                                                                                                                                                                                                                                    | List<[`GiphyContentType`](../lib/dto/giphy_content_type.dart)> | <details><summary>Expand</summary>`[.recents, .gif, .sticker, .text, .emoji]`</details> | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| rating                    | A specific content rating for the search results.                                                                                                                                                                                                                                                                                                                                              | [`GiphyRating`](../lib/dto/giphy_rating.dart)                | `.pg13`                                                                                 | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| renditionType             | A rendition type for the grid.                                                                                                                                                                                                                                                                                                                                                                 | [`GiphyRendition`](../lib/dto/giphy_rendition.dart)          | `.fixedWidth`                                                                           | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| selectedContentType       | The default Giphy Content-Type.                                                                                                                                                                                                                                                                                                                                                                | [`GiphyContentType`](../lib/dto/giphy_content_type.dart)      | `.gif`                                                                                  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| showCheckeredBackground   | Enable/disable the checkered background for stickers and text media type.                                                                                                                                                                                                                                                                                                                      | `bool`                                                 | `false`                                                                                 | ✅&nbsp;Android <br/> ❌&nbsp;iOS |
| showConfirmationScreen    | Show a secondary confirmation screen when the user taps a GIF, which shows a larger rendition of the asset. This confirmation screen is only available for `GiphyDirection.vertical` mode - this property will be ignored if the layout is `GiphyDirection.horizontal`.                                                                                                                        | `bool`                                                 | `false`                                                                                 | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| showSuggestionsBar        | Show/hide a suggestions bar.                                                                                                                                                                                                                                                                                                                                                                   | `bool`                                                 | `true`                                                                                  | ✅&nbsp;Android <br/> ❌&nbsp;iOS |
| stickerColumnCount        | For carousel layouts, we provide the option to set the number of columns for stickers and text. We recommend using 3 columns for blurred mode.                                                                                                                                                                                                                                                 | `int`          | `3`                                                                                | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| theme                     | Adjust the GiphyDialog theme                                                                                                                                                                                                                                                                                                                                                                   | [`GiphyTheme`](#giphytheme)                               | `.automatic`                                                                                | ✅&nbsp;Android <br/> ✅&nbsp;iOS |

### </> show: `void show()`

Show the Giphy Dialog.

### </> hide: `void hide()`

Hide the Giphy Dialog.

### Supported events &#x1F514;

The `GiphyMediaSelectionListener` is an abstract class designed to handle events from the Giphy dialog. 
To use `GiphyMediaSelectionListener`, implement this abstract class in your widget state. The implementation requires defining two methods:

- onMediaSelect `void onMediaSelect(GiphyMedia media)`
- onDismiss `void onDismiss()`

which handle media selection and dialog dismissal, respectively.

#### Example

```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:giphy_flutter_sdk/dto/giphy_media.dart';
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

class _MyAppState extends State<MyApp> implements GiphyMediaSelectionListener {
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
      String? apiKey;
      if (Platform.isAndroid) {
        apiKey = config.androidGiphyApiKey;
      } else if (Platform.isIOS) {
        apiKey = config.iOSGiphyApiKey;
      } else {
        throw Exception('Unsupported platform');
      }
      if (apiKey.isEmpty) {
        throw Exception('API key for the platform is null or not configured');
      }
      GiphyFlutterSDK.configure(apiKey: apiKey);
      GiphyDialog.instance.addListener(this);
    } catch (e) {
      print(e);
    }
  }

  final List<GiphyMedia> _mediaList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Giphy Media Selection'),
      ),
      body: ListView.builder(
        itemCount: _mediaList.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ListTile(
              title: const Text('Show Dialog'),
              onTap: () {
                _showGiphyDialog();
              },
            );
          }
          final mediaIndex = index - 1;
          return Image(
              image: NetworkImage(
                  _mediaList[mediaIndex].images.original!.gifUrl!));
        },
      ),
    ));
  }

  void _showGiphyDialog() {
    GiphyDialog.instance.show();
  }

  @override
  void onMediaSelect(GiphyMedia media) {
    setState(() {
      _mediaList.insert(0, media);
    });
  }

  @override
  void onDismiss() {
    print("Giphy dialog dismissed");
  }
}
```

### Troubleshooting

On Android, the dialog requires using `FlutterFragmentActivity`. 
In your project's `MainActivity`, which is in the `android` folder, you'll need to replace:

```kotlin
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity()
```

with:

```kotlin
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity()
```

## GiphyMediaView

Designed to
render [GiphyMedia](../lib/dto/giphy_media.dart)
objects.

#### Props

| Prop                    | Description                                                                                     | Type                                                                                                                                      | Default       | Platform                        |
|-------------------------|-------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------|---------------|---------------------------------|
| autoPlay                | A boolean flag indicating whether or not the animation should start automatically when mounted. | `bool`                                                                                                                                 | `true`        | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| media                   | Pass a GiphyMedia object to display content.                                                    | [`GiphyMedia`](../lib/dto/giphy_media.dart) | `null`        | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| mediaId                   | Pass a GiphyMedia object ID to display content.                                                  | `String` | `null`        | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| renditionType           | A rendition type for the view.                                                                  | [`GiphyRendition`](../lib/dto/giphy_rendition.dart)                                                                                          | `.fixedWidth` | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| resizeMode              | Determines how to resize the image when the frame doesn't match the raw image dimensions.       | [`GiphyResizeMode`](../lib/dto/misc.dart#L9)                                                                                                        | `.Cover`      | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| showCheckeredBackground | Enable/disable the checkered background for stickers and text media type.                       | `bool`                                                                                                                                 | `true`        | ✅&nbsp;Android <br/> ❌&nbsp;iOS |
| onError                | A callback function that will be called when an error occurs whilst attempting to render media. | `Function(String description)? onError`                                                                              | `null`  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |

#### Methods (Imperative API)

`GiphyMediaView` widget is controlled via the `controller`: an instance of `GiphyMediaViewController`.

| Method | Description                   | Type         | Platform                        |
|--------|-------------------------------|--------------|---------------------------------|
| pause  | Pauses the animation.         | `Future<void>` | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| resume | Resumes the paused animation. | `Future<void>` | ✅&nbsp;Android <br/> ✅&nbsp;iOS |

#### ⚠️ GiphyMediaView and GIPHY Animated Text

If you use [GIPHY Animated Text](./animated.md) in your integration (`media.isDynamic == true`), please note that
`GiphyMediaView` does
not support it. For more information, please refer to [this article](./animated.md#giphymedia-and-dynamic-text).

#### Example

- **Basic usage**

You can update the example [above](./api.md#L147)

```dart
AspectRatio(
  aspectRatio: _mediaList[mediaIndex].aspectRatio,
  child: GiphyMediaView(
    media: _mediaList[mediaIndex],
    autoPlay: true,
    renditionType: GiphyRendition.fixedWidth));
```

- **Imperative API**

```dart
class GiphyMediaScreen extends StatefulWidget {
  const GiphyMediaScreen({super.key});

  @override
  _GiphyMediaScreenState createState() => _GiphyMediaScreenState();
}

class _GiphyMediaScreenState extends State<GiphyMediaScreen> {
  GiphyMediaViewController? controller;

  @override
  void initState() {
    super.initState();
    controller = GiphyMediaViewController();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  controller?.pause();
                },
                child: const Text('Pause'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  controller?.resume();
                },
                child: const Text('Resume'),
              ),
            ],
          ),
          AspectRatio(
              aspectRatio: 1,
              child: GiphyMediaView(
                controller: controller,
                mediaId: 'CnLRoQneO2kWHuRg7g',
                autoPlay: true,
                resizeMode: GiphyResizeMode.contain,
              )),
        ],
      ),
    );
  }
}
```

## GiphyVideoView

**Note**: If you use GIPHY Clips on the Android platform, you need
to [set up clips integration](clips.md#giphy-clips-setup-android-only) before working with the
GiphyVideoView component.

Similar to the [GiphyMediaView](#giphymediaview) which works for GIFs, Stickers, and Text, the GiphyVideoView is a
component that makes it easy to play back GiphyMedia clips video assets. The GiphyVideoView will only work for
GiphyMedia where the `isVideo` property is `true`.

**Note**: `GiphyVideoView` has no advanced features for playback, volume, and buffering control. If you need some
advanced features, you can easily integrate clips with other more advanced video players.

#### Props

| Prop                   | Description                                                                                   | Type                                                                                                                                      | Default | Platform                        |
|------------------------|-----------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------|---------|---------------------------------|
| autoPlay               | Set it to true to start the video automatically.                                              | `bool`                                                                                                                                 | `false` | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| media                  | Pass a GiphyMedia object to display content.                                                  | [`GiphyMedia`](https://github.com/Giphy/giphy-react-native-sdk/blob/4b0f2d614abb9a7116bdc530e7a39bf52d5424e2/src/native/types.ts#L65-L69) | `None`  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| mediaId                  | Pass a GiphyMedia object ID to display content.                                                  | `String` | `None`  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| muted                  | Set to true or false to mute or unmute the player.                                            | `bool`                                                                                                                                 | `false` | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| onError                | A callback function that will be called when an error occurs whilst attempting to play media. | `Function(String description)? onError`                                                                              | `null`  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| onMute                 | A callback function that will be called when media is muted.                                  | `Function()? onMute`                                                                                                   | `null`  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| onPlaybackStateChanged | A callback function that will be called when playback state changes.                          | `Function(GiphyVideoViewPlaybackState state)? onPlaybackStateChanged`                                                               | `null`  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| onUnmute               | A callback function that will be called when media is unmuted.                                | `Function()? onUnmute`                                                                                                   | `null`  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |

#### Example

```dart
child: AspectRatio(
  aspectRatio: _mediaList[index].aspectRatio,
  child: _mediaList[index].isVideo
      ? GiphyVideoView(
          media: _mediaList[index],
          autoPlay: true,
          muted: false,
        )
      : _GiphyMediaView(
          media: _mediaList[index],
          autoPlay: true,
          renditionType: GiphyRendition.fixedWidth,
        ),
),
```

## GiphyVideoManager

The module that allows you to control GiphyVideoView players.

### </> muteAll: `void muteAll()`

Mute active GiphyVideoView player.

### </> pauseAll: `void pauseAll()`

Pause active GiphyVideoView player.

### </> resume: `void resume()`

Resume the playback.

#### Example

```dart
GiphyVideoManager.instance.muteAll();
GiphyVideoManager.instance.pauseAll();
GiphyVideoManager.instance.resume();
```

## GiphyGridView

Customizable implementation of a Giphy Grid only.

#### Props

| Prop                      | Description                                                                                                                                                                                                                                                                                                                                                                                        | Type                                                                                    | Default                                 | Platform                        |
|---------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|-----------------------------------------|---------------------------------|
| cellPadding               | Spacing between rendered GIFs.                                                                                                                                                                                                                                                                                                                                                                     | `double`<br/><b>Note</b>: On iOS, only values between 0 and 11 inclusive are supported. | `0`                                     | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| clipsPreviewRenditionType | Certain renditions (cases of the [`GiphyRendition`](../lib/dto/giphy_rendition.dart) enum) are not available for Clips. As a result, if you set the renditionType property of the [GiphyGridView](#giphygridview) to an unsupported rendition type, clips previews may not play back correctly in the grid. To account for this limitation, we created this property specifically to work with clips. | [`GiphyClipsRendition`](../lib/dto/giphy_rendition.dart#L23)                                   | `.fixedWidth`                           | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| content                   | A `GiphyContentRequest` object describing a content request to the Giphy API.                                                                                                                                                                                                                                                                                                                      | [`GiphyContentRequest`](../lib/dto/giphy_content_request.dart)                              | `None`                                  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| disableEmojiVariations    | If true, the emoji variations drawer is not rendered.                                                                                                                                                                                                                                                                                                                                              | `bool`                                                                               | `false`                                  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| fixedSizeCells            | Display content in equally sized cells (for stickers only).                                                                                                                                                                                                                                                                                                                                        | `bool`                                                                               | `false`                                 | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| onContentUpdate           | A callback function that will be called when a content is updated.                                                                                                                                                                                                                                                                                                                                 | `Function(int resultCount)? onContentUpdate`                            | `null`                                  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| onMediaSelect             | A callback function that will be called when a media is selected.                                                                                                                                                                                                                                                                                                                                  | `Function(GiphyMedia media)? onMediaSelect`                              | `null`                                  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| onScroll                  | A callback function that will be called when a grid is being scrolled.                                                                                                                                                                                                                                                                                                                             | `Function(double offset)? onScroll`                                 | `null`                                  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| orientation               | Tells the scroll direction of the grid. (e.g. `GiphyDirection.horizontal`, `GiphyDirection.vertical`)                                                                                                                                                                                                                                                                                              | [`GiphyDirection`](../lib/dto/misc.dart#L7)                                                  | `.vertical`                             | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| renditionType             | A rendition type for the grid.                                                                                                                                                                                                                                                                                                                                                                     | [`GiphyRendition`](../lib/dto/giphy_rendition.dart)                                        | `.fixedWidth`                           | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| spanCount                 | Number of lanes in the grid.                                                                                                                                                                                                                                                                                                                                                                       | `int`                                                                                | Depends on orientation and content type | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| showCheckeredBackground   | Show/Hide checkered background for stickers in the grid.                                                                                                                                                                                                                                                                                                                                           | `bool`                                                                               | `false`                                 | ✅&nbsp;Android <br/> ❌&nbsp;iOS |
| theme                     | Adjust the GiphyGridView theme                                                                                                                                                                                                                                                                                                                                                                     | [`GiphyTheme`](#giphytheme)                                                             | `.automatic`                                | ✅&nbsp;Android <br/> ✅&nbsp;iOS |

#### Example

```dart
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    GiphyFlutterSDK.configure(apiKey: '*************');
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Giphy example app'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: GiphyGridView(
            content: const GiphyContentRequest(
                mediaType: GiphyMediaType.gif,
                requestType: GiphyContentRequestType.search,
                searchQuery: "cat"),
            onMediaSelect: (GiphyMedia media) {
              print("Selected media:${media.id}");
            },
          ),
        )
      ]),
    ));
  }
```

## GiphyContent

Provides methods to describe a content request to the Giphy API.

### </> search: `GiphyContentRequest.search({required GiphyMediaType mediaType, GiphyRating rating = GiphyRating.pg13, required String searchQuery})`

#### Options

| Option      | Description                                                    | Type                                             | Default | Platform                        |
|-------------|----------------------------------------------------------------|--------------------------------------------------|---------|---------------------------------|
| mediaType   | A media type that should be loaded (e.g. `GiphyMediaType.gif`) | [`GiphyMediaType`](../lib/dto/giphy_media_type.dart) | `.gif`  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| rating      | Filter query results by specific content rating                | [`GiphyRating`](../lib/dto/giphy_rating.dart)       | `.pg13` | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| searchQuery | A custom search input (e.g. cats)                              | `String`                                         | `null`  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |

### </> trending: `GiphyContentRequest.trending({required GiphyMediaType mediaType,GiphyRating rating = GiphyRating.pg13})`

#### Options

| Option    | Description                                                    | Type                                             | Default | Platform                        |
|-----------|----------------------------------------------------------------|--------------------------------------------------|---------|---------------------------------|
| mediaType | A media type that should be loaded (e.g. `GiphyMediaType.gif`) | [`GiphyMediaType`](../lib/dto/giphy_media_type.dart) | `.gif`  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| rating    | Filter query results by specific content rating                | [`GiphyRating`](../lib/dto/giphy_rating.dart)       | `.pg13` | ✅&nbsp;Android <br/> ✅&nbsp;iOS |

### </> trendingGifs: `GiphyContentRequest.trendingGifs({GiphyRating rating = GiphyRating.pg13})`

#### Options

| Option | Description                                     | Type                                       | Default | Platform                        |
|--------|-------------------------------------------------|--------------------------------------------|---------|---------------------------------|
| rating | Filter query results by specific content rating | [`GiphyRating`](../lib/dto/giphy_rating.dart) | `.pg13` | ✅&nbsp;Android <br/> ✅&nbsp;iOS |

### </> trendingStickers: `GiphyContentRequest.trendingStickers({GiphyRating rating = GiphyRating.pg13})`

#### Options

| Option | Description                                     | Type                                       | Default | Platform                        |
|--------|-------------------------------------------------|--------------------------------------------|---------|---------------------------------|
| rating | Filter query results by specific content rating | [`GiphyRating`](../lib/dto/giphy_rating.dart) | `.pg13` | ✅&nbsp;Android <br/> ✅&nbsp;iOS |

### </> trendingText: `GiphyContentRequest.trendingText({GiphyRating rating = GiphyRating.pg13})`

#### Options

| Option | Description                                     | Type                                       | Default | Platform                        |
|--------|-------------------------------------------------|--------------------------------------------|---------|---------------------------------|
| rating | Filter query results by specific content rating | [`GiphyRating`](../lib/dto/giphy_rating.dart) | `.pg13` | ✅&nbsp;Android <br/> ✅&nbsp;iOS |

### </> recents: `GiphyContentRequest.recents()`

#### Description

GIFs that are selected by the user are automatically added to the recents tab, which is only displayed if the user has previously picked a gif.

Users can remove gifs from recents with a long-press on the GIF in the recents grid.

### </> emoji: `GiphyContentRequest.emoji()`

### </> animate: `GiphyContentRequest.animate(String input)`

#### Options

| Option      | Description                                     | Type                                       | Default | Platform                        |
|-------------|-------------------------------------------------|--------------------------------------------|---------|---------------------------------|
| input | A custom search input (e.g. cats)               | `String`                                   | `None`  | ✅&nbsp;Android <br/> ✅&nbsp;iOS |

[Learn more](./animated.md)

### Example

```dart
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    GiphyFlutterSDK.configure(apiKey: '*************');
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Giphy example app'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: GiphyGridView(
            content: GiphyContentRequest.trendingGifs(),
            onMediaSelect: (GiphyMedia media) {
              print("Selected media:${media.id}");
            },
          ),
        )
      ]),
    ));
  }
```

## GiphyTheme

The GIPHY SDK offers three pre-defined themes presets:

- automatic
- dark
- light

#### Example

```dart
// Configure API keys
...
GiphyFlutterSDK.configure(apiKey: '*************');
...

// Adjust GiphyDialog theme
GiphySettings _settings = const GiphySettings();
GiphyDialog.instance
        .configure(settings: _settings.copyWith(theme: GiphyTheme.dark()));


// Adjust GiphyGridView theme
GiphyGridView(
  content: GiphyContentRequest.trendingStickers(),
  theme: GiphyTheme.dark()
)

```

To achieve more extensive customization, you can extend any preset and override specific settings according to your
requirements. The theme schemas can be found at the following links:

- [iOS Theme Schema](./assets/ios-theme-scheme.pdf)
- [Android Theme Schema](./assets/android-theme-scheme.pdf)

#### Example

```dart
final GiphyTheme _theme = GiphyTheme.fromPreset(
  preset: GiphyThemePreset.dark,
  backgroundColor: const Color(0xFF373d48),
  defaultTextColor: const Color(0xFFB0BEC5));

// Configure API keys
...
GiphyFlutterSDK.configure(apiKey: '*************');
...

// Adjust GiphyDialog theme
GiphySettings _settings = const GiphySettings();
GiphyDialog.instance
  .configure(settings: _settings.copyWith(theme: _theme));


// Adjust GiphyGridView theme
GiphyGridView(
  content: GiphyContentRequest.trendingStickers(),
  theme: _theme
)
```

#### Theme Options

| Option                            | Type                                                 | Platform                        |
|-----------------------------------|------------------------------------------------------|---------------------------------|
| avatarPlaceholderColor            | `Color`                                   | ❌&nbsp;Android <br/> ✅&nbsp;iOS |
| backgroundColor                   | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| backgroundColorForLoadingCells    | `Color`                                   | ❌&nbsp;Android <br/> ✅&nbsp;iOS |
| cellCornerRadius                  | `double`                                             | ❌&nbsp;Android <br/> ✅&nbsp;iOS |
| confirmationBackButtonColor       | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| confirmationSelectButtonColor     | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| confirmationSelectButtonTextColor | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| confirmationViewOnGiphyColor      | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| defaultTextColor                  | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| dialogOverlayBackgroundColor      | `Color`                                   | ✅&nbsp;Android <br/> ❌&nbsp;iOS |
| emojiDrawerGradientBottomColor    | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| emojiDrawerGradientTopColor       | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| emojiDrawerScrollIndicatorStyle   | [`IndicatorStyle`](../lib/dto/misc.dart#L3)               | ❌&nbsp;Android <br/> ✅&nbsp;iOS |
| emojiDrawerSeparatorColor         | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| fixedSizeCells                    | `bool`                                            | ❌&nbsp;Android <br/> ✅&nbsp;iOS |
| handleBarColor                    | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| keyboardAppearance                | [`GiphyKeyboardAppearance`](../lib/dto/misc.dart)           | ❌&nbsp;Android <br/> ✅&nbsp;iOS |
| preset                            | [`GiphyThemePreset`](../lib/dto/giphy_theme.dart#L5) | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| retryButtonBackgroundColor        | `Color`                                   | ✅&nbsp;Android <br/> ❌&nbsp;iOS |
| retryButtonTextColor              | `Color`                                   | ✅&nbsp;Android <br/> ❌&nbsp;iOS |
| searchBackButtonColor             | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| searchBarBackgroundColor          | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| searchBarCornerRadius             | `double`                                             | ❌&nbsp;Android <br/> ✅&nbsp;iOS |
| searchBarPadding                  | `double`                                             | ❌&nbsp;Android <br/> ✅&nbsp;iOS |
| searchPlaceholderTextColor        | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| searchTextColor                   | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| showSuggestionsBar                | `bool`                                            | ❌&nbsp;Android <br/> ✅&nbsp;iOS |
| stickerBackgroundColor            | `Color`                                   | ❌&nbsp;Android <br/> ✅&nbsp;iOS |
| suggestionCellBackgroundColor     | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| suggestionCellTextColor           | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| tabBarBackgroundAlpha             | `number`                                             | ❌&nbsp;Android <br/> ✅&nbsp;iOS |
| tabBarSwitchDefaultColor          | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| tabBarSwitchSelectedColor         | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
| usernameColor                     | `Color`                                   | ✅&nbsp;Android <br/> ✅&nbsp;iOS |
