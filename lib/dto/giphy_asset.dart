class GiphyAsset {
  final int width;
  final int height;
  final String? url;
  final String? format;

  GiphyAsset({
    this.width = 0,
    this.height = 0,
    this.url,
    this.format,
  });

  factory GiphyAsset.fromJson(Map<String, dynamic> json) {
    return GiphyAsset(
      width: json['width'] as int? ?? 0,
      height: json['height'] as int? ?? 0,
      url: json['url'] as String?,
      format: json['format'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'url': url,
      'format': format,
    };
  }
}
