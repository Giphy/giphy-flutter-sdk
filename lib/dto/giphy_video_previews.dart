import 'giphy_video_preview_asset.dart';

/// A class representing the different preview assets of a Giphy video.
class GiphyVideoPreviews {
  /// The preview asset with a fixed width.
  final GiphyVideoPreviewAsset fixedWidth;

  /// The preview asset with a fixed height.
  final GiphyVideoPreviewAsset fixedHeight;

  /// Creates a [GiphyVideoPreviews] object.
  ///
  /// The [fixedWidth] and [fixedHeight] parameters are required.
  const GiphyVideoPreviews({
    required this.fixedWidth,
    required this.fixedHeight,
  });

  /// Creates a [GiphyVideoPreviews] object from a JSON map.
  ///
  /// The JSON map should have keys 'fixedWidth' and 'fixedHeight', each containing
  /// the preview asset as a nested JSON object.
  factory GiphyVideoPreviews.fromJson(Map<Object?, Object?> json) {
    return GiphyVideoPreviews(
      fixedWidth: GiphyVideoPreviewAsset.fromJson(json['fixedWidth'] as Map<Object?, Object?>),
      fixedHeight: GiphyVideoPreviewAsset.fromJson(json['fixedHeight'] as Map<Object?, Object?>),
    );
  }

  /// Converts this [GiphyVideoPreviews] object to a JSON map.
  ///
  /// The resulting JSON map will contain keys 'fixedWidth' and 'fixedHeight' with
  /// their respective preview asset data.
  Map<String, dynamic> toJson() {
    return {
      'fixedWidth': fixedWidth.toJson(),
      'fixedHeight': fixedHeight.toJson(),
    };
  }
}
