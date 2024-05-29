enum GiphyContentType {
  recents,
  gif,
  sticker,
  emoji,
  text,
  clips,
}

extension GiphyContentTypeExtension on GiphyContentType {
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

  static String toStringValue(GiphyContentType type) {
    return type.toString().split('.').last;
  }
}
