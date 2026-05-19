//
//  GiphyFlutterResizeMode.swift
//  giphy_flutter_sdk
//
//  Created by Alex on 24.2.2024.
//

public enum GiphyFlutterResizeMode: Int {
    case center = 1
    case contain = 2
    case cover = 3
    case stretch = 4
    
    static let defaultMode: GiphyFlutterResizeMode = .cover
    
    static func fromString(value: String?) -> GiphyFlutterResizeMode? {
        switch value {
        case "center":
            return .center
        case "contain":
            return .contain
        case "cover":
            return .cover
        case "stretch":
            return .stretch
        default:
            return nil
        }
    }
}
