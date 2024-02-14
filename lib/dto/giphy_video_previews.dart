import 'giphy_video_preview_asset.dart';

class GiphyVideoPreviews {
  final GiphyVideoPreviewAsset fixedWidth;
  final GiphyVideoPreviewAsset fixedHeight;

  GiphyVideoPreviews({
    required this.fixedWidth,
    required this.fixedHeight,
  });

  factory GiphyVideoPreviews.fromJson(Map<String, dynamic> json) {
    return GiphyVideoPreviews(
      fixedWidth: GiphyVideoPreviewAsset.fromJson(json['fixedWidth']),
      fixedHeight: GiphyVideoPreviewAsset.fromJson(json['fixedHeight']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fixedWidth': fixedWidth.toJson(),
      'fixedHeight': fixedHeight.toJson(),
    };
  }
}
