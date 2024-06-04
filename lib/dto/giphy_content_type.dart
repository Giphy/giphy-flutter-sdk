/// An enumeration representing different types of Giphy content.
enum GiphyContentType {
  recents,
  gif,
  sticker,
  emoji,
  text,
  clips,
}

/// Extension methods for [GiphyContentType] to convert from and to string values.
extension GiphyContentTypeExtension on GiphyContentType {

  /// Converts a string value to a corresponding [GiphyContentType] enum value.
  ///
  /// Throws an [ArgumentError] if the given string does not match any [GiphyContentType] values.
  ///
  /// [value] The string representation of the Giphy content type.
  ///
  /// Returns the matching [GiphyContentType] value.
  static GiphyContentType fromStringValue(String value) {
    switch (value) {
      case 'emoji':
        return GiphyContentType.emoji;
      case 'gif':
        return GiphyContentType.gif;
      case 'recents':
        return GiphyContentType.recents;
      case 'sticker':
        return GiphyContentType.sticker;
      case 'text':
        return GiphyContentType.text;
      case 'clips':
        return GiphyContentType.clips;
      default:
        throw ArgumentError('Unknown GiphyContentType value: $value');
    }
  }

  /// Converts a [GiphyContentType] enum value to its string representation.
  ///
  /// [type] The [GiphyContentType] value to be converted.
  ///
  /// Returns the string representation of the given [GiphyContentType] value.
  static String toStringValue(GiphyContentType type) {
    return type.toString().split('.').last;
  }
}
