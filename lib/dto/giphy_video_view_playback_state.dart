/// An enumeration representing the playback state of a Giphy video view.
enum GiphyVideoViewPlaybackState {
  unknown,
  readyToPlay,
  playing,
  paused,
}

/// Extension methods for [GiphyVideoViewPlaybackState] to convert between integer values and enum values.
extension GiphyVideoViewPlaybackStateExtension on GiphyVideoViewPlaybackState {
  /// Converts a [GiphyVideoViewPlaybackState] enum value to an integer.
  ///
  /// [state] The playback state to be converted.
  ///
  /// Returns the corresponding integer value for the given playback state.
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

  /// Converts an integer to a corresponding [GiphyVideoViewPlaybackState] enum value.
  ///
  /// [value] The integer value to be converted.
  ///
  /// Returns the corresponding playback state for the given integer value.
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
