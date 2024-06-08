import 'giphy_assets.dart';
import 'giphy_video_captions.dart';
import 'giphy_video_previews.dart';

/// A class representing a Giphy video
class GiphyVideo {

  /// The URL for the HLS manifest.
  final String? hlsManifestURL;

  /// The URL for the DASH manifest.
  final String? dashManifestURL;

  /// The assets related to the Giphy video.
  final GiphyAssets? assets;

  /// The preview versions of the Giphy video.
  final GiphyVideoPreviews? previews;

  /// The captions for the Giphy video.
  final GiphyVideoCaptions? captions;

  /// The duration of the Giphy video in seconds.
  final double? duration;

  /// Creates a new [GiphyVideo] instance.
  ///
  /// The [hlsManifestURL], [dashManifestURL], [assets], [previews], [captions],
  /// and [duration] parameters are optional and can be null.
  const GiphyVideo({
    this.hlsManifestURL,
    this.dashManifestURL,
    this.assets,
    this.previews,
    this.captions,
    this.duration,
  });

  /// Factory constructor to create a new [GiphyVideo] instance from a JSON map.
  ///
  /// The [json] parameter must not be null.
  factory GiphyVideo.fromJson(Map<Object?, Object?> json) {
    return GiphyVideo(
      hlsManifestURL: json['hlsManifestURL'] as String?,
      dashManifestURL: json['dashManifestURL'] as String?,
      assets: json['assets'] != null ? GiphyAssets.fromJson(json['assets'] as Map<Object?, Object?>) : null,
      previews: json['previews'] != null ? GiphyVideoPreviews.fromJson(json['previews'] as Map<Object?, Object?>) : null,
      captions: json['captions'] != null ? GiphyVideoCaptions.fromJson(json['captions'] as Map<Object?, Object?>) : null,
      duration: json['duration'] != null ? (json['duration'] as num).toDouble() : null,
    );
  }

  /// Converts this [GiphyVideo] instance to a JSON map.
  ///
  /// Returns a JSON map representation of this instance.
  Map<String, dynamic> toJson() {
    return {
      'hlsManifestURL': hlsManifestURL,
      'dashManifestURL': dashManifestURL,
      'assets': assets?.toJson(),
      'previews': previews?.toJson(),
      'captions': captions?.toJson(),
      'duration': duration,
    };
  }
}
