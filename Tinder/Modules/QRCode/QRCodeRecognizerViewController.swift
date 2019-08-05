//
//  QRCodeRecognizerViewController.swift
//  Tinder
//
//  Created by Deng on 2019/8/4.
//  Copyright © 2019 Deng. All rights reserved.
//

let scanMargin: CGFloat = 35
let scanWidth = screenWidth - scanMargin * 2
let scanHeight = scanWidth

import UIKit
import AVFoundation

class QRCodeRecognizerViewController: ViewController {
  
  var scanSuccess: ((_ value: String) -> ())?
  
  private let scanRect: CGRect = CGRect(x: scanMargin, y: 80, width: scanWidth, height: scanHeight) // 扫描区域
  private let session = AVCaptureSession()
  
  private lazy var scanAreaView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.isUserInteractionEnabled = false
    return view
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    resetAnimatinon()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "扫一扫"
    if (!isCameraAvailable()) {
      HUD.show(text: "当前设备相机不可用,请打开相机权限")
      return
    }
    setUpMaskView()
    setUpScanAreaView()
    setUpToolView()
    scaning()
  }
  
  private func isCameraAvailable() -> Bool{
    let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
    return authStatus != .restricted && authStatus != .denied
  }
  
  /// 整体遮罩设置
  private func setUpMaskView() {
    let maskView = UIView(frame: view.bounds)
    maskView.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9137254902, blue: 0.9490196078, alpha: 0.5034942209)
    view.addSubview(maskView)
    
    let path = UIBezierPath(rect: maskView.bounds)
    path.append(UIBezierPath(rect: scanRect).reversing())
    let shape = CAShapeLayer()
    shape.path = path.cgPath
    maskView.layer.mask = shape
  }
  
  /// 扫描区域设置
  private func setUpScanAreaView() {
    scanAreaView.frame = scanRect
    view.addSubview(scanAreaView)
  }

  fileprivate func setUpToolView() {
    let switchLightButton = UIButton(type: .custom)
    switchLightButton.setImage(UIImage(named: "QRScan_light_off"), for: .normal)
    switchLightButton.setImage(UIImage(named: "QRScan_light_on"), for: .selected)
    view.addSubview(switchLightButton)
    switchLightButton.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.top.equalTo(scanRect.maxY + 20)
      make.size.equalTo(CGSize(width: 50, height: 50))
    }
    switchLightButton.tap(action: { _ in
      switchLightButton.isSelected = !switchLightButton.isSelected
      guard let device = AVCaptureDevice.default(for: AVMediaType.video) else {
        HUD.show(text: "无法获取到您的设备")
        return
      }
      if device.hasTorch && device.isTorchAvailable{
        try? device.lockForConfiguration()
        device.torchMode = device.torchMode == .off ? .on : .off
        device.unlockForConfiguration()
      }
    })
    
    let tipsLabel = UILabel()
    tipsLabel.text = "将二维码图案放入框内,即可自动扫码";
    tipsLabel.textColor = UIColor.white;
    tipsLabel.font = UIFont.systemFont(ofSize: 15);
    tipsLabel.textAlignment = .center;
    view.addSubview(tipsLabel)
    tipsLabel.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.top.equalTo(switchLightButton.snp.bottom).offset(20)
    }
  }
  
  /// 开始扫描
  fileprivate func scaning() {
    //获取摄像设备
    let device = AVCaptureDevice.default(for: AVMediaType.video)
    do {
      //创建输入流
      let input = try AVCaptureDeviceInput.init(device: device!)
      //创建输出流
      let output = AVCaptureMetadataOutput()
      output.rectOfInterest = CGRect(x: 0.1, y: 0, width: 0.9, height: 1)
      //设置代理,在主线程刷新
      output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      //初始化链接对象 / 高质量采集率
      session.canSetSessionPreset(AVCaptureSession.Preset.high)
      session.addInput(input)
      session.addOutput(output)
      //设置扫码支持的编码格式
      output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.ean8, AVMetadataObject.ObjectType.code128]
      
      let layer = AVCaptureVideoPreviewLayer(session: session)
      layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
      layer.frame = view.layer.bounds
      view.layer.insertSublayer(layer, at: 0)
      //开始捕捉
      session.startRunning()
      
    } catch let error as NSError  {
      print("errorInfo\(error.domain)")
    }
  }
  
  ///重置动画
  @objc fileprivate func resetAnimatinon() {
    let scanLineImageView = UIImageView()
    let anim = scanLineImageView.layer.animation(forKey: "translationAnimation")
    if (anim != nil) {
      //将动画的时间偏移量作为暂停时的时间点
      let pauseTime = scanLineImageView.layer.timeOffset
      //根据媒体时间计算出准确的启动时间,对之前暂停动画的时间进行修正
      let beginTime = CACurrentMediaTime() - pauseTime
      ///便宜时间清零
      scanLineImageView.layer.timeOffset = 0.0
      //设置动画开始时间
      scanLineImageView.layer.beginTime = beginTime
      scanLineImageView.layer.speed = 1.1
    } else {
      
      let scanImageViewH = 3
      let scanHeight = view.bounds.width - CGFloat(scanMargin) * 2
      let scanImageViewW = scanAreaView.bounds.width
      
      scanLineImageView.frame = CGRect(x: 0, y: -scanImageViewH, width: Int(scanImageViewW), height: scanImageViewH)
      let scanAnim = CABasicAnimation()
      scanAnim.keyPath = "transform.translation.y"
      scanAnim.byValue = [scanHeight]
      scanAnim.duration = 3
      scanAnim.repeatCount = MAXFLOAT
      scanLineImageView.layer.add(scanAnim, forKey: "translationAnimation")
      scanAreaView.addSubview(scanLineImageView)
    }
  }
}

extension QRCodeRecognizerViewController: AVCaptureMetadataOutputObjectsDelegate {
  func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    
    if metadataObjects.count > 0 {
      session.stopRunning()
      let object = metadataObjects[0]
      let string: String = (object as AnyObject).stringValue
      
      navigationController?.popViewController(animated: true)
      if let scanSuccess = self.scanSuccess {
        scanSuccess(string)
      }
    }
  }
}
