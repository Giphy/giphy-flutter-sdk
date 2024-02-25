//
//  GiphyFlutterDialog.swift
//  giphy_flutter_sdk
//
//  Created by Alex on 24.2.2024.
//

import Foundation

import Flutter
import UIKit
import GiphyUISDK

class GiphyFlutterDialog: NSObject {
    
    fileprivate var channel: FlutterMethodChannel?
    
    fileprivate var config: [String: Any]
    fileprivate var giphyViewController: GiphyViewController?
    
    public override init() {
        config = .init()
        super.init()
    }
    
    deinit {
        giphyViewController?.delegate = nil
    }
    
    func onAttachedToEngine(flutterPluginBinding: FlutterPluginRegistrar) {
        self.channel = FlutterMethodChannel(name: "com.giphyfluttersdk/dialog", binaryMessenger: flutterPluginBinding.messenger())
        if let channel = self.channel {
            flutterPluginBinding.addMethodCallDelegate(self, channel: channel)
        }
    }
    
    func onDettachedFromEngine(flutterPluginBinding: FlutterPluginRegistrar) {
        self.channel = nil
    }
    
    fileprivate func configure(value: [String: Any]) -> Void {
        config.merge(value) { (_, new) in new }
    }
    
    fileprivate func show() -> Void {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            let giphy = GiphyViewController()
            var currentViewController = UIApplication.shared.windows.first?.rootViewController
            while let presentedViewController = currentViewController?.presentedViewController {
                currentViewController = presentedViewController
            }
            giphy.applyFlutterConfig(self.config)
            giphy.delegate = self
            currentViewController?.present(giphy, animated: true, completion: { [weak self] in
                self?.giphyViewController = giphy
            })
        }
    }
}

extension GiphyFlutterDialog: GiphyDelegate {
    func didDismiss(controller: GiphyUISDK.GiphyViewController?) {
        channel?.invokeMethod("onDismiss", arguments: nil)
    }
    
    func didSelectMedia(giphyViewController: GiphyViewController, media: GPHMedia) {
        channel?.invokeMethod("onMediaSelect",
                              arguments: [
                                "media": media.toDictionary(),
                                "searchTerm": nil,
                                "selectedContentType": giphyViewController.selectedContentType.rawValue
                              ])
    }
    
}

extension GiphyFlutterDialog: FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        // Actually, it's not a plugin; it's more of a separate logic, so we don't need to register anything here.
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "configure":
            if let params = call.arguments as? [String: Any] {
                config.merge(params) { (_, new) in new }
            }
            result(nil)
        case "show":
            show()
            result(nil)
        case "hide":
            result(nil)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
