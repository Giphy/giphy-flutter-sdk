/// An enum representing different types of media available on Giphy.
enum GiphyMediaType {
  /// Represents an animated GIF.
  gif,

  /// Represents a sticker.
  sticker,

  /// Represents textual content.
  text,

  /// Represents an emoji.
  emoji,

  /// Represents a clip.
  video,
}

/// Extension methods for [GiphyMediaType] to convert from and to string values.
extension GiphyMediaTypeExtension on GiphyMediaType {

  /// Converts a string value to a corresponding [GiphyMediaType].
  /// 
  /// Throws an [ArgumentError] if the given string does not match any of the [GiphyMediaType] values.
  ///
  /// [value] The string representation of the Giphy media type.
  ///
  /// Returns the matching [GiphyMediaType] value.
  static GiphyMediaType fromStringValue(String value) {
    switch (value) {
      case 'gif':
        return GiphyMediaType.gif;
      case 'sticker':
        return GiphyMediaType.sticker;
      case 'text':
        return GiphyMediaType.text;
      case 'emoji':
        return GiphyMediaType.emoji;
      case 'video':
        return GiphyMediaType.video;
      default:
        throw ArgumentError('Unknown MediaType value: $value');
    }
  }

  ///  Converts a [GiphyMediaType] enum value to its string representation.
  ///
  /// [type] The [GiphyMediaType] value to be converted.
  ///
  /// Returns the string representation of the given [GiphyMediaType] value.
  static String toStringValue(GiphyMediaType type) {
    return type.toString().split('.').last;
  }
}
