import 'giphy_video_caption.dart';

/// A class representing video captions in a Giphy response.
class GiphyVideoCaptions {
  /// The video caption.
  final GiphyVideoCaption? videoCaption;

  /// Creates a [GiphyVideoCaptions] object.
  const GiphyVideoCaptions({this.videoCaption});

  /// Creates a [GiphyVideoCaptions] object from a JSON map.
  factory GiphyVideoCaptions.fromJson(Map<Object?, Object?> json) {
    return GiphyVideoCaptions(
      videoCaption: json['en'] != null
          ? GiphyVideoCaption.fromJson(json['en'] as Map<Object?, Object?>)
          : null,
    );
  }

  /// Converts this [GiphyVideoCaptions] object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'en': videoCaption?.toJson(),
    };
  }
}