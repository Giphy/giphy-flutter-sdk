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
      case 'originalStill':
        return GiphyRendition.originalStill;
      case 'preview':
        return GiphyRendition.preview;
      case 'looping':
        return GiphyRendition.looping;
      case 'fixedHeight':
        return GiphyRendition.fixedHeight;
      case 'fixedHeightStill':
        return GiphyRendition.fixedHeightStill;
      case 'fixedHeightDownsampled':
        return GiphyRendition.fixedHeightDownsampled;
      case 'fixedHeightSmall':
        return GiphyRendition.fixedHeightSmall;
      case 'fixedHeightSmallStill':
        return GiphyRendition.fixedHeightSmallStill;
      case 'fixedWidth':
        return GiphyRendition.fixedWidth;
      case 'fixedWidthStill':
        return GiphyRendition.fixedWidthStill;
      case 'fixedWidthDownsampled':
        return GiphyRendition.fixedWidthDownsampled;
      case 'fixedWidthSmall':
        return GiphyRendition.fixedWidthSmall;
      case 'fixedWidthSmallStill':
        return GiphyRendition.fixedWidthSmallStill;
      case 'downsized':
        return GiphyRendition.downsized;
      case 'downsizedSmall':
        return GiphyRendition.downsizedSmall;
      case 'downsizedMedium':
        return GiphyRendition.downsizedMedium;
      case 'downsizedLarge':
        return GiphyRendition.downsizedLarge;
      case 'downsizedStill':
        return GiphyRendition.downsizedStill;
      default:
        throw ArgumentError('Unknown GiphyRendition value: $value');
    }
  }

  static GiphyClipsRendition _fromStringClipsValue(String value) {
    switch (value) {
      case 'original':
        return GiphyClipsRendition.original;
      case 'originalStill':
        return GiphyClipsRendition.originalStill;
      case 'fixedHeight':
        return GiphyClipsRendition.fixedHeight;
      case 'fixedHeightStill':
        return GiphyClipsRendition.fixedHeightStill;
      case 'fixedHeightDownsampled':
        return GiphyClipsRendition.fixedHeightDownsampled;
      case 'fixedWidth':
        return GiphyClipsRendition.fixedWidth;
      case 'fixedWidthStill':
        return GiphyClipsRendition.fixedWidthStill;
      case 'fixedWidthDownsampled':
        return GiphyClipsRendition.fixedWidthDownsampled;
      case 'downsizedMedium':
        return GiphyClipsRendition.downsizedMedium;
      case 'downsizedLarge':
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
        return 'originalStill';
      case GiphyRendition.preview:
        return 'preview';
      case GiphyRendition.looping:
        return 'looping';
      case GiphyRendition.fixedHeight:
        return 'fixedHeight';
      case GiphyRendition.fixedHeightStill:
        return 'fixedHeightStill';
      case GiphyRendition.fixedHeightDownsampled:
        return 'fixedHeightDownsampled';
      case GiphyRendition.fixedHeightSmall:
        return 'fixedHeightSmall';
      case GiphyRendition.fixedHeightSmallStill:
        return 'fixedHeightSmallStill';
      case GiphyRendition.fixedWidth:
        return 'fixedWidth';
      case GiphyRendition.fixedWidthStill:
        return 'fixedWidthStill';
      case GiphyRendition.fixedWidthDownsampled:
        return 'fixedWidthDownsampled';
      case GiphyRendition.fixedWidthSmall:
        return 'fixedWidthSmall';
      case GiphyRendition.fixedWidthSmallStill:
        return 'fixedWidthSmallStill';
      case GiphyRendition.downsized:
        return 'downsized';
      case GiphyRendition.downsizedSmall:
        return 'downsizedSmall';
      case GiphyRendition.downsizedMedium:
        return 'downsizedMedium';
      case GiphyRendition.downsizedLarge:
        return 'downsizedLarge';
      case GiphyRendition.downsizedStill:
        return 'downsizedStill';
      default:
        throw ArgumentError('Unknown GiphyRendition value: $rendition');
    }
  }

  static String _clipsToStringValue(GiphyClipsRendition rendition) {
    switch (rendition) {
      case GiphyClipsRendition.original:
        return 'original';
      case GiphyClipsRendition.originalStill:
        return 'originalStill';
      case GiphyClipsRendition.fixedHeight:
        return 'fixedHeight';
      case GiphyClipsRendition.fixedHeightStill:
        return 'fixedHeightStill';
      case GiphyClipsRendition.fixedHeightDownsampled:
        return 'fixedHeightDownsampled';
      case GiphyClipsRendition.fixedWidth:
        return 'fixedWidth';
      case GiphyClipsRendition.fixedWidthStill:
        return 'fixedWidthStill';
      case GiphyClipsRendition.fixedWidthDownsampled:
        return 'fixedWidthDownsampled';
      case GiphyClipsRendition.downsizedMedium:
        return 'downsizedMedium';
      case GiphyClipsRendition.downsizedLarge:
        return 'downsizedLarge';
      default:
        throw ArgumentError('Unknown GiphyRendition value: $rendition');
    }
  }
}
