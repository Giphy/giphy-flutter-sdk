//
//  GiphyFlutterSharedVideoPlayer.swift
//  giphy_flutter_sdk
//
//  Created by Alex on 25.3.2024.
//

import GiphyUISDK

class GiphyFlutterSharedVideoPlayer {
  static var initialized: Bool = false

  static let shared: GPHVideoPlayer = {
    initialized = true
    return GPHVideoPlayer()
  }()

  private init() {
  }
}
