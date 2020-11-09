//
//  QRViewController.swift
//  EvaWL
//
//  Created by Gleb Shendrik on 18.09.2020.
//

import UIKit

import AVFoundation


protocol QRView: ViewProtocol {
    
}

class QRViewController: BaseViewController, QRViewProtocol, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var closeButton: UIButton!
    
    var presenter: QRPresenterProtocol?
    
    weak var delegate: ReadQRDelegate?
    
    var isReaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initReader()
    }
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                              AVMetadataObject.ObjectType.code39,
                              AVMetadataObject.ObjectType.code39Mod43,
                              AVMetadataObject.ObjectType.code93,
                              AVMetadataObject.ObjectType.code128,
                              AVMetadataObject.ObjectType.ean8,
                              AVMetadataObject.ObjectType.ean13,
                              AVMetadataObject.ObjectType.aztec,
                              AVMetadataObject.ObjectType.pdf417,
                              AVMetadataObject.ObjectType.qr]
    
    
    @IBAction func cancelTap(_ sender: UIButton) {
        presenter?.didClickCloseButton()
    }
    
}

extension QRViewController {
    
    
    
    func initReader() {
        
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("No devices available")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            let captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            guard let videoPreviewLayer = videoPreviewLayer else { return }
            
            videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            view.layer.addSublayer(videoPreviewLayer)
            
            // Start video capture.
            captureSession.startRunning()
            
            view.bringSubviewToFront(closeButton)
            
            // Move the message label and top bar to the front
            //            view.bringSubview(toFront: topbar)
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubviewToFront(qrCodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate Methods
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        //            if metadataObjects == nil || metadataObjects.isEmpty {
        //                qrCodeFrameView?.frame = CGRect.zero
        ////                print("No QR/barcode is detected")
        //                //            messageLabel.text = "No QR/barcode is detected"
        //                return
        //            }
        
        // Get the metadata object.
        guard metadataObjects.isEmpty == false, metadataObjects[0] is AVMetadataMachineReadableCodeObject else {return}
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if let scan = metadataObj.stringValue,
                !isReaded {
                self.isReaded = true
                let readQR = String(describing: scan)
                if let delegate = delegate {
                
                var qr = ""
                if readQR.contains(":") {
                    qr = readQR.split(separator: ":")[safe: 1]?.split(separator: "?")[safe: 0]?.description ?? ""

                } else {
                    qr = readQR.split(separator: "?")[safe: 0]?.description ?? ""

                }
                    
                let memo = readQR.split(separator: "=")[safe: 1]?.description
                
                delegate.readedString(address: qr, memo: memo)
                    
                presenter?.didReadQRCode()
                    
                }
            }
        }
    }
}

protocol ReadQRDelegate: class {
    
    func readedString(address: String, memo: String?)
}

extension QRViewController: QRView {
    
}
