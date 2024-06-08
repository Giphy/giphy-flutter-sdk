/// A representation of a Giphy video asset, including its dimensions, URL, and format.
class GiphyAsset {
  /// The width of the asset.
  final int width;

  /// The height of the asset.
  final int height;

  // The URL for the asset.
  final String? url;

  /// The format of the asset.
  final String? format;

  /// Creates a [GiphyAsset] with the given properties.
  ///
  /// Defaults [width] and [height] to 0 if not provided.
  const GiphyAsset({
    this.width = 0,
    this.height = 0,
    this.url,
    this.format,
  });

  /// Creates a [GiphyAsset] instance from a JSON map.
  ///
  /// Parses the 'width' and 'height' fields, defaulting to 0 if they are missing or invalid.
  factory GiphyAsset.fromJson(Map<Object?, Object?> json) {
    return GiphyAsset(
      width: (json['width'] is String)
          ? int.tryParse(json['width'] as String? ?? "0") ?? 0
          : (json['width'] as int?) ?? 0,
      height: (json['height'] is String)
          ? int.tryParse(json['height'] as String? ?? "0") ?? 0
          : (json['height'] as int?) ?? 0,
      url: json['url'] as String?,
      format: json['format'] as String?,
    );
  }

  /// Converts the [GiphyAsset] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'url': url,
      'format': format,
    };
  }
}
