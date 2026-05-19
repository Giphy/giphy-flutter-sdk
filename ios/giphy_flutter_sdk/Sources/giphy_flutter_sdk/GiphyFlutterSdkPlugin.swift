import Flutter
import UIKit
import GiphyUISDK

public class GiphyFlutterSdkPlugin: NSObject, FlutterPlugin {
    
    var giphyDialogHandler: GiphyFlutterDialog?
    var giphyVideoManagerHandler: GiphyFlutterVideoManager?
    private var channel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.giphyfluttersdk", binaryMessenger: registrar.messenger())
        let instance = GiphyFlutterSdkPlugin()
        instance.channel = channel
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        instance.giphyDialogHandler = GiphyFlutterDialog()
        instance.giphyDialogHandler?.onAttachedToEngine(flutterPluginBinding: registrar)
        
        instance.giphyVideoManagerHandler = GiphyFlutterVideoManager()
        instance.giphyVideoManagerHandler?.onAttachedToEngine(flutterPluginBinding: registrar)
        
        let mediaViewFactory = GiphyFlutterMediaViewFactory(messenger: registrar.messenger())
        registrar.register(mediaViewFactory, withId: "com.giphyfluttersdk/mediaView")
        
        let videoViewFactory = GiphyFlutterVideoViewFactory(messenger: registrar.messenger())
        registrar.register(videoViewFactory, withId: "com.giphyfluttersdk/videoView")
        
        let gridViewFactory = GiphyFlutterGridViewFactory(messenger: registrar.messenger())
        registrar.register(gridViewFactory, withId: "com.giphyfluttersdk/gridView")
    }
    
    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        channel?.setMethodCallHandler(nil)
        
        giphyDialogHandler?.onDettachedFromEngine(flutterPluginBinding: registrar)
        giphyDialogHandler = nil
        
        giphyVideoManagerHandler?.onDettachedFromEngine(flutterPluginBinding: registrar)
        giphyVideoManagerHandler = nil
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "configure":
            guard let args = call.arguments as? [String: Any?] else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments received", details: nil))
                return
            }
            
            let apiKey: String = args["apiKey"] as? String ?? ""
            if apiKey.isEmpty {
                result(FlutterError(code: "MISSING_API_KEY", message: "API key is missing", details: nil))
                return
            }
            
            let verificationMode: Bool = args["verificationMode"] as? Bool ?? false
            let videoCacheMaxBytes: Int = args["videoCacheMaxBytes"] as? Int ?? 0
                        
            configureGiphy(apiKey: apiKey, verificationMode: verificationMode, videoCacheMaxBytes: videoCacheMaxBytes)
            
            result(nil)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func configureGiphy(apiKey: String, verificationMode: Bool, videoCacheMaxBytes: Int) {
        let metadata = [GiphyFlutterSdkInfo.shared.name: GiphyFlutterSdkInfo.shared.version ?? ""]
        Giphy.configure(
            apiKey: apiKey as String,
            verificationMode: verificationMode,
            metadata: metadata
        )
    }
}
