enum GiphyKeyboardAppearance { defaultAppearance, dark, light }

enum GiphyIndicatorStyle { defaultStyle, dark, light }

enum GiphyStickersColumnCount { two, three, four }

enum GiphyDirection { horizontal, vertical }

enum GiphyResizeMode { center, contain, cover, stretch }

extension GiphyKeyboardAppearanceExtension on GiphyKeyboardAppearance {
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

  static String toStringValue(GiphyKeyboardAppearance type) {
    return type.toString().split('.').last;
  }
}

extension GiphyIndicatorStyleExtension on GiphyIndicatorStyle {
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

  static String toStringValue(GiphyIndicatorStyle type) {
    return type.toString().split('.').last;
  }
}

extension GiphyStickersColumnCountExtension on GiphyStickersColumnCount {
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

  static String toStringValue(GiphyStickersColumnCount type) {
    return type.toString().split('.').last;
  }
}

extension GiphyDirectionExtension on GiphyDirection {
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

  static String toStringValue(GiphyDirection type) {
    return type.toString().split('.').last;
  }
}

extension GiphyResizeModeExtension on GiphyResizeMode {
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

  static String toStringValue(GiphyResizeMode type) {
    return type.toString().split('.').last;
  }
}
