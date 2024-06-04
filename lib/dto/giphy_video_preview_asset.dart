/// A class representing the preview asset of a Giphy video.
class GiphyVideoPreviewAsset {
  /// The width of the video preview asset.
  final int width;

  /// The height of the video preview asset.
  final int height;

  /// The URL of the video preview asset.
  final String? url;

  /// Creates a [GiphyVideoPreviewAsset] object.
  ///
  /// The [width] and [height] default to 0 if not provided.
  const GiphyVideoPreviewAsset({
    this.width = 0,
    this.height = 0,
    this.url,
  });

  /// Creates a [GiphyVideoPreviewAsset] object from a JSON map.
  ///
  /// The JSON map should have keys 'width', 'height', and 'url'.
  factory GiphyVideoPreviewAsset.fromJson(Map<Object?, Object?> json) {
    return GiphyVideoPreviewAsset(
      width: json['width'] as int? ?? 0,
      height: json['height'] as int? ?? 0,
      url: json['url'] as String?,
    );
  }

  /// Converts this [GiphyVideoPreviewAsset] object to a JSON map.
  ///
  /// The resulting JSON map will contain keys 'width', 'height', and 'url'.
  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'url': url,
    };
  }
}

