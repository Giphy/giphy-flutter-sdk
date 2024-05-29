class GiphyVideoPreviewAsset {
  final int width;
  final int height;
  final String? url;

  const GiphyVideoPreviewAsset({
    this.width = 0,
    this.height = 0,
    this.url,
  });

  factory GiphyVideoPreviewAsset.fromJson(Map<Object?, Object?> json) {
    return GiphyVideoPreviewAsset(
      width: json['width'] as int? ?? 0,
      height: json['height'] as int? ?? 0,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'url': url,
    };
  }
}
