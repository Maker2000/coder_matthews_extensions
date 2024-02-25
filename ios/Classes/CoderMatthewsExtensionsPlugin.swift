import Flutter
import UIKit
import VisionKit
@available(iOS 13.0, *)
public class CoderMatthewsExtensionsPlugin: NSObject, FlutterPlugin, VNDocumentCameraViewControllerDelegate {
  public static func register(with registrar: FlutterPluginRegistrar) {
      let channel = FlutterMethodChannel(name: "coder_matthews_extensions", binaryMessenger: registrar.messenger())
      let instance = CoderMatthewsExtensionsPlugin()
      // let documentCameraViewController = VNDocumentCameraViewController()
      // documentCameraViewController.delegate = self
      // let scanViewFactory = CameraScanFactoryView(messenger: registrar.messenger())
      // registrar.register(scanViewFactory , withId: "scan_view")
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
