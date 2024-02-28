//
//  GiphyFlutterMediaView.swift
//  giphy_flutter_sdk
//
//  Created by Alex on 27.2.2024.
//

import Flutter
import UIKit
import GiphyUISDK

public class GiphyFlutterMediaView: NSObject, FlutterPlatformView {
    let mediaView: GPHMediaView = GPHMediaView()
    
    static let DEFAULT_RENDITION_TYPE: GPHRenditionType = .fixedWidth
    
    private var media: GPHMedia? {
        didSet {
            syncMediaViewSource()
        }
    }
    
    private var renditionType: GPHRenditionType = DEFAULT_RENDITION_TYPE {
        didSet {
            syncMediaViewSource()
        }
    }
    
    private var resizeMode: GiphyFlutterResizeMode = .defaultMode {
        didSet {
            adjustResizeMode()
        }
    }
    
    init(frame: CGRect, viewId: Int64, args: Any?, binaryMessenger messenger: FlutterBinaryMessenger) {
        super.init()
        setupView()
        adjustResizeMode()
        createMethodChannel(viewId: viewId, messenger: messenger)
    }
    
    public func view() -> UIView {
        return mediaView
    }
    
    
    public func pause() {
        mediaView.stopAnimating()
    }
    
    public func resume() {
        mediaView.startAnimating()
    }
    
    public func setMediaWithId(_ value: String?) -> Void {
        guard
            let mediaId = value
        else {
            media = nil
            return
        }
        
        GiphyCore.shared.gifByID(mediaId) { [weak self] (response, error) in
            guard let self = self else {
                return
            }
            self.media = response?.data
        }
    }
    
    public func setAutoPlay(_ value: Bool) -> Void {
        mediaView.autoPlayAnimatedImage = value
    }
    
    public func setRenditionType(_ value: String?) -> Void {
        renditionType = GPHRenditionType.fromString(value: value) ?? GiphyFlutterMediaView.DEFAULT_RENDITION_TYPE
    }
    
    public func setResizeMode(_ value: String?) -> Void {
        resizeMode = GiphyFlutterResizeMode.fromString(value: value) ?? .defaultMode
    }
    
    private func createMethodChannel(viewId: Int64, messenger: FlutterBinaryMessenger) {
        let channel = FlutterMethodChannel(name: "com.giphyfluttersdk/mediaView\(viewId)", binaryMessenger: messenger)
        channel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard let self = self else {
                result(FlutterError(code: "SELF_NIL", message: "Reference to self is nil", details: nil))
                return
            }
            
            let arguments = call.arguments as? [String: Any?] ?? [:]
            
            switch call.method {
            case "setMediaWithId":
                if let mediaId = arguments["mediaId"] as? String {
                    self.setMediaWithId(mediaId)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected a mediaId", details: nil))
                }
                
            case "setMedia":
                if let mediaDict = arguments["media"] as? [String: Any?] {
                    self.media = mediaDict.toMedia()
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected a media dictionary", details: nil))
                }
                
            case "setAutoPlay":
                if let autoPlay = arguments["autoPlay"] as? Bool {
                    self.setAutoPlay(autoPlay)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected a boolean for autoPlay", details: nil))
                }
                
            case "setRenditionType":
                if let renditionType = arguments as? String {
                    self.setRenditionType(renditionType)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected a map for renditionType", details: nil))
                }
                
            case "setResizeMode":
                if let resizeMode = arguments["resizeMode"] as? String {
                    self.setResizeMode(resizeMode)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected a string for resizeMode", details: nil))
                }
                
            case "setShowCheckeredBackground":
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected a boolean for showCheckeredBackground", details: nil))
                
            case "pause":
                self.mediaView.stopAnimating()
                result(nil)
                
            case "resume":
                self.mediaView.startAnimating()
                result(nil)
                
            default:
                result(FlutterMethodNotImplemented)
            }            
        })
    }
    
    private func setupView() -> Void {
        mediaView.backgroundColor = .blue
        mediaView.clipsToBounds = true
    }
    
    private func adjustResizeMode() -> Void {
        switch resizeMode {
        case .center:
            mediaView.contentMode = .center
        case .contain:
            mediaView.contentMode = .scaleAspectFit
        case .cover:
            mediaView.contentMode = .scaleAspectFill
        case .stretch:
            mediaView.contentMode = .scaleToFill
        }
    }
    
    private func syncMediaViewSource() -> Void {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            if self.media == nil {
                self.mediaView.media = self.media
            } else {
                self.mediaView.setMedia(self.media!, rendition: self.renditionType)
            }
        }
    }
}
