import Flutter
import UIKit
import GiphyUISDK

public class GiphyFlutterSdkPlugin: NSObject, FlutterPlugin {
    
    var giphyDialogHandler: GiphyFlutterDialog?
    private var channel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.giphyfluttersdk", binaryMessenger: registrar.messenger())
        let instance = GiphyFlutterSdkPlugin()
        instance.channel = channel
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        instance.giphyDialogHandler = GiphyFlutterDialog()
        instance.giphyDialogHandler?.onAttachedToEngine(flutterPluginBinding: registrar)
    }
    
    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        channel?.setMethodCallHandler(nil)
        giphyDialogHandler?.onDettachedFromEngine(flutterPluginBinding: registrar)
        giphyDialogHandler = nil
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "configure":
            guard let args = call.arguments as? [String: Any] else {
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
