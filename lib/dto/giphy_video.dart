import 'giphy_assets.dart';
import 'giphy_video_captions.dart';
import 'giphy_video_previews.dart';

class GiphyVideo {
  final String? hlsManifestURL;
  final String? dashManifestURL;
  final GiphyAssets? assets;
  final GiphyVideoPreviews? previews;
  final GiphyVideoCaptions? captions;
  final double? duration;

  GiphyVideo({
    this.hlsManifestURL,
    this.dashManifestURL,
    this.assets,
    this.previews,
    this.captions,
    this.duration,
  });

  factory GiphyVideo.fromJson(Map<String, dynamic> json) {
    return GiphyVideo(
      hlsManifestURL: json['hlsManifestURL'] as String?,
      dashManifestURL: json['dashManifestURL'] as String?,
      assets:
          json['assets'] != null ? GiphyAssets.fromJson(json['assets']) : null,
      previews: json['previews'] != null
          ? GiphyVideoPreviews.fromJson(json['previews'])
          : null,
      captions: json['captions'] != null
          ? GiphyVideoCaptions.fromJson(json['captions'])
          : null,
      duration: json['duration']?.toDouble(),
    );
  }

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
