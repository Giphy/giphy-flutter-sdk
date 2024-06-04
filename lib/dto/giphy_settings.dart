import 'package:giphy_flutter_sdk/dto/giphy_content_type.dart';
import 'package:giphy_flutter_sdk/dto/giphy_file_format.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rating.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rendition.dart';

import 'giphy_theme.dart';

/// A configuration class for Giphy settings.
class GiphySettings {

  /// The theme to use for the Giphy UI.
  final GiphyTheme theme;

  /// The list of content types to be included.
  final List<GiphyContentType> mediaTypeConfig;

  /// Determines if a confirmation screen should be shown after selecting an item.
  final bool showConfirmationScreen;

  /// The rating filter for the content.
  final GiphyRating rating;

  /// The specific rendition type to use for displaying GIFs.
  final GiphyRendition? renditionType;

  /// The specific rendition type to use for clip previews.
  final GiphyClipsRendition? clipsPreviewRenditionType;

  /// The specific rendition type to use on the confirmation screen.
  final GiphyRendition? confirmationRenditionType;

  /// Determines if a checkered background should be shown behind transparent stickers.
  final bool showCheckeredBackground;

  /// The number of columns to use for displaying stickers.
  final int stickerColumnCount;

  /// The default selected content type.
  final GiphyContentType selectedContentType;

  /// If true, shows the suggestions bar.
  final bool showSuggestionsBar;

  /// If true, enables dynamic texts feature.
  final bool enableDynamicText;

  /// The file format to be used for the content.
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
