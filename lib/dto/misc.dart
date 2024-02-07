enum KeyboardAppearance { defaultAppearance, dark, light }

enum IndicatorStyle { defaultStyle, dark, light }

enum GiphyStickersColumnCount { two, three, four }

enum GiphyDirection { horizontal, vertical }

enum ResizeMode { center, contain, cover, stretch }

extension KeyboardAppearanceExtension on KeyboardAppearance {
  static KeyboardAppearance fromStringValue(String value) {
    switch (value) {
      case 'defaultAppearance':
        return KeyboardAppearance.defaultAppearance;
      case 'dark':
        return KeyboardAppearance.dark;
      case 'light':
        return KeyboardAppearance.light;
      default:
        throw ArgumentError('Unknown KeyboardAppearance value: $value');
    }
  }

  static String toStringValue(KeyboardAppearance type) {
    return type.toString().split('.').last;
  }
}

extension IndicatorStyleExtension on IndicatorStyle {
  static IndicatorStyle fromStringValue(String value) {
    switch (value) {
      case 'defaultStyle':
        return IndicatorStyle.defaultStyle;
      case 'dark':
        return IndicatorStyle.dark;
      case 'light':
        return IndicatorStyle.light;
      default:
        throw ArgumentError('Unknown IndicatorStyle value: $value');
    }
  }

  static String toStringValue(IndicatorStyle type) {
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

extension ResizeModeExtension on ResizeMode {
  static ResizeMode fromStringValue(String value) {
    switch (value) {
      case 'center':
        return ResizeMode.center;
      case 'contain':
        return ResizeMode.contain;
      case 'cover':
        return ResizeMode.cover;
      case 'stretch':
        return ResizeMode.stretch;
      default:
        throw ArgumentError('Unknown ResizeMode value: $value');
    }
  }

  static String toStringValue(ResizeMode type) {
    return type.toString().split('.').last;
  }
}
