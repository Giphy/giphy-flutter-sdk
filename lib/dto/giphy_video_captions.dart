import 'giphy_video_caption.dart';

class GiphyVideoCaptions {
  final GiphyVideoCaption? videoCaption;

  GiphyVideoCaptions({this.videoCaption});

  factory GiphyVideoCaptions.fromJson(Map<Object?, Object?> json) {
    return GiphyVideoCaptions(
      videoCaption: json['en'] != null
          ? GiphyVideoCaption.fromJson(json['en'] as Map<Object?, Object?>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'en': videoCaption?.toJson(),
    };
  }
}
