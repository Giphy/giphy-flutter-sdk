import 'giphy_media_type.dart';
import 'giphy_rating.dart';

/// Enumeration representing different types of Giphy content requests.
enum GiphyContentRequestType {
  trending,
  search,
  emoji,
  recents,
  animate,
}

/// A class representing a request for Giphy content.
class GiphyContentRequest {
  /// The media type for the Giphy content.
  final GiphyMediaType mediaType;

  /// The rating for the Giphy content.
  final GiphyRating? rating;

  /// The type of request being made.
  final GiphyContentRequestType requestType;

  /// The search query for the request, if applicable.
  final String? searchQuery;

  /// Creates a [GiphyContentRequest] instance with the given parameters.
  const GiphyContentRequest({
    required this.mediaType,
    this.rating,
    required this.requestType,
    this.searchQuery,
  });

  /// Creates a [GiphyContentRequest] for searching content.
  factory GiphyContentRequest.search(
      {required GiphyMediaType mediaType, GiphyRating rating = GiphyRating
          .pg13, required String searchQuery}) {
    return GiphyContentRequest(requestType: GiphyContentRequestType.search,
        mediaType: mediaType,
        rating: rating,
        searchQuery: searchQuery);
  }

  /// Creates a [GiphyContentRequest] for trending content.
  factory GiphyContentRequest.trending(
      {required GiphyMediaType mediaType,
      GiphyRating rating = GiphyRating.pg13}) {
    return GiphyContentRequest(requestType: GiphyContentRequestType.trending,
        mediaType: mediaType,
        rating: rating);
  }

  /// Creates a [GiphyContentRequest] for trending GIFs.
  factory GiphyContentRequest.trendingGifs(
      {GiphyRating rating = GiphyRating.pg13}) {
    return GiphyContentRequest.trending(
        mediaType: GiphyMediaType.gif, rating: rating);
  }

  /// Creates a [GiphyContentRequest] for trending stickers.
  factory GiphyContentRequest.trendingStickers(
      {GiphyRating rating = GiphyRating.pg13}) {
    return GiphyContentRequest.trending(
        mediaType: GiphyMediaType.sticker, rating: rating);
  }

  /// Creates a [GiphyContentRequest] for trending text.
  factory GiphyContentRequest.trendingText(
      {GiphyRating rating = GiphyRating.pg13}) {
    return GiphyContentRequest.trending(
        mediaType: GiphyMediaType.text, rating: rating);
  }

  /// Creates a [GiphyContentRequest] for recent content.
  factory GiphyContentRequest.recents() {
    return const GiphyContentRequest(
        requestType: GiphyContentRequestType.recents,
        mediaType: GiphyMediaType.gif);
  }

  /// Creates a [GiphyContentRequest] for emoji content.
  factory GiphyContentRequest.emoji() {
    return const GiphyContentRequest(
        requestType: GiphyContentRequestType.emoji,
        mediaType: GiphyMediaType.emoji);
  }

  /// Creates a [GiphyContentRequest] for dynamic texts.
  factory GiphyContentRequest.animate(String input) {
    return GiphyContentRequest(
        requestType: GiphyContentRequestType.animate,
        mediaType: GiphyMediaType.text,
        searchQuery: input);
  }

  /// Creates a [GiphyContentRequest] instance from a JSON object.
  factory GiphyContentRequest.fromJson(Map<Object?, Object?> json) {
    return GiphyContentRequest(
      mediaType: GiphyMediaTypeExtension.fromStringValue(json['mediaType'] as String),
      rating: json['rating'] != null ? GiphyRatingExtension.fromStringValue(json['rating'] as String) : null,
      requestType: GiphyContentRequestType.values.firstWhere(
            (e) => e.toString().split('.').last == json['requestType'] as String?,
        orElse: () => GiphyContentRequestType.trending,
      ),
      searchQuery: json['searchQuery'] as String? ?? '',
    );
  }

  /// Converts the [GiphyContentRequest] instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'mediaType': GiphyMediaTypeExtension.toStringValue(mediaType),
      'rating':
          rating != null ? GiphyRatingExtension.toStringValue(rating!) : null,
      'requestType': requestType.toString().split('.').last,
      'searchQuery': searchQuery,
    };
  }
}
