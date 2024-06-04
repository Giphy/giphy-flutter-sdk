import 'package:giphy_flutter_sdk/dto/giphy_rendition.dart';

/// A class representing a Giphy image with various attributes and formats.
class GiphyImage {
  /// The URL of the GIF version of the image.
  final String? gifUrl;

  /// The width of the image.
  final int width;

  /// The height of the image.
  final int height;

  /// The size of the GIF in bytes.
  final int gifSize;

  /// The number of frames in the GIF.
  final int frames;

  /// The URL of the MP4 version of the image.
  final String? mp4Url;

  /// The size of the MP4 in bytes.
  final int mp4Size;

  /// The URL of the WebP version of the image.
  final String? webPUrl;

  /// The size of the WebP in bytes.
  final int webPSize;

  /// The media ID of the image.
  final String? mediaId;

  /// The rendition type of the image.
  final GiphyRendition? renditionType;

  /// Creates a [GiphyImage] instance with the given attributes.
  const GiphyImage({
    this.gifUrl,
    this.width = 0,
    this.height = 0,
    this.gifSize = 0,
    this.frames = 0,
    this.mp4Url,
    this.mp4Size = 0,
    this.webPUrl,
    this.webPSize = 0,
    this.mediaId,
    this.renditionType,
  });

  /// Creates a [GiphyImage] instance from a JSON object.
  ///
  /// [json] A map containing key-value pairs corresponding to the image attributes.
  ///
  /// Returns a [GiphyImage] instance populated with the values from the JSON object.
  factory GiphyImage.fromJson(Map<Object?, Object?> json) {
    return GiphyImage(
      gifUrl: json['gifUrl'] as String?,
      width: json['width'] as int? ?? 0,
      height: json['height'] as int? ?? 0,
      gifSize: json['gifSize'] as int? ?? 0,
      frames: json['frames'] as int? ?? 0,
      mp4Url: json['mp4Url'] as String?,
      mp4Size: json['mp4Size'] as int? ?? 0,
      webPUrl: json['webPUrl'] as String?,
      webPSize: json['webPSize'] as int? ?? 0,
      mediaId: json['mediaId'] as String?,
      renditionType: json['renditionType'] != null ? GiphyRenditionUtil.fromStringValue(json['renditionType'] as String) as GiphyRendition? : null,
    );
  }

  /// Converts the [GiphyImage] instance to a JSON object.
  ///
  /// Returns a map containing key-value pairs corresponding to the image attributes.
  Map<String, dynamic> toJson() {
    return {
      'gifUrl': gifUrl,
      'width': width,
      'height': height,
      'gifSize': gifSize,
      'frames': frames,
      'mp4Url': mp4Url,
      'mp4Size': mp4Size,
      'webPUrl': webPUrl,
      'webPSize': webPSize,
      'mediaId': mediaId,
      'renditionType': GiphyRenditionUtil.toStringValue(renditionType),
    };
  }
}
