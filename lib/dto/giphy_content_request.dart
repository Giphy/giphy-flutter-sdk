import 'giphy_media_type.dart';
import 'giphy_rating.dart';

enum GiphyContentRequestType {
  trending,
  search,
  emoji,
  recents,
  animate,
}

class GiphyContentRequest {
  final GiphyMediaType mediaType;
  final GiphyRating? rating;
  final GiphyContentRequestType requestType;
  final String? searchQuery;

  const GiphyContentRequest({
    required this.mediaType,
    this.rating,
    required this.requestType,
    this.searchQuery,
  });

  factory GiphyContentRequest.search(
      {required GiphyMediaType mediaType, GiphyRating rating = GiphyRating
          .pg13, required String searchQuery}) {
    return GiphyContentRequest(requestType: GiphyContentRequestType.search,
        mediaType: mediaType,
        rating: rating,
        searchQuery: searchQuery);
  }

  factory GiphyContentRequest.trending(
      {required GiphyMediaType mediaType,
      GiphyRating rating = GiphyRating.pg13}) {
    return GiphyContentRequest(requestType: GiphyContentRequestType.trending,
        mediaType: mediaType,
        rating: rating);
  }

  factory GiphyContentRequest.trendingGifs(
      {GiphyRating rating = GiphyRating.pg13}) {
    return GiphyContentRequest.trending(
        mediaType: GiphyMediaType.gif, rating: rating);
  }

  factory GiphyContentRequest.trendingStickers(
      {GiphyRating rating = GiphyRating.pg13}) {
    return GiphyContentRequest.trending(
        mediaType: GiphyMediaType.sticker, rating: rating);
  }

  factory GiphyContentRequest.trendingText(
      {GiphyRating rating = GiphyRating.pg13}) {
    return GiphyContentRequest.trending(
        mediaType: GiphyMediaType.text, rating: rating);
  }

  factory GiphyContentRequest.recents() {
    return const GiphyContentRequest(
        requestType: GiphyContentRequestType.recents,
        mediaType: GiphyMediaType.gif);
  }

  factory GiphyContentRequest.emoji() {
    return const GiphyContentRequest(
        requestType: GiphyContentRequestType.emoji,
        mediaType: GiphyMediaType.emoji);
  }

  factory GiphyContentRequest.animate(String input) {
    return GiphyContentRequest(
        requestType: GiphyContentRequestType.animate,
        mediaType: GiphyMediaType.text,
        searchQuery: input);
  }

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
