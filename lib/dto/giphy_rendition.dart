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
    return rendition.toString().split('.').last;
  }

  static String _clipsToStringValue(GiphyClipsRendition rendition) {
    return rendition.toString().split('.').last;
  }
}
