import 'package:giphy_flutter_sdk/dto/giphy_content_type.dart';
import 'package:giphy_flutter_sdk/dto/giphy_file_format.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rating.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rendition.dart';

import 'giphy_theme.dart';

class GiphySettings {
  final GiphyTheme theme;
  final List<GiphyContentType> mediaTypeConfig;
  final bool showConfirmationScreen;
  final GiphyRating rating;
  final GiphyRendition? renditionType;
  final GiphyClipsRendition? clipsPreviewRenditionType;
  final GiphyRendition? confirmationRenditionType;
  final bool showCheckeredBackground;
  final int stickerColumnCount;
  final GiphyContentType selectedContentType;
  final bool showSuggestionsBar;
  final bool enableDynamicText;
  final GiphyFileFormat fileFormat;
  final bool disableEmojiVariations;

  const GiphySettings({
    this.theme = GiphyTheme.automaticTheme,
    this.mediaTypeConfig = const [
      GiphyContentType.recents,
      GiphyContentType.gif,
      GiphyContentType.sticker,
      GiphyContentType.text,
      GiphyContentType.emoji,
      GiphyContentType.clips
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

  bool isContentTypeEnabled(GiphyContentType contentType) {
    return mediaTypeConfig.contains(contentType);
  }

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
      showConfirmationScreen: showConfirmationScreen ?? this.showConfirmationScreen,
      rating: rating ?? this.rating,
      renditionType: renditionType ?? this.renditionType,
      clipsPreviewRenditionType: clipsPreviewRenditionType ?? this.clipsPreviewRenditionType,
      confirmationRenditionType: confirmationRenditionType ?? this.confirmationRenditionType,
      showCheckeredBackground: showCheckeredBackground ?? this.showCheckeredBackground,
      stickerColumnCount: stickerColumnCount ?? this.stickerColumnCount,
      selectedContentType: selectedContentType ?? this.selectedContentType,
      showSuggestionsBar: showSuggestionsBar ?? this.showSuggestionsBar,
      enableDynamicText: enableDynamicText ?? this.enableDynamicText,
      fileFormat: fileFormat ?? this.fileFormat,
      disableEmojiVariations: disableEmojiVariations ?? this.disableEmojiVariations,
    );
  }
}
