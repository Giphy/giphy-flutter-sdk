import 'giphy_asset.dart';

class GiphyAssets {
  final GiphyAsset? source;
  final GiphyAsset? size360p;
  final GiphyAsset? size480p;
  final GiphyAsset? size720p;
  final GiphyAsset? size1080p;
  final GiphyAsset? size4k;

  GiphyAssets({
    this.source,
    this.size360p,
    this.size480p,
    this.size720p,
    this.size1080p,
    this.size4k,
  });

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
