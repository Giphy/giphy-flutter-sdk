enum GiphyRating { g, pg, pg13, r, unrated, y, nsfw }

extension GiphyRatingExtension on GiphyRating {
  static GiphyRating fromStringValue(String value) {
    switch (value) {
      case 'r':
        return GiphyRating.r;
      case 'y':
        return GiphyRating.y;
      case 'g':
        return GiphyRating.g;
      case 'pg':
        return GiphyRating.pg;
      case 'pg13':
        return GiphyRating.pg13;
      case 'unrated':
        return GiphyRating.unrated;
      case 'nsfw':
        return GiphyRating.nsfw;
      default:
        throw ArgumentError('Invalid rating type: $value');
    }
  }

  static String toStringValue(GiphyRating rating) {
    switch (rating) {
      case GiphyRating.g:
        return 'g';
      case GiphyRating.pg:
        return 'pg';
      case GiphyRating.pg13:
        return 'pg13';
      case GiphyRating.r:
        return 'r';
      case GiphyRating.unrated:
        return 'unrated';
      case GiphyRating.y:
        return 'y';
      case GiphyRating.nsfw:
        return 'nsfw';
      default:
        throw ArgumentError('Unknown GiphyRating value: $rating');
    }
  }
}
