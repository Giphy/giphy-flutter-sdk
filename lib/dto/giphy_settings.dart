import 'package:giphy_flutter_sdk/dto/giphy_content_type.dart';
import 'package:giphy_flutter_sdk/dto/giphy_file_format.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rating.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rendition.dart';

import 'giphy_theme.dart';

/// A configuration class for Giphy settings.
class GiphySettings {

  /// The theme to use for the Giphy UI.
  final GiphyTheme theme;

  /// Type(s) of content to be displayed in the dialog.
  final List<GiphyContentType> mediaTypeConfig;

  /// Show a secondary confirmation screen when the user taps a GIF, which shows a larger rendition of the asset.
  final bool showConfirmationScreen;

  /// A specific content rating for the search results.
  final GiphyRating rating;

  /// A rendition type for the grid.
  final GiphyRendition? renditionType;

  /// The specific rendition type to use for clip previews.
  final GiphyClipsRendition? clipsPreviewRenditionType;

  /// A rendition type for the confirmation screen.
  final GiphyRendition? confirmationRenditionType;

  /// Enable/disable the checkered background for stickers and text media type.
  final bool showCheckeredBackground;

  /// For carousel layouts, we provide the option to set the number of columns for stickers and text. We recommend using 3 columns for blurred mode.
  final int stickerColumnCount;

  /// The default Giphy Content-Type.
  final GiphyContentType selectedContentType;

  /// If true, shows the suggestions bar.
  final bool showSuggestionsBar;

  /// If true, allows to create animated text results for search queries where there are no matching results in GIPHY's library.
  final bool enableDynamicText;

  /// A file format for the grid.
  final GiphyFileFormat fileFormat;

  /// If true, disables variations of emojis.
  final bool disableEmojiVariations;

  /// Constructs an instance of [GiphySettings] with the given settings.
  const GiphySettings({
    this.theme = GiphyTheme.automaticTheme,
    this.mediaTypeConfig = const [
      GiphyContentType.recents,
      GiphyContentType.gif,
      GiphyContentType.sticker,
      GiphyContentType.text,
      GiphyContentType.emoji,
      GiphyContentType.clips,
    ],
    this.showConfirmationScreen = false,
    this.rating = GiphyRating.pg13,
    this.renditionType,
    this.clipsPreviewRenditionType,
    this.confirmationRenditionType,
    this.showCheckeredBackground = false,
    this.stickerColumnCount = 3,
    this.selectedContentType = GiphyContentType.gif,
    this.showSuggestionsBar = true,
    this.enableDynamicText = false,
    this.fileFormat = GiphyFileFormat.webp,
    this.disableEmojiVariations = false,
  });

  /// Converts this settings object into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'theme': theme.toJson(),
      'mediaTypeConfig': mediaTypeConfig
          .map((e) => GiphyContentTypeExtension.toStringValue(e))
          .toList(),
      'showConfirmationScreen': showConfirmationScreen,
      'rating': GiphyRatingExtension.toStringValue(rating),
      'renditionType': renditionType != null
          ? GiphyRenditionUtil.toStringValue(renditionType)
          : null,
      'clipsPreviewRenditionType': clipsPreviewRenditionType != null
          ? GiphyRenditionUtil.toStringValue(clipsPreviewRenditionType)
          : null,
      'confirmationRenditionType': confirmationRenditionType != null
          ? GiphyRenditionUtil.toStringValue(confirmationRenditionType)
          : null,
      'showCheckeredBackground': showCheckeredBackground,
      'stickerColumnCount': stickerColumnCount,
      'selectedContentType':
          GiphyContentTypeExtension.toStringValue(selectedContentType),
      'showSuggestionsBar': showSuggestionsBar,
      'enableDynamicText': enableDynamicText,
      'fileFormat': GiphyFileFormatExtension.toStringValue(fileFormat),
      'disableEmojiVariations': disableEmojiVariations,
    };
  }

  /// Checks if a specific content type is enabled in the configuration.
  ///
  /// [contentType]: The [GiphyContentType] to be checked.
  /// Returns `true` if the content type is enabled, otherwise `false`.
  bool isContentTypeEnabled(GiphyContentType contentType) {
    return mediaTypeConfig.contains(contentType);
  }

  /// Creates a copy of this settings object with the given overrides.
  ///
  /// The following fields can be overridden:
  ///
  /// [theme], [mediaTypeConfig], [showConfirmationScreen], [rating], [renditionType],
  /// [clipsPreviewRenditionType], [confirmationRenditionType], [showCheckeredBackground],
  /// [stickerColumnCount], [selectedContentType], [showSuggestionsBar], [enableDynamicText],
  /// [fileFormat], [disableEmojiVariations].
  ///
  /// Returns a new instance of [GiphySettings].
  GiphySettings copyWith({
    GiphyTheme? theme,
    List<GiphyContentType>? mediaTypeConfig,
    bool? showConfirmationScreen,
    GiphyRating? rating,
    GiphyRendition? renditionType,
    GiphyClipsRendition? clipsPreviewRenditionType,
    GiphyRendition? confirmationRenditionType,
    bool? showCheckeredBackground,
    int? stickerColumnCount,
    GiphyContentType? selectedContentType,
    bool? showSuggestionsBar,
    bool? enableDynamicText,
    GiphyFileFormat? fileFormat,
    bool? disableEmojiVariations,
  }) {
    return GiphySettings(
      theme: theme ?? this.theme,
      mediaTypeConfig: mediaTypeConfig ?? this.mediaTypeConfig,
      showConfirmationScreen:
      showConfirmationScreen ?? this.showConfirmationScreen,
      rating: rating ?? this.rating,
      renditionType: renditionType ?? this.renditionType,
      clipsPreviewRenditionType:
      clipsPreviewRenditionType ?? this.clipsPreviewRenditionType,
      confirmationRenditionType:
      confirmationRenditionType ?? this.confirmationRenditionType,
      showCheckeredBackground:
      showCheckeredBackground ?? this.showCheckeredBackground,
      stickerColumnCount: stickerColumnCount ?? this.stickerColumnCount,
      selectedContentType:
      selectedContentType ?? this.selectedContentType,
      showSuggestionsBar: showSuggestionsBar ?? this.showSuggestionsBar,
      enableDynamicText: enableDynamicText ?? this.enableDynamicText,
      fileFormat: fileFormat ?? this.fileFormat,
      disableEmojiVariations:
      disableEmojiVariations ?? this.disableEmojiVariations,
    );
  }
}
