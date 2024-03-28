//
//  GiphyFlutterMedia.swift
//  giphy_flutter_sdk
//
//  Created by Alex on 25.2.2024.
//

import UIKit
import GiphyUISDK

fileprivate func objectToDictionary(_ object: Encodable) -> [String: Any?] {
    guard let data = try? JSONEncoder().encode(object),
          let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any?] else {
        return [:]
    }
    return json
}

fileprivate func dictionaryToObject<T: Decodable>(_ dict: [String: Any?]) -> T? {
    guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
        return nil
    }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .useDefaultKeys
    return try? decoder.decode(T.self, from: data)
}

extension GPHMedia {
    func toDictionary() -> [String: Any?] {
        guard let data = try? JSONEncoder().encode(self),
              let rep = try? JSONSerialization.jsonObject(with: data) as? [String: Any?] else {
            return [:]
        }
        var dict = rep
        dict["aspectRatio"] = self.aspectRatio
        dict["user"] = self.user?.toDictionary()
        dict["images"] = self.images?.toDictionary()
        dict["updateDate"] = dict["update_datetime"]
        dict["createDate"] = dict["create_datetime"]
        dict["isVideo"] = self.isVideo
        return dict.convertingKeys(.snakeToCamel)
    }
}

extension Dictionary where Key == String, Value == Any? {
    func toMedia() -> GPHMedia? {
        // This is a tricky workaround since we can't manually instantiate media, as it's supposed to be immutable on the Swift side.
        let keysToReplace = ["web_psize": "webp_size", "web_purl": "webp", "mp4_url": "mp4", "gif_url": "url"]
        let snakeCaseDictionary = self.convertingKeys(.camelToSnake, replacements: keysToReplace)
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: snakeCaseDictionary, options: []) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        
        return try? decoder.decode(GPHMedia.self, from: jsonData)
    }
}


extension GPHUser {
    func toDictionary() -> [String: Any?] {
        var dict = objectToDictionary(self)
        dict["id"] = "\(self.userId ?? "")"
        return dict
    }
}

extension GPHImage {
    func toDictionary() -> [String: Any?] {
        var dict = [String: Any?]()
        dict["gifUrl"] = self.gifUrl
        dict["mp4Url"] = self.mp4Url
        dict["webPUrl"] = self.webPUrl
        dict["mp4Size"] = self.mp4Size
        dict["gifSize"] = self.gifSize
        dict["width"] = self.width
        dict["webPSize"] = self.webPSize
        dict["frames"] = self.frames
        dict["height"] = self.height
        dict["renditionType"] = self.rendition.rawValue.snakeCaseToCamelCase()
        dict["mediaId"] = self.mediaId
        return dict
    }
}

extension GPHImages {
    func toDictionary() -> [String: Any?] {
        var dict = [String: Any?]()
        dict["mediaId"] = self.mediaId
        dict["fixedHeight"] = self.fixedHeight?.toDictionary()
        dict["fixedHeightStill"] = self.fixedHeightStill?.toDictionary()
        dict["fixedHeightDownsampled"] = self.fixedHeightDownsampled?.toDictionary()
        dict["fixedWidth"] = self.fixedWidth?.toDictionary()
        dict["fixedWidthStill"] = self.fixedWidthStill?.toDictionary()
        dict["fixedWidthDownsampled"] = self.fixedWidthDownsampled?.toDictionary()
        dict["fixedHeightSmall"] = self.fixedHeightSmall?.toDictionary()
        dict["fixedHeightSmallStill"] = self.fixedHeightSmallStill?.toDictionary()
        dict["fixedWidthSmall"] = self.fixedWidthSmall?.toDictionary()
        dict["fixedWidthSmallStill"] = self.fixedWidthSmallStill?.toDictionary()
        dict["downsized"] = self.downsized?.toDictionary()
        dict["downsizedStill"] = self.downsizedStill?.toDictionary()
        dict["downsizedLarge"] = self.downsizedLarge?.toDictionary()
        dict["downsizedMedium"] = self.downsizedMedium?.toDictionary()
        dict["original"] = self.original?.toDictionary()
        dict["originalStill"] = self.originalStill?.toDictionary()
        dict["looping"] = self.looping?.toDictionary()
        dict["preview"] = self.preview?.toDictionary()
        dict["downsizedSmall"] = self.downsizedSmall?.toDictionary()
        
        return dict
    }
}


