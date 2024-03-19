import 'giphy_images.dart';
import 'giphy_media_type.dart';
import 'giphy_rating.dart';
import 'giphy_user.dart';
import 'giphy_video.dart';

class GiphyMedia {
  final String id;
  final GiphyMediaType? type;
  final String? slug;
  final String? url;
  final String? bitlyGifUrl;
  final String? bitlyUrl;
  final String? embedUrl;
  final String? source;
  final String? title;
  final GiphyRating? rating;
  final String? contentUrl;
  final List<String>? tags;
  final List<String>? featuredTags;
  final GiphyUser? user;
  final GiphyImages images;
  final GiphyVideo? video;
  final String? analyticsResponsePayload;
  final String? sourceTld;
  final String? sourcePostUrl;
  final DateTime? updateDate;
  final DateTime? createDate;
  final DateTime? importDate;
  final DateTime? trendingDate;
  final bool isHidden;
  final bool isRemoved;
  final bool isCommunity;
  final bool isAnonymous;
  final bool isFeatured;
  final bool isRealtime;
  final bool isIndexable;
  final bool isSticker;
  final bool isDynamic;
  final String? animatedTextStyle;
  final bool hasAttributions;
  final String? altText;
  final String? variation;
  final int? variationCount;
  final double aspectRatio;
  final Map<String, String>? userDictionary;

  const GiphyMedia({
    required this.id,
    this.type,
    this.slug,
    this.url,
    this.bitlyGifUrl,
    this.bitlyUrl,
    this.embedUrl,
    this.source,
    this.title,
    this.rating,
    this.contentUrl,
    this.tags,
    this.featuredTags,
    this.user,
    required this.images,
    this.video,
    this.analyticsResponsePayload,
    this.sourceTld,
    this.sourcePostUrl,
    this.updateDate,
    this.createDate,
    this.importDate,
    this.trendingDate,
    this.isHidden = false,
    this.isRemoved = false,
    this.isCommunity = false,
    this.isAnonymous = false,
    this.isFeatured = false,
    this.isRealtime = false,
    this.isIndexable = false,
    this.isSticker = false,
    this.isDynamic = false,
    this.animatedTextStyle,
    this.hasAttributions = false,
    this.altText,
    this.variation,
    this.variationCount,
    this.aspectRatio = 1.0,
    this.userDictionary,
  });

  factory GiphyMedia.fromJson(Map<Object?, Object?> json) => GiphyMedia(
        id: json['id'] as String,
        type: json['type'] != null
            ? GiphyMediaTypeExtension.fromStringValue(json['type'] as String)
            : null,
        slug: json['slug'] as String?,
        url: json['url'] as String?,
        bitlyGifUrl: json['bitlyGifUrl'] as String?,
        bitlyUrl: json['bitlyUrl'] as String?,
        embedUrl: json['embedUrl'] as String?,
        source: json['source'] as String?,
        title: json['title'] as String?,
        rating: json['rating'] != null
            ? GiphyRatingExtension.fromStringValue(json['rating'] as String)
            : null,
        contentUrl: json['contentUrl'] as String?,
        tags: json['tags'] != null
            ? List<String>.from(json['tags'] as List)
            : null,
        featuredTags: json['featuredTags'] != null
            ? List<String>.from(json['featuredTags'] as List)
            : null,
        user: json['user'] != null
            ? GiphyUser.fromJson(json['user'] as Map<Object?, Object?>)
            : null,
        images: GiphyImages.fromJson(json['images'] as Map<Object?, Object?>),
        video: json['video'] != null
            ? GiphyVideo.fromJson(json['video'] as Map<Object?, Object?>)
            : null,
        analyticsResponsePayload: json['analyticsResponsePayload'] as String?,
        sourceTld: json['sourceTld'] as String?,
        sourcePostUrl: json['sourcePostUrl'] as String?,
        updateDate: json['updateDate'] != null
            ? DateTime.parse(json['updateDate'] as String)
            : null,
        createDate: json['createDate'] != null
            ? DateTime.parse(json['createDate'] as String)
            : null,
        importDate: json['importDate'] != null
            ? DateTime.parse(json['importDate'] as String)
            : null,
        trendingDate: json['trendingDate'] != null
            ? DateTime.parse(json['trendingDate'] as String)
            : null,
        isHidden: json['isHidden'] as bool? ?? false,
        isRemoved: json['isRemoved'] as bool? ?? false,
        isCommunity: json['isCommunity'] as bool? ?? false,
        isAnonymous: json['isAnonymous'] as bool? ?? false,
        isFeatured: json['isFeatured'] as bool? ?? false,
        isRealtime: json['isRealtime'] as bool? ?? false,
        isIndexable: json['isIndexable'] as bool? ?? false,
        isSticker: json['isSticker'] as bool? ?? false,
        isDynamic: json['isDynamic'] as bool? ?? false,
        animatedTextStyle: json['animatedTextStyle'] as String?,
        hasAttributions: json['hasAttributions'] as bool? ?? false,
        altText: json['altText'] as String?,
        variation: json['variation'] as String?,
        variationCount: json['variationCount'] as int?,
        aspectRatio: json['aspectRatio'] as double? ?? 1.0,
        userDictionary: json['userDictionary'] != null
            ? Map<String, String>.from(json['userDictionary'] as Map)
            : {},
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type':
            type != null ? GiphyMediaTypeExtension.toStringValue(type!) : null,
        'slug': slug,
        'url': url,
        'bitlyGifUrl': bitlyGifUrl,
        'bitlyUrl': bitlyUrl,
        'embedUrl': embedUrl,
        'source': source,
        'title': title,
        'rating':
            rating != null ? GiphyRatingExtension.toStringValue(rating!) : null,
        'contentUrl': contentUrl,
        'tags': tags,
        'featuredTags': featuredTags,
        'user': user?.toJson(),
        'images': images.toJson(),
        'video': video?.toJson(),
        'analyticsResponsePayload': analyticsResponsePayload,
        'sourceTld': sourceTld,
        'sourcePostUrl': sourcePostUrl,
        'updateDate': updateDate?.toIso8601String(),
        'createDate': createDate?.toIso8601String(),
        'importDate': importDate?.toIso8601String(),
        'trendingDate': trendingDate?.toIso8601String(),
        'isHidden': isHidden,
        'isRemoved': isRemoved,
        'isCommunity': isCommunity,
        'isAnonymous': isAnonymous,
        'isFeatured': isFeatured,
        'isRealtime': isRealtime,
        'isIndexable': isIndexable,
        'isSticker': isSticker,
        'isDynamic': isDynamic,
        'animatedTextStyle': animatedTextStyle,
        'hasAttributions': hasAttributions,
        'altText': altText,
        'variation': variation,
        'variationCount': variationCount,
        'userDictionary': userDictionary,
      };
}
