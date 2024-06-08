/// A class representing the captions of a Giphy video in different formats.
class GiphyVideoCaption {
  /// The SubRip Subtitle (SRT) format caption.
  final String? srt;

  /// The Web Video Text Tracks (VTT) format caption.
  final String? vtt;

  /// Creates a new `GiphyVideoCaption` instance.
  ///
  /// Both [srt] and [vtt] parameters are optional and can be supplied as `null`.
  const GiphyVideoCaption({
    this.srt,
    this.vtt,
  });

  /// Creates a new `GiphyVideoCaption` instance from a JSON object.
  ///
  /// The keys `srt` and `vtt` in the JSON map should be of type `String?`.
  factory GiphyVideoCaption.fromJson(Map<Object?, Object?> json) {
    return GiphyVideoCaption(
      srt: json['srt'] as String?,
      vtt: json['vtt'] as String?,
    );
  }

  /// Converts this `GiphyVideoCaption` instance to a JSON object.
  ///
  /// Returns a `Map<String, dynamic>` representing this `GiphyVideoCaption`.
  Map<String, dynamic> toJson() {
    return {
      'srt': srt,
      'vtt': vtt,
    };
  }
}
