enum GiphyVideoViewPlaybackState {
  unknown,
  readyToPlay,
  playing,
  paused,
}

extension GiphyVideoViewPlaybackStateExtension on GiphyVideoViewPlaybackState {
  static int toIntValue(GiphyVideoViewPlaybackState state) {
    switch (state) {
      case GiphyVideoViewPlaybackState.unknown:
        return 0;
      case GiphyVideoViewPlaybackState.readyToPlay:
        return 3;
      case GiphyVideoViewPlaybackState.playing:
        return 4;
      case GiphyVideoViewPlaybackState.paused:
        return 5;
      default:
        return 0;
    }
  }

  static GiphyVideoViewPlaybackState fromIntValue(int value) {
    switch (value) {
      case 0:
        return GiphyVideoViewPlaybackState.unknown;
      case 3:
        return GiphyVideoViewPlaybackState.readyToPlay;
      case 4:
        return GiphyVideoViewPlaybackState.playing;
      case 5:
        return GiphyVideoViewPlaybackState.paused;
      default:
        return GiphyVideoViewPlaybackState.unknown;
    }
  }
}