import 'giphy_images.dart';
import 'giphy_media_type.dart';
import 'giphy_rating.dart';
import 'giphy_user.dart';
import 'giphy_video.dart';

class Media {
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
  final Map<String, String>? userDictionary;

  Media({
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
    this.userDictionary,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json['id'],
        type: GiphyMediaTypeExtension.fromStringValue(json['type']),
        slug: json['slug'],
        url: json['url'],
        bitlyGifUrl: json['bitlyGifUrl'],
        bitlyUrl: json['bitlyUrl'],
        embedUrl: json['embedUrl'],
        source: json['source'],
        title: json['title'],
        rating: GiphyRatingExtension.fromStringValue(json['rating']),
        contentUrl: json['contentUrl'],
        tags: List<String>.from(json['tags'] ?? []),
        featuredTags: List<String>.from(json['featuredTags'] ?? []),
        user: json['user'] != null ? GiphyUser.fromJson(json['user']) : null,
        images: GiphyImages.fromJson(json['images']),
        video:
            json['video'] != null ? GiphyVideo.fromJson(json['video']) : null,
        analyticsResponsePayload: json['analyticsResponsePayload'],
        sourceTld: json['sourceTld'],
        sourcePostUrl: json['sourcePostUrl'],
        updateDate: json['updateDate'] != null
            ? DateTime.parse(json['updateDate'])
            : null,
        createDate: json['createDate'] != null
            ? DateTime.parse(json['createDate'])
            : null,
        importDate: json['importDate'] != null
            ? DateTime.parse(json['importDate'])
            : null,
        trendingDate: json['trendingDate'] != null
            ? DateTime.parse(json['trendingDate'])
            : null,
        isHidden: json['isHidden'] ?? false,
        isRemoved: json['isRemoved'] ?? false,
        isCommunity: json['isCommunity'] ?? false,
        isAnonymous: json['isAnonymous'] ?? false,
        isFeatured: json['isFeatured'] ?? false,
        isRealtime: json['isRealtime'] ?? false,
        isIndexable: json['isIndexable'] ?? false,
        isSticker: json['isSticker'] ?? false,
        isDynamic: json['isDynamic'] ?? false,
        animatedTextStyle: json['animatedTextStyle'],
        hasAttributions: json['hasAttributions'] ?? false,
        altText: json['altText'],
        variation: json['variation'],
        variationCount: json['variationCount'],
        userDictionary: Map<String, String>.from(json['userDictionary'] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type != null ? GiphyMediaTypeExtension.toStringValue(type!) : null,
        'slug': slug,
        'url': url,
        'bitlyGifUrl': bitlyGifUrl,
        'bitlyUrl': bitlyUrl,
        'embedUrl': embedUrl,
        'source': source,
        'title': title,
        'rating': rating != null ? GiphyRatingExtension.toStringValue(rating!) : null,
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
