import 'package:giphy_flutter_sdk/dto/giphy_content_type.dart';
import 'package:giphy_flutter_sdk/dto/giphy_file_extension.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rating.dart';
import 'package:giphy_flutter_sdk/dto/giphy_rendition.dart';

import 'giphy_theme.dart';

class GiphySettings {
  GiphyTheme theme;
  List<GiphyContentType> mediaTypeConfig;
  bool showConfirmationScreen;
  GiphyRating rating;
  GiphyRendition? renditionType;
  GiphyClipsRendition? clipsPreviewRenditionType;
  GiphyRendition? confirmationRenditionType;
  bool showCheckeredBackground;
  int stickerColumnCount;
  GiphyContentType selectedContentType;
  bool showSuggestionsBar;
  bool enableDynamicText;
  GiphyFileFormat fileFormat;
  bool disableEmojiVariations;

  GiphySettings({
    GiphyTheme? theme,
    List<GiphyContentType>? mediaTypeConfig,
    bool? showConfirmationScreen,
    GiphyRating? rating,
    this.renditionType,
    this.clipsPreviewRenditionType,
    this.confirmationRenditionType,
    bool? showCheckeredBackground,
    int? stickerColumnCount,
    GiphyContentType? selectedContentType,
    bool? showSuggestionsBar,
    bool? enableDynamicText,
    GiphyFileFormat? fileFormat,
    bool? disableEmojiVariations,
  })  : theme =
            theme ?? GiphyTheme.fromPreset(preset: GiphyThemePreset.automatic),
        mediaTypeConfig = mediaTypeConfig ??
            const [
              GiphyContentType.recents,
              GiphyContentType.gif,
              GiphyContentType.sticker,
              GiphyContentType.text,
              GiphyContentType.emoji,
              GiphyContentType.clips,
            ],
        showConfirmationScreen = showConfirmationScreen ?? false,
        rating = rating ?? GiphyRating.pg13,
        showCheckeredBackground = showCheckeredBackground ?? false,
        stickerColumnCount = stickerColumnCount ?? 2,
        selectedContentType = selectedContentType ?? GiphyContentType.gif,
        showSuggestionsBar = showSuggestionsBar ?? true,
        enableDynamicText = enableDynamicText ?? false,
        fileFormat = fileFormat ?? GiphyFileFormat.webp,
        disableEmojiVariations = disableEmojiVariations ?? false;

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
      'fileFormat': GGiphyFileFormatExtension.toStringValue(fileFormat),
      'disableEmojiVariations': disableEmojiVariations,
    };
  }
}
