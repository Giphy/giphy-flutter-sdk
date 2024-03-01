import 'package:giphy_flutter_sdk/dto/giphy_content_type.dart';
import 'package:giphy_flutter_sdk/dto/giphy_file_extension.dart';
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
      GiphyContentType.clips,
    ],
    this.showConfirmationScreen = false,
    this.rating = GiphyRating.pg13,
    this.renditionType,
    this.clipsPreviewRenditionType,
    this.confirmationRenditionType,
    this.showCheckeredBackground = false,
    this.stickerColumnCount = 2,
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
      'fileFormat': GGiphyFileFormatExtension.toStringValue(fileFormat),
      'disableEmojiVariations': disableEmojiVariations,
    };
  }
}
