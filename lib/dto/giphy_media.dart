import 'giphy_images.dart';
import 'giphy_media_type.dart';
import 'giphy_rating.dart';
import 'giphy_user.dart';
import 'giphy_video.dart';

/// A class representing media content on Giphy.
class GiphyMedia {
  /// The unique identifier for the media.
  final String id;

  /// The type of media (e.g., gif, sticker).
  final GiphyMediaType? type;

  /// The slug (a URL-friendly identifier) for the media.
  final String? slug;

  /// The URL for the media.
  final String? url;

  /// The shortened Bitly URL for the GIF.
  final String? bitlyGifUrl;

  /// The shortened Bitly URL for the media.
  final String? bitlyUrl;

  /// The URL to embed the media.
  final String? embedUrl;

  /// The source URL of the media.
  final String? source;

  /// The title of the media.
  final String? title;

  /// The rating of the media.
  final GiphyRating? rating;

  /// The content URL of the media.
  final String? contentUrl;

  /// A list of tags associated with the media.
  final List<String>? tags;

  /// A list of featured tags associated with the media.
  final List<String>? featuredTags;

  /// The user who uploaded the media.
  final GiphyUser? user;

  /// The images associated with the media.
  final GiphyImages images;

  /// The video associated with the media.
  final GiphyVideo? video;

  /// The analytics response payload.
  final String? analyticsResponsePayload;

  /// Attribution Source Domain TLD.
  final String? sourceTld;

  /// Attribution Source Post URL.
  final String? sourcePostUrl;

  /// The date the media was last updated.
  final DateTime? updateDate;

  /// The date the media was created.
  final DateTime? createDate;

  /// The date the media was imported.
  final DateTime? importDate;

  /// The date the media started trending.
  final DateTime? trendingDate;

  /// Whether the media is hidden.
  final bool isHidden;

  /// Whether the media is removed.
  final bool isRemoved;

  /// Whether the media is community content.
  final bool isCommunity;

  /// Whether the media was uploaded anonymously.
  final bool isAnonymous;

  /// Whether the media is featured.
  final bool isFeatured;

  /// Whether the media is in real-time.
  final bool isRealtime;

  /// Whether the media is indexable.
  final bool isIndexable;

  /// Whether the media is a sticker.
  final bool isSticker;

  /// True if this is dynamically generated like texts, false otherwise
  final bool isDynamic;

  /// Whether the media is a video.
  final bool isVideo;

  /// The style of dynamic text.
  final String? animatedTextStyle;

  /// Whether the media has attributions.
  final bool hasAttributions;

  /// Enables assistive programs to read descriptions of GIFs.
  final String? altText;

  /// String representation of emoji variation
  final String? variation;

  /// Emoji variation count
  final int? variationCount;

  /// The aspect ratio of the media.
  final double aspectRatio;

  /// A dictionary of user attributes.
  final Map<String, String>? userDictionary;

  /// Creates a [GiphyMedia] instance with the given attributes.
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
    this.isVideo = false,
    this.animatedTextStyle,
    this.hasAttributions = false,
    this.altText,
    this.variation,
    this.variationCount,
    this.aspectRatio = 1.0,
    this.userDictionary,
  });

  /// Creates a [GiphyMedia] instance from a JSON object.
  ///
  /// [json] A map containing key-value pairs corresponding to the media attributes.
  ///
  /// Returns a [GiphyMedia] instance populated with the values from the JSON object.
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
        isVideo: json['isVideo'] as bool? ?? false,
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

  /// Converts the [GiphyMedia] instance to a JSON object.
  ///
  /// Returns a map containing key-value pairs corresponding to the media attributes.
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
