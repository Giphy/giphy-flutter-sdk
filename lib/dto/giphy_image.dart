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

  factory GiphyImage.fromJson(Map<String, dynamic> json) {
    return GiphyImage(
      gifUrl: json['url'],
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      gifSize: json['size'] ?? 0,
      frames: json['frames'] ?? 0,
      mp4Url: json['mp4'],
      mp4Size: json['mp4Size'] ?? 0,
      webPUrl: json['webp'],
      webPSize: json['webPSize'] ?? 0,
      mediaId: json['mediaId'],
      renditionType: GiphyRenditionUtil.fromStringValue(json['renditionType'])
          as GiphyRendition?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': gifUrl,
      'width': width,
      'height': height,
      'size': gifSize,
      'frames': frames,
      'mp4': mp4Url,
      'mp4Size': mp4Size,
      'webp': webPUrl,
      'webPSize': webPSize,
      'mediaId': mediaId,
      'renditionType': GiphyRenditionUtil.toStringValue(renditionType),
    };
  }
}
