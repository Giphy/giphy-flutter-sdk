//
//  GiphyFlutterVideoViewFactory.swift
//  giphy_flutter_sdk
//
//  Created by Alex on 25.3.2024.
//

import Flutter
import UIKit

public class GiphyFlutterVideoViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    
    public init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return GiphyFlutterVideoView(frame: frame, viewId: viewId, args: args, binaryMessenger: messenger)
    }
}
