//
//  GiphyFlutterVideoManager.swift
//  giphy_flutter_sdk
//
//  Created by Alex on 25.3.2024.
//

import Foundation

import Flutter
import UIKit
import GiphyUISDK

class GiphyFlutterVideoManager: NSObject {
    
    fileprivate var channel: FlutterMethodChannel?
    
    public override init() {
        super.init()
    }
    
    deinit {
    }
    
    func onAttachedToEngine(flutterPluginBinding: FlutterPluginRegistrar) {
        self.channel = FlutterMethodChannel(name: "com.giphyfluttersdk/videoManager", binaryMessenger: flutterPluginBinding.messenger())
        if let channel = self.channel {
            flutterPluginBinding.addMethodCallDelegate(self, channel: channel)
        }
    }
    
    func onDettachedFromEngine(flutterPluginBinding: FlutterPluginRegistrar) {
        self.channel = nil
    }
}

extension GiphyFlutterVideoManager: FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        // Actually, it's not a plugin; it's more of a separate logic, so we don't need to register anything here.
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "muteAll":
            DispatchQueue.main.async {
                if GiphyFlutterSharedVideoPlayer.initialized {
                    GiphyFlutterSharedVideoPlayer.shared.mute(true)
                }
            }
            result(nil)
        case "pauseAll":
            DispatchQueue.main.async {
                if GiphyFlutterSharedVideoPlayer.initialized {
                    GiphyFlutterSharedVideoPlayer.shared.pause()
                }
            }
            result(nil)
        case "resume":
            DispatchQueue.main.async {                
                if GiphyFlutterSharedVideoPlayer.initialized {
                    GiphyFlutterSharedVideoPlayer.shared.resume()
                }
            }
            result(nil)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
