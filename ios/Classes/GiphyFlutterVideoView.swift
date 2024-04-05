//
//  GiphyFlutterVideoView.swift
//  giphy_flutter_sdk
//
//  Created by Alex on 25.3.2024.
//

import Flutter
import UIKit
import GiphyUISDK

public class GiphyFlutterVideoView: NSObject, FlutterPlatformView {
    private let playerView = GPHVideoPlayerView()
    
    private static let DEFAULT_RENDITION_TYPE: GPHRenditionType = .fixedWidth
    
    fileprivate var channel: FlutterMethodChannel?
    
    fileprivate var autoPlay: Bool = false
    
    private var muted: Bool = false {
        didSet {
            syncVolume()
        }
    }
    
    fileprivate var videoPlayerDelegate: GiphyVideoPlayerDelegate?
    
    var media: GPHMedia? {
        didSet {
            syncMedia()
        }
    }
    
    init(frame: CGRect, viewId: Int64, args: Any?, binaryMessenger messenger: FlutterBinaryMessenger) {
        super.init()
        ViewsRegister.shared.registerView(view: self)
        setupView(frame: frame)
        createMethodChannel(viewId: viewId, messenger: messenger)
        videoPlayerDelegate = GiphyVideoPlayerDelegate(view: self)
        GiphyFlutterSharedVideoPlayer.shared.add(listener: videoPlayerDelegate!)
    }
    
    deinit {
        ViewsRegister.shared.unregisterView(view: self)
        channel?.setMethodCallHandler(nil)
        if let videoPlayerDelegate = videoPlayerDelegate, GiphyFlutterSharedVideoPlayer.initialized {
            GiphyFlutterSharedVideoPlayer.shared.remove(listener: videoPlayerDelegate)
            self.videoPlayerDelegate = nil
        }
    }
    
    public func view() -> UIView {
        return playerView
    }
    
    private func setMediaWithId(_ value: String?) -> Void {
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
    
    private func createMethodChannel(viewId: Int64, messenger: FlutterBinaryMessenger) {
        channel = FlutterMethodChannel(name: "com.giphyfluttersdk/videoView\(viewId)", binaryMessenger: messenger)
        channel?.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard let self = self else {
                result(FlutterError(code: "SELF_NIL", message: "Reference to self is nil", details: nil))
                return
            }
            
            let arguments = call.arguments as? [String: Any?] ?? [:]            
            switch call.method {
            case "setMediaId":
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
                    self.autoPlay = autoPlay
                    if let media = self.media, autoPlay == true, ViewsRegister.shared.getLatestViewWithAutoPlayback() == self {
                        GiphyFlutterSharedVideoPlayer.shared.loadMedia(
                            media: media,
                            autoPlay: true,
                            muteOnPlay: self.muted,
                            view: self.playerView
                        )
                    }
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected a boolean for autoPlay", details: nil))
                }
                
            case "setMuted":
                if let muted = arguments["muted"] as? Bool {
                    self.muted = muted
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected a boolean for muted", details: nil))
                }
                
            default:
                result(FlutterMethodNotImplemented)
            }
        })
    }
    
    private func setupView(frame: CGRect) -> Void {
        playerView.frame = frame
        playerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        playerView.clipsToBounds = true
    }
    
    private func syncMedia() -> Void {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let media = self.media
            else {
                return
            }
            
            GiphyFlutterSharedVideoPlayer.shared.prepareMedia(media: media, view: self.playerView)
            if self.autoPlay == true && ViewsRegister.shared.getLatestViewWithAutoPlayback() == self {
                GiphyFlutterSharedVideoPlayer.shared.loadMedia(
                    media: media,
                    autoPlay: true,
                    muteOnPlay: self.muted == true,
                    view: self.playerView
                )
            }
        }
    }
    
    fileprivate func syncVolume() -> Void {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let _ = self.playerView.media
            else {
                return
            }
            if self.isViewPlayerActive() {
                GiphyFlutterSharedVideoPlayer.shared.mute(self.muted)
            }
        }
    }
    
    fileprivate func isViewPlayerActive() -> Bool {
        return GiphyFlutterSharedVideoPlayer.initialized && GiphyFlutterSharedVideoPlayer.shared.playerView == playerView
    }
}

private class ViewsRegister {
    static let shared = ViewsRegister()
    
    private var views: [GiphyFlutterVideoView] = []
    
    private init() {
    }
    
    func registerView(view: GiphyFlutterVideoView) {
        views.append(view)
    }
    
    func unregisterView(view: GiphyFlutterVideoView) {
        views.removeAll {
            $0 == view
        }
    }
    
    func getLatestViewWithAutoPlayback() -> GiphyFlutterVideoView? {
        return views.last {
            $0.autoPlay && $0.media != nil
        }
    }
}

fileprivate class GiphyVideoPlayerDelegate: GPHVideoPlayerStateListener {
    private weak var view: GiphyFlutterVideoView?
    
    init(view: GiphyFlutterVideoView) {
        self.view = view
    }
    
    //MARK: GPHVideoViewDelegate stubs
    func playerDidFail(_ description: String?) {
        guard let view = view, view.isViewPlayerActive() else {
            return
        }
        view.channel?.invokeMethod("onError", arguments: [
            "error": description ?? ""
        ])
    }
    
    func playerStateDidChange(_ state: GPHVideoPlayerState) {
        guard let view = view, view.isViewPlayerActive() else {
            return
        }
        
        // To prevent race conditions, update the volume as soon as the player is ready to play media.
        if state == .readyToPlay {
            view.syncVolume()
        }
        
        view.channel?.invokeMethod("onPlaybackStateChanged", arguments: [
            "code": state.toIntValue()
        ])
    }
    
    func muteDidChange(isMuted: Bool) {
        guard let view = view, view.isViewPlayerActive() else {
            return
        }
        
        if isMuted {
            view.channel?.invokeMethod("onMute", arguments: nil)
        } else {
            view.channel?.invokeMethod("onUnmute", arguments: nil)
        }
    }
}
