enum GiphyRendition {
  original,
  originalStill,
  preview,
  looping,
  fixedHeight,
  fixedHeightStill,
  fixedHeightDownsampled,
  fixedHeightSmall,
  fixedHeightSmallStill,
  fixedWidth,
  fixedWidthStill,
  fixedWidthDownsampled,
  fixedWidthSmall,
  fixedWidthSmallStill,
  downsized,
  downsizedSmall,
  downsizedMedium,
  downsizedLarge,
  downsizedStill,
}

enum GiphyClipsRendition {
  original,
  originalStill,
  fixedHeight,
  fixedHeightStill,
  fixedHeightDownsampled,
  fixedWidth,
  fixedWidthStill,
  fixedWidthDownsampled,
  downsizedMedium,
  downsizedLarge,
}

class GiphyRenditionUtil {
  static dynamic fromStringValue(String value, {bool isClip = false}) {
    if (isClip) {
      return _fromStringClipsValue(value);
    } else {
      return _fromStringValue(value);
    }
  }

  static String toStringValue(dynamic rendition) {
    if (rendition is GiphyRendition) {
      return _toStringValue(rendition);
    } else if (rendition is GiphyClipsRendition) {
      return _clipsToStringValue(rendition);
    } else {
      throw ArgumentError('Unsupported rendition type');
    }
  }

  static GiphyRendition _fromStringValue(String value) {
    switch (value) {
      case 'original':
        return GiphyRendition.original;
      case 'original_still':
        return GiphyRendition.originalStill;
      case 'preview':
        return GiphyRendition.preview;
      case 'looping':
        return GiphyRendition.looping;
      case 'fixed_height':
        return GiphyRendition.fixedHeight;
      case 'fixed_height_still':
        return GiphyRendition.fixedHeightStill;
      case 'fixed_height_downsampled':
        return GiphyRendition.fixedHeightDownsampled;
      case 'fixed_height_small':
        return GiphyRendition.fixedHeightSmall;
      case 'fixed_height_small_still':
        return GiphyRendition.fixedHeightSmallStill;
      case 'fixed_width':
        return GiphyRendition.fixedWidth;
      case 'fixed_width_still':
        return GiphyRendition.fixedWidthStill;
      case 'fixed_width_downsampled':
        return GiphyRendition.fixedWidthDownsampled;
      case 'fixed_width_small':
        return GiphyRendition.fixedWidthSmall;
      case 'fixed_width_small_still':
        return GiphyRendition.fixedWidthSmallStill;
      case 'downsized':
        return GiphyRendition.downsized;
      case 'downsized_small':
        return GiphyRendition.downsizedSmall;
      case 'downsized_medium':
        return GiphyRendition.downsizedMedium;
      case 'downsized_large':
        return GiphyRendition.downsizedLarge;
      case 'downsized_still':
        return GiphyRendition.downsizedStill;
      default:
        throw ArgumentError('Unknown GiphyRendition value: $value');
    }
  }

  static GiphyClipsRendition _fromStringClipsValue(String value) {
    switch (value) {
      case 'original':
        return GiphyClipsRendition.original;
      case 'original_still':
        return GiphyClipsRendition.originalStill;
      case 'fixed_height':
        return GiphyClipsRendition.fixedHeight;
      case 'fixed_height_still':
        return GiphyClipsRendition.fixedHeightStill;
      case 'fixed_height_downsampled':
        return GiphyClipsRendition.fixedHeightDownsampled;
      case 'fixed_width':
        return GiphyClipsRendition.fixedWidth;
      case 'fixed_width_still':
        return GiphyClipsRendition.fixedWidthStill;
      case 'fixed_width_downsampled':
        return GiphyClipsRendition.fixedWidthDownsampled;
      case 'downsized_medium':
        return GiphyClipsRendition.downsizedMedium;
      case 'downsized_large':
        return GiphyClipsRendition.downsizedLarge;
      default:
        throw ArgumentError('Unknown GiphyClipsRendition value: $value');
    }
  }

  static String _toStringValue(GiphyRendition rendition) {
    switch (rendition) {
      case GiphyRendition.original:
        return 'original';
      case GiphyRendition.originalStill:
        return 'original_still';
      case GiphyRendition.preview:
        return 'preview';
      case GiphyRendition.looping:
        return 'looping';
      case GiphyRendition.fixedHeight:
        return 'fixed_height';
      case GiphyRendition.fixedHeightStill:
        return 'fixed_height_still';
      case GiphyRendition.fixedHeightDownsampled:
        return 'fixed_height_downsampled';
      case GiphyRendition.fixedHeightSmall:
        return 'fixed_height_small';
      case GiphyRendition.fixedHeightSmallStill:
        return 'fixed_height_small_still';
      case GiphyRendition.fixedWidth:
        return 'fixed_width';
      case GiphyRendition.fixedWidthStill:
        return 'fixed_width_still';
      case GiphyRendition.fixedWidthDownsampled:
        return 'fixed_width_downsampled';
      case GiphyRendition.fixedWidthSmall:
        return 'fixed_width_small';
      case GiphyRendition.fixedWidthSmallStill:
        return 'fixed_width_small_still';
      case GiphyRendition.downsized:
        return 'downsized';
      case GiphyRendition.downsizedSmall:
        return 'downsized_small';
      case GiphyRendition.downsizedMedium:
        return 'downsized_medium';
      case GiphyRendition.downsizedLarge:
        return 'downsized_large';
      case GiphyRendition.downsizedStill:
        return 'downsized_still';
      default:
        throw ArgumentError('Unknown GiphyRendition value: $rendition');
    }
  }

  static String _clipsToStringValue(GiphyClipsRendition rendition) {
    switch (rendition) {
      case GiphyClipsRendition.original:
        return 'original';
      case GiphyClipsRendition.originalStill:
        return 'original_still';
      case GiphyClipsRendition.fixedHeight:
        return 'fixed_height';
      case GiphyClipsRendition.fixedHeightStill:
        return 'fixed_height_still';
      case GiphyClipsRendition.fixedHeightDownsampled:
        return 'fixed_height_downsampled';
      case GiphyClipsRendition.fixedWidth:
        return 'fixed_width';
      case GiphyClipsRendition.fixedWidthStill:
        return 'fixed_width_still';
      case GiphyClipsRendition.fixedWidthDownsampled:
        return 'fixed_width_downsampled';
      case GiphyClipsRendition.downsizedMedium:
        return 'downsized_medium';
      case GiphyClipsRendition.downsizedLarge:
        return 'downsized_large';
      default:
        throw ArgumentError('Unknown GiphyRendition value: $rendition');
    }
  }
}
