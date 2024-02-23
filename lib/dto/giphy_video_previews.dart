import 'giphy_video_preview_asset.dart';

class GiphyVideoPreviews {
  final GiphyVideoPreviewAsset fixedWidth;
  final GiphyVideoPreviewAsset fixedHeight;

  GiphyVideoPreviews({
    required this.fixedWidth,
    required this.fixedHeight,
  });

  factory GiphyVideoPreviews.fromJson(Map<Object?, Object?> json) {
    return GiphyVideoPreviews(
      fixedWidth: GiphyVideoPreviewAsset.fromJson(json['fixedWidth'] as Map<Object?, Object?>),
      fixedHeight: GiphyVideoPreviewAsset.fromJson(json['fixedHeight'] as Map<Object?, Object?>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fixedWidth': fixedWidth.toJson(),
      'fixedHeight': fixedHeight.toJson(),
    };
  }
}
