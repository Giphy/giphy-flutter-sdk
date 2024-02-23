import 'package:giphy_flutter_sdk/dto/giphy_rendition.dart';

class GiphyImage {
  String? gifUrl;
  int width;
  int height;
  int gifSize;
  int frames;
  String? mp4Url;
  int mp4Size;
  String? webPUrl;
  int webPSize;
  String? mediaId;
  GiphyRendition? renditionType;

  GiphyImage({
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
