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
    
    fileprivate var config: [String: Any?]
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
        
        channel?.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard let self = self else {
                result(FlutterError(code: "SELF_NIL", message: "Reference to self is nil", details: nil))
                return
            }            
            
            switch call.method {
            case "configure":
                if let params = call.arguments as? [String: Any?] {
                    config.merge(params) { (_, new) in new }
                }
                result(nil)
            case "show":
                show()
                result(nil)
            case "hide":
                hide()
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
    
    fileprivate func hide() -> Void {
      DispatchQueue.main.async { [weak self] in
        guard let self = self else {
          return
        }

        self.giphyViewController?.dismiss(animated: true, completion: { [weak self] in
          self?.giphyViewController = nil
        })
      }
    }
}

extension GiphyFlutterDialog: GiphyDelegate {
    func didDismiss(controller: GiphyUISDK.GiphyViewController?) {
        channel?.invokeMethod("onDismiss", arguments: nil)
    }
    
    func didSelectMedia(giphyViewController: GiphyViewController, media: GPHMedia) {
        giphyViewController.dismiss(animated: true, completion: { [weak self] in
            self?.channel?.invokeMethod("onMediaSelect",
                                  arguments: [
                                    "media": media.toDictionary(),
                                    "searchTerm": nil,
                                    "selectedContentType": giphyViewController.selectedContentType.toString()
                                  ])
        })        
    }
    
}
