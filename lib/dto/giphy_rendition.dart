/// An enumeration representing a Giphy Rendition Type (e.g., original/preview/...)
enum GiphyRendition {

  /// Original file size and file dimensions. Good for desktop use.
  original,

  /// Preview image for original.
  originalStill,

  /// File size under 50kb. Duration may be truncated to meet file size requirements. Good for thumbnails and previews.
  preview,

  /// Duration set to loop for 15 seconds. Only recommended for this exact use case.
  looping,

  /// Height set to 200px. Good for mobile use.
  fixedHeight,

  /// Static preview image for fixed_height
  fixedHeightStill,

  /// Height set to 200px. Reduced to 6 frames to minimize file size to the lowest.
  /// Works well for unlimited scroll on mobile and as animated previews. See Giphy.com on mobile web as an example.
  fixedHeightDownsampled,

  /// Height set to 100px. Good for mobile keyboards.
  fixedHeightSmall,

  /// Static preview image for fixed_height_small
  fixedHeightSmallStill,

  /// Width set to 200px. Good for mobile use.
  fixedWidth,

  /// Static preview image for fixed_width
  fixedWidthStill,

  /// Width set to 200px. Reduced to 6 frames. Works well for unlimited scroll on mobile and as animated previews.
  fixedWidthDownsampled,

  /// Width set to 100px. Good for mobile keyboards.
  fixedWidthSmall,

  /// Static preview image for fixed_width_small
  fixedWidthSmallStill,

  /// File size under 2mb.
  downsized,

  /// File size under 200kb.
  downsizedSmall,

  /// File size under 5mb.
  downsizedMedium,

  /// File size under 8mb.
  downsizedLarge,

  /// Static preview image for downsized.
  downsizedStill,
}

/// Certain renditions (cases of the GiphyRendition enum) are not available for Clips.
/// To account for this limitation, we created this property specifically to work with Clips.
enum GiphyClipsRendition {

  /// Original file size and file dimensions. Good for desktop use.
  original,

  /// Preview image for original.
  originalStill,

  /// Height set to 200px. Good for mobile use.
  fixedHeight,

  /// Static preview image for fixed_height
  fixedHeightStill,

  /// Height set to 200px. Reduced to 6 frames to minimize file size to the lowest.
  /// Works well for unlimited scroll on mobile and as animated previews. See Giphy.com on mobile web as an example.
  fixedHeightDownsampled,

  /// Width set to 200px. Good for mobile use.
  fixedWidth,

  /// Static preview image for fixed_width
  fixedWidthStill,

  /// Width set to 200px. Reduced to 6 frames. Works well for unlimited scroll on mobile and as animated previews.
  fixedWidthDownsampled,

  /// File size under 5mb.
  downsizedMedium,

  /// File size under 8mb.
  downsizedLarge,
}

/// Utility class for handling conversion between string values and
/// GiphyRendition/GiphyClipsRendition objects.
class GiphyRenditionUtil {
  /// Converts a string value to a GiphyRendition or GiphyClipsRendition object.
  ///
  /// The [value] parameter is the string representation of the rendition.
  /// If [isClip] is true, the conversion is done to a GiphyClipsRendition,
  /// otherwise to a GiphyRendition.
  ///
  /// Throws an [ArgumentError] if the string value is not recognized.
  static dynamic fromStringValue(String value, {bool isClip = false}) {
    if (isClip) {
      return _fromStringClipsValue(value);
    } else {
      return _fromStringValue(value);
    }
  }

  /// Converts a GiphyRendition or GiphyClipsRendition object to its string representation.
  ///
  /// The [rendition] parameter is the rendition object to be converted (either GiphyRendition or GiphyClipsRendition).
  ///
  /// Throws an [ArgumentError] if the rendition type is not supported.
  static String toStringValue(dynamic rendition) {
    if (rendition is GiphyRendition) {
      return _toStringValue(rendition);
    } else if (rendition is GiphyClipsRendition) {
      return _clipsToStringValue(rendition);
    } else {
      throw ArgumentError('Unsupported rendition type');
    }
  }

  /// Converts a string value to a GiphyRendition object.
  ///
  /// The [value] parameter is the string representation of the GiphyRendition.
  ///
  /// Throws an [ArgumentError] if the string value is not recognized.
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

  /// Converts a string value to a GiphyClipsRendition object.
  ///
  /// The [value] parameter is the string representation of the GiphyClipsRendition.
  ///
  /// Throws an [ArgumentError] if the string value is not recognized.
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

  /// Converts a GiphyRendition object to its string representation.
  ///
  /// The [rendition] parameter is the GiphyRendition object to be converted.
  static String _toStringValue(GiphyRendition rendition) {
    return rendition.toString().split('.').last;
  }

  /// Converts a GiphyClipsRendition object to its string representation.
  ///
  /// The [rendition] parameter is the GiphyClipsRendition object to be converted.
  static String _clipsToStringValue(GiphyClipsRendition rendition) {
    return rendition.toString().split('.').last;
  }
}
