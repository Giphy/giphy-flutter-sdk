/// An enumeration representing different file formats for Giphy content.
enum GiphyFileFormat {
  gif,
  mp4,
  webp,
}

/// Extension methods for [GiphyFileFormat] to convert from and to string values.
extension GiphyFileFormatExtension on GiphyFileFormat {

  /// Converts a string value to a corresponding [GiphyFileFormat] enum value.
  ///
  /// Throws an [ArgumentError] if the given string does not match any [GiphyFileFormat] values.
  ///
  /// [value] The string representation of the Giphy file format.
  ///
  /// Returns the matching [GiphyFileFormat] value.
  static GiphyFileFormat fromStringValue(String value) {
    switch (value) {
      case 'gif':
        return GiphyFileFormat.gif;
      case 'mp4':
        return GiphyFileFormat.mp4;
      case 'webp':
        return GiphyFileFormat.webp;
      default:
        throw ArgumentError('Unknown GiphyFileFormat value: $value');
    }
  }

  /// Converts a [GiphyFileFormat] enum value to its string representation.
  ///
  /// [type] The [GiphyFileFormat] value to be converted.
  ///
  /// Returns the string representation of the given [GiphyFileFormat] value.
  static String toStringValue(GiphyFileFormat type) {
    return type.toString().split('.').last;
  }
}
