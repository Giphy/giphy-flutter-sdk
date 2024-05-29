class GiphyAsset {
  final int width;
  final int height;
  final String? url;
  final String? format;

  const GiphyAsset({
    this.width = 0,
    this.height = 0,
    this.url,
    this.format,
  });

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

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'url': url,
      'format': format,
    };
  }
}
