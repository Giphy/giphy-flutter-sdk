/// An enumeration for different Giphy rating types.
enum GiphyRating {
  /// General audience.
  g,

  /// Parental guidance.
  pg,

  /// Parents strongly cautioned.
  pg13,

  /// Restricted.
  r,

  /// Not yet rated.
  unrated,

  /// Suitable for young audience.
  y,

  /// Explicit content, not safe for work.
  nsfw,
}

/// Extension methods for [GiphyRating] to convert from and to string values.
extension GiphyRatingExtension on GiphyRating {

  /// Converts a string value to a corresponding [GiphyRating] enum value.
  ///
  /// Throws an [ArgumentError] if the given string does not match any [GiphyRating] values.
  ///
  /// [value] The string representation of the Giphy rating.
  ///
  /// Returns the matching [GiphyRating] value.
  static GiphyRating fromStringValue(String value) {
    switch (value) {
      case 'r':
        return GiphyRating.r;
      case 'y':
        return GiphyRating.y;
      case 'g':
        return GiphyRating.g;
      case 'pg':
        return GiphyRating.pg;
      case 'pg13':
        return GiphyRating.pg13;
      case 'unrated':
        return GiphyRating.unrated;
      case 'nsfw':
        return GiphyRating.nsfw;
      default:
        throw ArgumentError('Invalid rating type: $value');
    }
  }

  /// Converts a GiphyRating enum value to its corresponding string representation.
  ///
  /// Example:
  /// ```dart
  /// String value = GiphyRatingExtension.toStringValue(GiphyRating.pg13);
  /// ```
  static String toStringValue(GiphyRating rating) {
    return rating.toString().split('.').last;
  }
}
