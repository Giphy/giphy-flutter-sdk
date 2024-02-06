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

  factory GiphyImages.fromJson(Map<String, dynamic> json) {
    return GiphyImages(
      fixedHeight: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.fixedHeight)]),
      fixedHeightStill: GiphyImage.fromJson(json[
          GiphyRenditionUtil.toStringValue(GiphyRendition.fixedHeightStill)]),
      fixedHeightDownsampled: GiphyImage.fromJson(json[
          GiphyRenditionUtil.toStringValue(
              GiphyRendition.fixedHeightDownsampled)]),
      fixedWidth: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.fixedWidth)]),
      fixedWidthStill: GiphyImage.fromJson(json[
          GiphyRenditionUtil.toStringValue(GiphyRendition.fixedWidthStill)]),
      fixedWidthDownsampled: GiphyImage.fromJson(json[
          GiphyRenditionUtil.toStringValue(
              GiphyRendition.fixedWidthDownsampled)]),
      fixedHeightSmall: GiphyImage.fromJson(json[
          GiphyRenditionUtil.toStringValue(GiphyRendition.fixedHeightSmall)]),
      fixedHeightSmallStill: GiphyImage.fromJson(json[
          GiphyRenditionUtil.toStringValue(
              GiphyRendition.fixedHeightSmallStill)]),
      fixedWidthSmall: GiphyImage.fromJson(json[
          GiphyRenditionUtil.toStringValue(GiphyRendition.fixedWidthSmall)]),
      fixedWidthSmallStill: GiphyImage.fromJson(json[
          GiphyRenditionUtil.toStringValue(
              GiphyRendition.fixedWidthSmallStill)]),
      downsized: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.downsized)]),
      downsizedStill: GiphyImage.fromJson(json[
          GiphyRenditionUtil.toStringValue(GiphyRendition.downsizedStill)]),
      downsizedLarge: GiphyImage.fromJson(json[
          GiphyRenditionUtil.toStringValue(GiphyRendition.downsizedLarge)]),
      downsizedMedium: GiphyImage.fromJson(json[
          GiphyRenditionUtil.toStringValue(GiphyRendition.downsizedMedium)]),
      original: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.original)]),
      originalStill: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.originalStill)]),
      looping: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.looping)]),
      preview: GiphyImage.fromJson(
          json[GiphyRenditionUtil.toStringValue(GiphyRendition.preview)]),
      downsizedSmall: GiphyImage.fromJson(json[
          GiphyRenditionUtil.toStringValue(GiphyRendition.downsizedSmall)]),
      mediaId: json['mediaId'],
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
