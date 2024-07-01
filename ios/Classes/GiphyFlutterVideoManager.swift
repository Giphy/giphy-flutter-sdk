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
        channel?.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard let self = self else {
                result(FlutterError(code: "SELF_NIL", message: "Reference to self is nil", details: nil))
                return
            }            
            
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
        })

    }
    
    func onDettachedFromEngine(flutterPluginBinding: FlutterPluginRegistrar) {
        self.channel?.setMethodCallHandler(nil)
        self.channel = nil
    }
}

