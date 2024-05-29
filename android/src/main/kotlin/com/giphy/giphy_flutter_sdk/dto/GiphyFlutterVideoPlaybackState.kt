package com.giphy.giphy_flutter_sdk.dto

enum class GiphyFlutterVideoPlaybackState(val code: Int) {
    Unknown(0),
    ReadyToPlay(3),
    Playing(4),
    Paused(5),
}