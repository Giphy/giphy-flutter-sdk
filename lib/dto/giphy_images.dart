import 'giphy_image.dart';
import 'giphy_rendition.dart';

/// A class representing various renditions of Giphy images.
class GiphyImages {
  /// Height set to 200px. Good for mobile use.
  final GiphyImage? fixedHeight;

  /// Static preview image for fixed_height.
  final GiphyImage? fixedHeightStill;

  /// Height set to 200px. Reduced to 6 frames to minimize file size to the lowest.
  /// Works well for unlimited scroll on mobile and as animated previews. See Giphy.com on mobile web as an example.
  final GiphyImage? fixedHeightDownsampled;

  /// Width set to 200px. Good for mobile use.
  final GiphyImage? fixedWidth;

  /// Static preview image for fixed_width.
  final GiphyImage? fixedWidthStill;

  /// Width set to 200px. Reduced to 6 frames.
  /// Works well for unlimited scroll on mobile and as animated previews.
  final GiphyImage? fixedWidthDownsampled;

  /// Height set to 100px. Good for mobile keyboards.
  final GiphyImage? fixedHeightSmall;

  /// Static preview image for fixed_height_small.
  final GiphyImage? fixedHeightSmallStill;

  /// Width set to 100px. Good for mobile keyboards.
  final GiphyImage? fixedWidthSmall;

  /// Static preview image for fixed_width_small.
  final GiphyImage? fixedWidthSmallStill;

  /// File size under 2mb.
  final GiphyImage? downsized;

  /// Static preview image for downsized.
  final GiphyImage? downsizedStill;

  /// File size under 8mb.
  final GiphyImage? downsizedLarge;

  /// File size under 5mb.
  final GiphyImage? downsizedMedium;

  /// Original file size and file dimensions. Good for desktop use.
  final GiphyImage? original;

  /// Static preview image for original.
  final GiphyImage? originalStill;

  /// Duration set to loop for 15 seconds. Only recommended for this exact use case.
  final GiphyImage? looping;

  /// File size under 50kb. Duration may be truncated to meet file size requirements.
  /// Good for thumbnails and previews.
  final GiphyImage? preview;

  /// File size under 200kb.
  final GiphyImage? downsizedSmall;

  /// The media ID associated with the image.
  final String? mediaId;

  /// Creates a [GiphyImages] instance with the given renditions.
  const GiphyImages({
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

  /// Creates a [GiphyImages] instance from a JSON object.
  ///
  /// [json] A map containing key-value pairs corresponding to the image renditions.
  ///
  /// Returns a [GiphyImages] instance populated with the values from the JSON object.
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

  /// Converts the [GiphyImages] instance to a JSON object.
  ///
  /// Returns a map containing key-value pairs corresponding to the image renditions.
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
