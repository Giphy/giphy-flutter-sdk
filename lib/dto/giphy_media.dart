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
        bitlyGifUrl: json['bitly_gif_url'],
        bitlyUrl: json['bitly_url'],
        embedUrl: json['embed_url'],
        source: json['source'],
        title: json['title'],
        rating: GiphyRatingExtension.fromStringValue(json['rating']),
        contentUrl: json['content_url'],
        tags: List<String>.from(json['tags'] ?? []),
        featuredTags: List<String>.from(json['featured_tags'] ?? []),
        user: json['user'] != null ? GiphyUser.fromJson(json['user']) : null,
        images: GiphyImages.fromJson(json['images']),
        video:
            json['video'] != null ? GiphyVideo.fromJson(json['video']) : null,
        analyticsResponsePayload: json['analytics_response_payload'],
        sourceTld: json['source_tld'],
        sourcePostUrl: json['source_post_url'],
        updateDate: json['update_datetime'] != null
            ? DateTime.parse(json['update_datetime'])
            : null,
        createDate: json['create_datetime'] != null
            ? DateTime.parse(json['create_datetime'])
            : null,
        importDate: json['import_datetime'] != null
            ? DateTime.parse(json['import_datetime'])
            : null,
        trendingDate: json['trending_datetime'] != null
            ? DateTime.parse(json['trending_datetime'])
            : null,
        isHidden: json['is_hidden'] ?? false,
        isRemoved: json['is_removed'] ?? false,
        isCommunity: json['is_community'] ?? false,
        isAnonymous: json['is_anonymous'] ?? false,
        isFeatured: json['is_featured'] ?? false,
        isRealtime: json['is_realtime'] ?? false,
        isIndexable: json['is_indexable'] ?? false,
        isSticker: json['is_sticker'] ?? false,
        isDynamic: json['is_dynamic'] ?? false,
        animatedTextStyle: json['animated_text_style'],
        hasAttributions: json['has_attribution'] ?? false,
        altText: json['alt_text'],
        variation: json['variation'],
        variationCount: json['variation_count'],
        userDictionary: Map<String, String>.from(json['userDictionary'] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type != null ? GiphyMediaTypeExtension.toStringValue(type!) : null,
        'slug': slug,
        'url': url,
        'bitly_gif_url': bitlyGifUrl,
        'bitly_url': bitlyUrl,
        'embed_url': embedUrl,
        'source': source,
        'title': title,
        'rating': rating != null ? GiphyRatingExtension.toStringValue(rating!) : null,
        'content_url': contentUrl,
        'tags': tags,
        'featured_tags': featuredTags,
        'user': user?.toJson(),
        'images': images.toJson(),
        'video': video?.toJson(),
        'analytics_response_payload': analyticsResponsePayload,
        'source_tld': sourceTld,
        'source_post_url': sourcePostUrl,
        'update_datetime': updateDate?.toIso8601String(),
        'create_datetime': createDate?.toIso8601String(),
        'import_datetime': importDate?.toIso8601String(),
        'trending_datetime': trendingDate?.toIso8601String(),
        'is_hidden': isHidden,
        'is_removed': isRemoved,
        'is_community': isCommunity,
        'is_anonymous': isAnonymous,
        'is_featured': isFeatured,
        'is_realtime': isRealtime,
        'is_indexable': isIndexable,
        'is_sticker': isSticker,
        'is_dynamic': isDynamic,
        'animated_text_style': animatedTextStyle,
        'has_attribution': hasAttributions,
        'alt_text': altText,
        'variation': variation,
        'variation_count': variationCount,
        'userDictionary': userDictionary,
      };
}
