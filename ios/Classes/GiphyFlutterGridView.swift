//
//  GiphyFlutterGridView.swift
//  giphy_flutter_sdk
//
//  Created by Alex on 4.3.2024.
//

import Flutter
import UIKit
import GiphyUISDK

public class GiphyFlutterGridView: NSObject, FlutterPlatformView {
    
    private let gridController: GiphyGridController = GiphyGridController()
    
    private var channel: FlutterMethodChannel?
    
    init(frame: CGRect, viewId: Int64, args: Any?, binaryMessenger messenger: FlutterBinaryMessenger) {
        super.init()
        gridController.delegate = self
        setupView(frame: frame)
        createMethodChannel(viewId: viewId, messenger: messenger)
    }
    
    deinit {
        channel?.setMethodCallHandler(nil)
    }
    
    public func view() -> UIView {
        return gridController.view
    }
    
    private func setContent(_ value: [String: Any?]) -> Void {
        let rating = GPHRatingType.fromString(value["rating"] as? String)
        gridController.rating = rating ?? GPHRatingType.ratedPG13
        gridController.content = GPHContent.fromDictionary(value)
        gridController.update()
    }
    
    private func setCellPadding(_ value: CGFloat) -> Void {
        gridController.cellPadding = value
    }
    
    private func setClipsPreviewRenditionType(_ value: String?) -> Void {
        let renditionType = GPHRenditionType.fromString(value)
        gridController.clipsPreviewRenditionType = renditionType ?? .fixedWidth
    }
    
    private func setDisableEmojiVariations(_ value: Bool) -> Void {
        gridController.emojiSettings.disableVariations = value
    }
    
    private func setRenditionType(_ value: String?) -> Void {
        let renditionType = GPHRenditionType.fromString(value)
        gridController.renditionType = renditionType ?? .fixedWidth
    }
    
    private func setOrientation(_ value: String?) -> Void {
        gridController.direction = UICollectionView.ScrollDirection.fromString(value ?? "")
    }
    
    private func setSpanCount(_ value: Int) -> Void {
        gridController.numberOfTracks = value
    }
    
    private func setFixedSizeCells(_ value: Bool) -> Void {
        gridController.fixedSizeCells = value
    }
    
    private func setTheme(_ value: [String: Any?]) -> Void {
        gridController.theme = GiphyFlutterTheme(flutterConfig: value)
    }
    
    private func createMethodChannel(viewId: Int64, messenger: FlutterBinaryMessenger) {
        channel = FlutterMethodChannel(name: "com.giphyfluttersdk/gridView\(viewId)", binaryMessenger: messenger)
        channel?.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard let self = self else {
                result(FlutterError(code: "SELF_NIL", message: "Reference to self is nil", details: nil))
                return
            }
            
            let arguments = call.arguments as? [String: Any?] ?? [:]
            
            switch call.method {
            case "setContent":
                if let value = arguments["content"] as? [String: Any?] {
                    self.setContent(value)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected a map for content", details: nil))
                }
            case "setCellPadding":
                if let value = arguments["cellPadding"] as? CGFloat {
                    self.setCellPadding(value)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected a Float for cellPadding", details: nil))
                }
            case "setDisableEmojiVariations":
                if let value = arguments["disableEmojiVariations"] as? Bool {
                    self.setDisableEmojiVariations(value)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected a Bool for disableEmojiVariations", details: nil))
                }
            case "setFixedSizeCells":
                if let value = arguments["fixedSizeCells"] as? Bool {
                    self.setDisableEmojiVariations(value)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected a Bool for fixedSizeCells", details: nil))
                }
            case "setOrientation":
                if let value = arguments["orientation"] as? String {
                    self.setOrientation(value)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected a String for orientation", details: nil))
                }
            case "setSpanCount":
                if let value = arguments["spanCount"] as? Int {
                    self.setSpanCount(value)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected an Int for orientation", details: nil))
                }
            case "setRenditionType":
                if let value = arguments["renditionType"] as? String {
                    self.setRenditionType(value)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected a String for renditionType", details: nil))
                }
            case "setClipsPreviewRenditionType":
                if let value = arguments["renditionType"] as? String {
                    self.setClipsPreviewRenditionType(value)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected a String for renditionType", details: nil))
                }
            case "setShowCheckeredBackground":
                // To maintain consistency with Android, do not return an error, even though it's not supported.
                result(nil)
            case "setTheme":
                if let value = arguments["theme"] as? [String: Any?] {
                    self.setTheme(value)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Expected a map for theme", details: nil))
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        })
    }
    
    private func setupView(frame: CGRect) -> Void {
        gridController.view.frame = frame
        gridController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

extension GiphyFlutterGridView: GPHGridDelegate {
    public func contentDidUpdate(resultCount: Int, error: (Error)?) {
        channel?.invokeMethod("onContentUpdate", arguments: ["resultCount": resultCount])
    }
    
    public func didSelectMedia(media: GiphyUISDK.GPHMedia, cell: UICollectionViewCell) {
        channel?.invokeMethod("onMediaSelect", arguments: [
            "media": media.toDictionary()
        ])
    }
    
    public func didSelectMoreByYou(query: String) {
        // pass
    }
    
    public func didScroll(offset: CGFloat) {
        channel?.invokeMethod("onScroll", arguments: [
            "offset": offset
        ])
    }
}
