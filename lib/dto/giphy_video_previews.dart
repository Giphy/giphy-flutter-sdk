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
      fixedWidth: GiphyVideoPreviewAsset.fromJson(json['fixed_width']),
      fixedHeight: GiphyVideoPreviewAsset.fromJson(json['fixed_height']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fixed_width': fixedWidth.toJson(),
      'fixed_height': fixedHeight.toJson(),
    };
  }
}
