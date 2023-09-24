import Flutter
import UIKit

public class CoderMatthewsExtensionsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "coder_matthews_extensions", binaryMessenger: registrar.messenger())
    let instance = CoderMatthewsExtensionsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "isTablet":
        result(UIDevice.current.userInterfaceIdiom == .pad)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
