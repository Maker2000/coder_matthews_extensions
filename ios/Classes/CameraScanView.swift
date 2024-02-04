//
//  CameraScanView.swift
//  coder_matthews_extensions
//
//  Created by Terrence Matthews on 30/11/2023.
//

import Foundation
import Flutter
import VisionKit

@available(iOS 13.0, *)
class CameraScanFactoryView: NSObject, FlutterPlatformViewFactory{
    private var messenger: FlutterBinaryMessenger
    private var scanController: VNDocumentCameraViewController
    init(messenger: FlutterBinaryMessenger, scanController: VNDocumentCameraViewController) {
        self.messenger = messenger
        self.scanController = scanController
        super.init()
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return CameraScanView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger,
            scanController: scanController
         )
    }
    
    
}

@available(iOS 13.0, *)
class CameraScanView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var scanController: VNDocumentCameraViewController
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?,
        scanController: VNDocumentCameraViewController
    ) {
        _view = UIView()
        self.scanController = scanController
        super.init()
        createNativeView(view: _view)
    }
    func view() -> UIView {
        return _view
    }
    func createNativeView(view _view: UIView){
        _view.backgroundColor = UIColor.blue
        let nativeLabel = UILabel()
        nativeLabel.text = "Native text from iOS"
        nativeLabel.textColor = UIColor.white
        nativeLabel.textAlignment = .center
        nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)
        
        _view.addSubview(scanController.view)
        
    }
    
}
