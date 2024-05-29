## GIPHY Animated Text Creation

<img alt="" src="./assets/new-feature.gif">

### Dynamic Text Feature

This service _creates_ animated text results for search queries where there are no matching results in GIPHY's library.
These results are returned in a number of different animation styles giving your users a variety of options to best
express themselves.

### Enabling Dynamic Text in the GiphyDialog

<img alt="" src="./assets/sdk-dynamic-text.png" >

```dart
GiphyDialog.instance.configure(
  settings: const GiphySettings(
  mediaTypeConfig: [GiphyContentType.gif, GiphyContentType.text],
  enableDynamicText: true));
```

### Enabling Dynamic Text in the GiphyGridView

You can easily fill the [GiphyGridView](./api.md#giphygridview) with dynamic text by passing the result of
the [GiphyContentRequestType.animate](./api.md#-animate-options-giphycontentanimateoptions--giphycontentrequest) call to the `
content` property of the GiphyGridView component.

### Example

```dart
Expanded(
  child: GiphyGridView(
    content: const GiphyContentRequest(
      mediaType: GiphyMediaType.gif,
      requestType: GiphyContentRequestType.animate,
      searchQuery: "Hello!"),
      onMediaSelect: (GiphyMedia media) {},
  ),
)
```

When populating the [GiphyGridView](./api.md#giphygridview) with dynamic text, provide a visual indicator to clarify to
the user that they are
in a _creation_ context as opposed to a _search_ context.

### GiphyMedia and Dynamic Text

The new `isDynamic` property of `GiphyMedia` signifies animated text assets that are _dynamically_ generated based on
user
input and are not indexed in the GIPHY Library.

⚠️ Due to the nature of dynamic media, the `id` property does not represent a normal GIPHY `id`, which makes it
incompatible with the [GiphyMediaView](./api.md#giphymediaview). This is because
the [GiphyMediaView](./api.md#giphymediaview) component relies on
the `id` property
internally. However, you can quickly solve this problem by using the standard React Native Image component instead:

```dart
child: AspectRatio(
  aspectRatio: media.aspectRatio,
  child: media.isDynamic
    ? Image(
        image: NetworkImage(
          media.images.original!.gifUrl!))
    : GiphyMediaView(
        media: media,
        autoPlay: true,
        renditionType: GiphyRendition.fixedWidth,
      ),
),
```

### Renditions

We will only return GIF & WebP files for dynamic text. These are renditions
available: `original`, `fixed_width`, `fixed_width_downsampled`, `fixed_width_small`, `preview_gif`, `preview_webp`.

