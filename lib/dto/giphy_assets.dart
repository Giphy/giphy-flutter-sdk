import 'giphy_asset.dart';

/// A class that represents various Giphy assets in different resolutions.
class GiphyAssets {
  /// The original source asset.
  final GiphyAsset? source;

  /// The asset with a resolution of 360p.
  final GiphyAsset? size360p;

  /// The asset with a resolution of 480p.
  final GiphyAsset? size480p;

  /// The asset with a resolution of 720p.
  final GiphyAsset? size720p;

  /// The asset with a resolution of 1080p.
  final GiphyAsset? size1080p;

  /// The asset with a resolution of 4k.
  final GiphyAsset? size4k;

  /// Creates a [GiphyAssets] instance with the given assets for different resolutions.
  const GiphyAssets({
    this.source,
    this.size360p,
    this.size480p,
    this.size720p,
    this.size1080p,
    this.size4k,
  });

  /// Creates a [GiphyAssets] instance from a JSON object.
  ///
  /// The [json] parameter must not be null and should contain valid key-value pairs
  /// corresponding to the different resolutions.
  factory GiphyAssets.fromJson(Map<Object?, Object?> json) {
    return GiphyAssets(
      source: json['source'] != null
          ? GiphyAsset.fromJson(json['source'] as Map<Object?, Object?>)
          : null,
      size360p: json['360p'] != null
          ? GiphyAsset.fromJson(json['360p'] as Map<Object?, Object?>)
          : null,
      size480p: json['480p'] != null
          ? GiphyAsset.fromJson(json['480p'] as Map<Object?, Object?>)
          : null,
      size720p: json['720p'] != null
          ? GiphyAsset.fromJson(json['720p'] as Map<Object?, Object?>)
          : null,
      size1080p: json['1080p'] != null
          ? GiphyAsset.fromJson(json['1080p'] as Map<Object?, Object?>)
          : null,
      size4k: json['4k'] != null
          ? GiphyAsset.fromJson(json['4k'] as Map<Object?, Object?>)
          : null,
    );
  }

  /// Converts the [GiphyAssets] instance to a JSON object.
  ///
  /// Returns a [Map<String, dynamic>] containing key-value pairs for each resolution.
  Map<String, dynamic> toJson() {
    return {
      'source': source?.toJson(),
      '360p': size360p?.toJson(),
      '480p': size480p?.toJson(),
      '720p': size720p?.toJson(),
      '1080p': size1080p?.toJson(),
      '4k': size4k?.toJson(),
    };
  }
}
