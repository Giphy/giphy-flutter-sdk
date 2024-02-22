import 'giphy_image.dart';
import 'giphy_rendition.dart';

class GiphyImages {
  final GiphyImage? fixedHeight;
  final GiphyImage? fixedHeightStill;
  final GiphyImage? fixedHeightDownsampled;
  final GiphyImage? fixedWidth;
  final GiphyImage? fixedWidthStill;
  final GiphyImage? fixedWidthDownsampled;
  final GiphyImage? fixedHeightSmall;
  final GiphyImage? fixedHeightSmallStill;
  final GiphyImage? fixedWidthSmall;
  final GiphyImage? fixedWidthSmallStill;
  final GiphyImage? downsized;
  final GiphyImage? downsizedStill;
  final GiphyImage? downsizedLarge;
  final GiphyImage? downsizedMedium;
  final GiphyImage? original;
  final GiphyImage? originalStill;
  final GiphyImage? looping;
  final GiphyImage? preview;
  final GiphyImage? downsizedSmall;
  final String? mediaId;

  GiphyImages({
    this.fixedHeight,
    this.fixedHeightStill,
    this.fixedHeightDownsampled,
    this.fixedWidth,
    this.fixedWidthStill,
    this.fixedWidthDownsampled,
    this.fixedHeightSmall,
    this.fixedHeightSmallStill,
    this.fixedWidthSmall,
    this.fixedWidthSmallStill,
    this.downsized,
    this.downsizedStill,
    this.downsizedLarge,
    this.downsizedMedium,
    this.original,
    this.originalStill,
    this.looping,
    this.preview,
    this.downsizedSmall,
    this.mediaId,
  });

  factory GiphyImages.fromJson(Map<Object?, Object?> json) {
    return GiphyImages(
      fixedHeight: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.fixedHeight)]
                  as Map<Object?, Object?>? ??
              {}),
      fixedHeightStill: GiphyImage.fromJson(json[
              GiphyRenditionUtil.toStringValue(
                  GiphyRendition.fixedHeightStill)] as Map<Object?, Object?>? ??
          {}),
      fixedHeightDownsampled: GiphyImage.fromJson(json[
                  GiphyRenditionUtil.toStringValue(
                      GiphyRendition.fixedHeightDownsampled)]
              as Map<Object?, Object?>? ??
          {}),
      fixedWidth: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.fixedWidth)]
                  as Map<Object?, Object?>? ??
              {}),
      fixedWidthStill: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.fixedWidthStill)]
                  as Map<Object?, Object?>? ??
              {}),
      fixedWidthDownsampled: GiphyImage.fromJson(json[
                  GiphyRenditionUtil.toStringValue(
                      GiphyRendition.fixedWidthDownsampled)]
              as Map<Object?, Object?>? ??
          {}),
      fixedHeightSmall: GiphyImage.fromJson(json[
              GiphyRenditionUtil.toStringValue(
                  GiphyRendition.fixedHeightSmall)] as Map<Object?, Object?>? ??
          {}),
      fixedHeightSmallStill: GiphyImage.fromJson(json[
                  GiphyRenditionUtil.toStringValue(
                      GiphyRendition.fixedHeightSmallStill)]
              as Map<Object?, Object?>? ??
          {}),
      fixedWidthSmall: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.fixedWidthSmall)]
                  as Map<Object?, Object?>? ??
              {}),
      fixedWidthSmallStill: GiphyImage.fromJson(json[
                  GiphyRenditionUtil.toStringValue(
                      GiphyRendition.fixedWidthSmallStill)]
              as Map<Object?, Object?>? ??
          {}),
      downsized: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.downsized)]
                  as Map<Object?, Object?>? ??
              {}),
      downsizedStill: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.downsizedStill)]
                  as Map<Object?, Object?>? ??
              {}),
      downsizedLarge: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.downsizedLarge)]
                  as Map<Object?, Object?>? ??
              {}),
      downsizedMedium: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.downsizedMedium)]
                  as Map<Object?, Object?>? ??
              {}),
      original: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.original)]
                  as Map<Object?, Object?>? ??
              {}),
      originalStill: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.originalStill)]
                  as Map<Object?, Object?>? ??
              {}),
      looping: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.looping)]
                  as Map<Object?, Object?>? ??
              {}),
      preview: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.preview)]
                  as Map<Object?, Object?>? ??
              {}),
      downsizedSmall: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.downsizedSmall)]
                  as Map<Object?, Object?>? ??
              {}),
      mediaId: json['mediaId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      GiphyRenditionUtil.toStringValue(GiphyRendition.fixedHeight):
          fixedHeight?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.fixedHeightStill):
          fixedHeightStill?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.fixedHeightDownsampled):
          fixedHeightDownsampled?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.fixedWidth):
          fixedWidth?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.fixedWidthStill):
          fixedWidthStill?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.fixedWidthDownsampled):
          fixedWidthDownsampled?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.fixedHeightSmall):
          fixedHeightSmall?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.fixedHeightSmallStill):
          fixedHeightSmallStill?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.fixedWidthSmall):
          fixedWidthSmall?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.fixedWidthSmallStill):
          fixedWidthSmallStill?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.downsized):
          downsized?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.downsizedStill):
          downsizedStill?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.downsizedLarge):
          downsizedLarge?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.downsizedMedium):
          downsizedMedium?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.original):
          original?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.originalStill):
          originalStill?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.looping):
          looping?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.preview):
          preview?.toJson(),
      GiphyRenditionUtil.toStringValue(GiphyRendition.downsizedSmall):
          downsizedSmall?.toJson(),
      'mediaId': mediaId,
    };
  }
}
