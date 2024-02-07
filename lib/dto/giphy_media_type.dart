enum GiphyMediaType {
  gif,
  sticker,
  text,
  emoji,
  video,
}

extension GiphyMediaTypeExtension on GiphyMediaType {
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

  static String toStringValue(GiphyMediaType type) {
    return type.toString().split('.').last;
  }
}
