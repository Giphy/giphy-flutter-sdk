class GiphyVideoCaption {
  final String? srt;
  final String? vtt;

  GiphyVideoCaption({
    this.srt,
    this.vtt,
  });

  factory GiphyVideoCaption.fromJson(Map<String, dynamic> json) {
    return GiphyVideoCaption(
      srt: json['srt'] as String?,
      vtt: json['vtt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'srt': srt,
      'vtt': vtt,
    };
  }
}
