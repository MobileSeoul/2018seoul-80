//
//  QRcodeTabVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 4..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit
import AVFoundation

class QRcodeTabVC: UIViewController{
  
    let token = UserDefaults.standard.string(forKey: "token")!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    var captureSession = AVCaptureSession()
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.pdf417,
                                      AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.dataMatrix,
                                      AVMetadataObject.ObjectType.interleaved2of5,
                                      AVMetadataObject.ObjectType.qr]
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
        } catch {
            print(error)
            return
        }
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        captureSession.startRunning()
        view.bringSubview(toFront: textLabel)
        view.bringSubview(toFront: cancelBtn)
        
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = #colorLiteral(red: 0.4549019608, green: 0.7254901961, blue: 1, alpha: 1)
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubview(toFront: qrCodeFrameView)
        }
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(dismissNoti), name: NSNotification.Name("dismissNoti") , object: nil)
        
    }
    
    @objc func dismissNoti(noti:Notification) {
        self.dismiss(animated: false)
    }
    
   
    // MARK: - Helper methods
    func launchApp(decodedURL: String) {
        
        if presentedViewController != nil {
            return
        }
        
        guard let id = Int(decodedURL) else {return}
        
        StampStatusService.shareInstance.getStampStatus(token: token, stampId: id, completion: { (stamp) in
            let alertPrompt = UIAlertController(title: "\(stamp.placeName)", message: nil , preferredStyle: .actionSheet)
            let confirmAction = UIAlertAction(title: "상세보기", style: UIAlertActionStyle.default, handler: { (action) -> Void in
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "placeNaviVC") as! placeNaviVC
                vc.id = id
                self.present(vc, animated: true, completion: nil)
            })
            
            let cancelAction = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil)
            
            alertPrompt.addAction(confirmAction)
            alertPrompt.addAction(cancelAction)
            
            self.present(alertPrompt, animated: true, completion: nil)
        }) { (err) in
            
            let message = UIAlertController(title: "알림", message: "네트워크 연결상태를 확인하세요", preferredStyle: .alert)
            let ok = UIAlertAction(title:"확인", style: UIAlertActionStyle.default){
                (UIAlertAction) in
            }
            message.addAction(ok)
            self.present(message, animated: true, completion: nil)
        }
    }
    
}

extension QRcodeTabVC: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                launchApp(decodedURL: metadataObj.stringValue!)
            }
        }
    }
    
}
