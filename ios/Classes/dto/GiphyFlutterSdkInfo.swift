//
//  GiphyFlutterSdkInfo.swift
//  giphy_flutter_sdk
//
//  Created by Alex on 24.2.2024.
//

import Foundation

class GiphyFlutterSdkInfo {
    static let shared = GiphyFlutterSdkInfo()
    
    let name = "FlutterSDK"
    
    lazy var version: String? = {
        if let rawVersion = Bundle(for: type(of: self)).object(forInfoDictionaryKey: "CFBundleShortVersionString") {
            return rawVersion as? String
        }
        return nil
    }()
}
