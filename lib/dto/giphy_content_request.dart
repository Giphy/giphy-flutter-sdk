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
  final String searchQuery;

  GiphyContentRequest({
    required this.mediaType,
    this.rating,
    required this.requestType,
    required this.searchQuery,
  });

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
