//
//  GiphyFlutterTypeExtensions.swift
//  giphy_flutter_sdk
//
//  Created by Alex on 25.2.2024.
//

import UIKit

import GiphyUISDK

extension GPHContentType {
    static func fromString(_ value: String?) -> GPHContentType? {
        switch value {
        case "emoji":
            return .emoji
        case "gif":
            return .gifs
        case "recents":
            return .recents
        case "sticker":
            return .stickers
        case "text":
            return .text
        case "clips":
            return .clips
        default:
            return nil
        }
    }
    
    func toString() -> String {
        switch self {            
        case .recents:
            return "recents"
        case .gifs:
            return "gif"
        case .clips:
            return "clips"
        case .stickers:
            return "sticker"
        case .text:
            return "text"
        case .emoji:
            return "emoji"
        @unknown default:
            return "gif"
        }
    }
}

extension GPHRatingType {
    static func fromString(_ value: String?) -> GPHRatingType? {
        guard let value = value else { return nil }
        
        return GPHRatingType(rawValue: value.replacingOccurrences(of: "-", with: ""))
    }
}

extension GPHRenditionType {
    static func fromString(_ value: String?) -> GPHRenditionType? {
        guard let value = value else { return nil }
        return GPHRenditionType(rawValue: value.camelCaseToSnakeCase())
    }
}

extension GPHStickerColumnCount {
    static func fromString(_ value: Int?) -> GPHStickerColumnCount? {
        switch value {
        case 2:
            return .two
        case 3:
            return .three
        case 4:
            return .four
        default:
            return nil
        }
    }
}

extension GPHFileExtension {
    static func fromString(_ value: String?) -> GPHFileExtension? {
        switch value {
        case "gif":
            return .gif
        case "mp4":
            return .mp4
        case "webp":
            return .webp
        default:
            return nil
        }
    }
}

extension UICollectionView.ScrollDirection {
    static func fromString(_ value: String) -> UICollectionView.ScrollDirection {
        switch value {
        case "horizontal":
            return .horizontal
        case "vertical":
            return .vertical
        default:
            return .vertical
        }
    }
}

extension UIKeyboardAppearance {
    static func fromString(_ value: String) -> UIKeyboardAppearance? {
        switch value {
        case "default":
            return .default
        case "dark":
            return .dark
        case "light":
            return .light
        default:
            return nil
        }
    }
}

extension UIScrollView.IndicatorStyle {
    static func fromString(_ value: String) -> UIScrollView.IndicatorStyle? {
        switch value {
        case "default":
            return .default
        case "dark":
            return .black
        case "light":
            return .white
        default:
            return nil
        }
    }
}

extension GPHMediaType {
    static func fromString(_ value: String) -> GPHMediaType {
        return GPHMediaType.init(rawValue: value) ?? .gif
    }
}

extension GPHContent {
    static func fromDictionary(_ value: [String: Any?]) -> GPHContent {
        let requestType = value["requestType"] as? String
        let searchQuery = value["searchQuery"] as? String ?? ""
        let mediaType = GPHMediaType.fromString(value["mediaType"] as? String ?? "")
        
        switch requestType {
        case "search":
            return GPHContent.search(withQuery: searchQuery, mediaType: mediaType, language: .english)
        case "trending":
            return GPHContent.trending(mediaType: mediaType)
        case "emoji":
            return GPHContent.emoji
        case "recents":
            return GPHContent.recents
        case "animate":
            return GPHContent.animate(searchQuery)
        default:
            return GPHContent()
        }
    }
}

extension GPHThemeType {
    static func fromString(_ value: String) -> GPHThemeType? {
        switch value {
        case "automatic":
            return .automatic
        case "dark":
            return .dark
        case "light":
            return .light
        default:
            return nil
        }
    }
}

extension GiphyViewController {
    func applyFlutterConfig(_ options: [String: Any?]) -> Void {
        
        guard let settings = options["settings"] as? [String: Any?] else { return }
        
        if let rawMediaTypeConfig = settings["mediaTypeConfig"] as? [String] {
            mediaTypeConfig = rawMediaTypeConfig.compactMap {
                GPHContentType.fromString($0)
            }
        }
        
        enableDynamicText = settings["enableDynamicText"] as? Bool ?? false
        theme = GiphyFlutterTheme(flutterConfig: settings["theme"] as? [String: Any?])
        
        let rawRating = settings["rating"] as? String
        if let rating = GPHRatingType.fromString(rawRating) {
            self.rating = rating
        }
        
        let rawRenditionType = settings["renditionType"] as? String
        if let renditionType = GPHRenditionType.fromString(rawRenditionType) {
            self.renditionType = renditionType
        }
        
        let rawFileFormat = settings["fileFormat"] as? String
        if let fileFormat = GPHFileExtension.fromString(rawFileFormat) {
            self.fileExtension = fileFormat
        }
        
        let rawClipsPreviewRenditionType = settings["clipsPreviewRenditionType"] as? String
        if let clipsPreviewRenditionType = GPHRenditionType.fromString(rawClipsPreviewRenditionType) {
            self.clipsPreviewRenditionType = clipsPreviewRenditionType
        }
                
        if let showConfirmationScreen = settings["showConfirmationScreen"] as? Bool {
            self.showConfirmationScreen = showConfirmationScreen
        }
        
        let rawStickerColumnCount = settings["stickerColumnCount"] as? Int
        if let stickerColumnCount = GPHStickerColumnCount.fromString(rawStickerColumnCount) {
            self.stickerColumnCount = stickerColumnCount
        }
        
        if let shouldLocalizeSearch = settings["shouldLocalizeSearch"] as? Bool {
            self.shouldLocalizeSearch = shouldLocalizeSearch
        }
        
        if let trayHeightMultiplier = settings["trayHeightMultiplier"] as? CGFloat {
            GiphyViewController.trayHeightMultiplier = trayHeightMultiplier
        }
        
        let rawSelectedContentType = settings["selectedContentType"] as? String
        if let selectedContentType = GPHContentType.fromString(rawSelectedContentType) {
            if mediaTypeConfig.contains(selectedContentType) {
                self.selectedContentType = selectedContentType
            } else {
                self.selectedContentType = mediaTypeConfig.first ?? .gifs
            }
        }
    }
}

enum GiphyFlutterVideoPlayerState: Int {
  case unknown = 0
  case readyToPlay = 3
  case playing = 4
  case paused = 5

  func toIntValue() -> Int {
    return self.rawValue
  }
}

extension GPHVideoPlayerState {
  func toIntValue() -> Int {
    var state: GiphyFlutterVideoPlayerState {
      switch self {
      case .readyToPlay:
        return GiphyFlutterVideoPlayerState.readyToPlay
      case .playing:
        return GiphyFlutterVideoPlayerState.playing
      case .paused:
        return GiphyFlutterVideoPlayerState.paused
      case .unknown:
        return GiphyFlutterVideoPlayerState.unknown
      default:
        return GiphyFlutterVideoPlayerState.unknown
      }
    }
    return state.toIntValue()
  }
}
