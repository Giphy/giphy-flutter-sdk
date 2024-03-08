enum GiphyFileFormat {
  gif,
  mp4,
  webp,
}

extension GiphyFileFormatExtension on GiphyFileFormat {
  static GiphyFileFormat fromStringValue(String value) {
    switch (value) {
      case 'gif':
        return GiphyFileFormat.gif;
      case 'mp4':
        return GiphyFileFormat.mp4;
      case 'webp':
        return GiphyFileFormat.webp;
      default:
        throw ArgumentError('Unknown GiphyFileExtension value: $value');
    }
  }

  static String toStringValue(GiphyFileFormat type) {
    return type.toString().split('.').last;
  }
}
