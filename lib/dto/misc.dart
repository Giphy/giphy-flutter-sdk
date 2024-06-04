/// An enumeration representing different keyboard appearances for Giphy.
enum GiphyKeyboardAppearance { defaultAppearance, dark, light }

/// An enumeration representing different indicator styles for Giphy.
enum GiphyIndicatorStyle { defaultStyle, dark, light }

/// An enumeration representing different column counts for Giphy stickers.
enum GiphyStickersColumnCount { two, three, four }

/// An enumeration representing different directions for Giphy content.
enum GiphyDirection { horizontal, vertical }

/// An enumeration representing different resize modes for Giphy content.
enum GiphyResizeMode { center, contain, cover, stretch }

/// Extension methods for [GiphyKeyboardAppearance] to convert between string values and enum values.
extension GiphyKeyboardAppearanceExtension on GiphyKeyboardAppearance {
  /// Converts a string value to a corresponding [GiphyKeyboardAppearance] enum value.
  ///
  /// Throws an [ArgumentError] if the given string does not match any [GiphyKeyboardAppearance] values.
  ///
  /// [value] The string representation of the keyboard appearance.
  ///
  /// Returns the matching [GiphyKeyboardAppearance] value.
  static GiphyKeyboardAppearance fromStringValue(String value) {
    switch (value) {
      case 'defaultAppearance':
        return GiphyKeyboardAppearance.defaultAppearance;
      case 'dark':
        return GiphyKeyboardAppearance.dark;
      case 'light':
        return GiphyKeyboardAppearance.light;
      default:
        throw ArgumentError('Unknown KeyboardAppearance value: $value');
    }
  }

  /// Converts a [GiphyKeyboardAppearance] enum value to its string representation.
  ///
  /// [type] The [GiphyKeyboardAppearance] value to be converted.
  ///
  /// Returns the string representation of the given [GiphyKeyboardAppearance] value.
  static String toStringValue(GiphyKeyboardAppearance type) {
    return type.toString().split('.').last;
  }
}

/// Extension methods for [GiphyIndicatorStyle] to convert between string values and enum values.
extension GiphyIndicatorStyleExtension on GiphyIndicatorStyle {
  /// Converts a string value to a corresponding [GiphyIndicatorStyle] enum value.
  ///
  /// Throws an [ArgumentError] if the given string does not match any [GiphyIndicatorStyle] values.
  ///
  /// [value] The string representation of the indicator style.
  ///
  /// Returns the matching [GiphyIndicatorStyle] value.
  static GiphyIndicatorStyle fromStringValue(String value) {
    switch (value) {
      case 'defaultStyle':
        return GiphyIndicatorStyle.defaultStyle;
      case 'dark':
        return GiphyIndicatorStyle.dark;
      case 'light':
        return GiphyIndicatorStyle.light;
      default:
        throw ArgumentError('Unknown IndicatorStyle value: $value');
    }
  }

  /// Converts a [GiphyIndicatorStyle] enum value to its string representation.
  ///
  /// [type] The [GiphyIndicatorStyle] value to be converted.
  ///
  /// Returns the string representation of the given [GiphyIndicatorStyle] value.
  static String toStringValue(GiphyIndicatorStyle type) {
    return type.toString().split('.').last;
  }
}

/// Extension methods for [GiphyStickersColumnCount] to convert between string values and enum values.
extension GiphyStickersColumnCountExtension on GiphyStickersColumnCount {
  /// Converts a string value to a corresponding [GiphyStickersColumnCount] enum value.
  ///
  /// Throws an [ArgumentError] if the given string does not match any [GiphyStickersColumnCount] values.
  ///
  /// [value] The string representation of the stickers column count.
  ///
  /// Returns the matching [GiphyStickersColumnCount] value.
  static GiphyStickersColumnCount fromStringValue(String value) {
    switch (value) {
      case 'two':
        return GiphyStickersColumnCount.two;
      case 'three':
        return GiphyStickersColumnCount.three;
      case 'four':
        return GiphyStickersColumnCount.four;
      default:
        throw ArgumentError('Unknown GiphyStickersColumnCount value: $value');
    }
  }

  /// Converts a [GiphyStickersColumnCount] enum value to its string representation.
  ///
  /// [type] The [GiphyStickersColumnCount] value to be converted.
  ///
  /// Returns the string representation of the given [GiphyStickersColumnCount] value.
  static String toStringValue(GiphyStickersColumnCount type) {
    return type.toString().split('.').last;
  }
}

/// Extension methods for [GiphyDirection] to convert between string values and enum values.
extension GiphyDirectionExtension on GiphyDirection {
  /// Converts a string value to a corresponding [GiphyDirection] enum value.
  ///
  /// Throws an [ArgumentError] if the given string does not match any [GiphyDirection] values.
  ///
  /// [value] The string representation of the direction.
  ///
  /// Returns the matching [GiphyDirection] value.
  static GiphyDirection fromStringValue(String value) {
    switch (value) {
      case 'horizontal':
        return GiphyDirection.horizontal;
      case 'vertical':
        return GiphyDirection.vertical;
      default:
        throw ArgumentError('Unknown GiphyDirection value: $value');
    }
  }

  /// Converts a [GiphyDirection] enum value to its string representation.
  ///
  /// [type] The [GiphyDirection] value to be converted.
  ///
  /// Returns the string representation of the given [GiphyDirection] value.
  static String toStringValue(GiphyDirection type) {
    return type.toString().split('.').last;
  }
}

/// Extension methods for [GiphyResizeMode] to convert between string values and enum values.
extension GiphyResizeModeExtension on GiphyResizeMode {
  /// Converts a string value to a corresponding [GiphyResizeMode] enum value.
  ///
  /// Throws an [ArgumentError] if the given string does not match any [GiphyResizeMode] values.
  ///
  /// [value] The string representation of the resize mode.
  ///
  /// Returns the matching [GiphyResizeMode] value.
  static GiphyResizeMode fromStringValue(String value) {
    switch (value) {
      case 'center':
        return GiphyResizeMode.center;
      case 'contain':
        return GiphyResizeMode.contain;
      case 'cover':
        return GiphyResizeMode.cover;
      case 'stretch':
        return GiphyResizeMode.stretch;
      default:
        throw ArgumentError('Unknown ResizeMode value: $value');
    }
  }

  /// Converts a [GiphyResizeMode] enum value to its string representation.
  ///
  /// [type] The [GiphyResizeMode] value to be converted.
  ///
  /// Returns the string representation of the given [GiphyResizeMode] value.
  static String toStringValue(GiphyResizeMode type) {
    return type.toString().split('.').last;
  }
}
