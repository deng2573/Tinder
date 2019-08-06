//
//  HomeViewController.swift
//  Tinder
//
//  Created by Deng on 2019/7/29.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import TZImagePickerController
import MMLanScan
import Tiercel
import UICircularProgressRing

class HomeViewController: ViewController {

  private lazy var shareButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("我要分享", for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.6196078431, blue: 1, alpha: 1)
    button.layer.cornerRadius = 22
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    button.tap(action: { _ in
      self.pushFilePickerViewController()
    })
    return button
  }()
  
  private lazy var receiveButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("我要接收", for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.6196078431, blue: 1, alpha: 1)
    button.layer.cornerRadius = 22
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    button.tap(action: { _ in
      self.pushQRCodeGeneratorController()
    })
    return button
  }()
  
  private lazy var progressRing: UICircularProgressRing = {
    let progressRing = UICircularProgressRing(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    progressRing.maxValue = 1
    progressRing.minValue = 0
    progressRing.outerRingWidth = 6
    progressRing.outerRingColor = UIColor.themeColor
    progressRing.innerRingWidth = 3
    progressRing.innerRingColor = #colorLiteral(red: 0.2862745098, green: 0.2784313725, blue: 0.3215686275, alpha: 1)
    
    progressRing.innerRingSpacing = 0
    progressRing.innerCapStyle = .butt
    progressRing.fontColor = .blue
    progressRing.font = UIFont.boldSystemFont(ofSize: 16)

    return progressRing
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
    registerNotification()
  }
  
  private func setUpView() {
    view.addSubview(shareButton)
    shareButton.snp.makeConstraints({ (make) in
      make.left.right.equalTo(view)
      make.top.equalTo(300)
      make.height.equalTo(44)
    })
    
    view.addSubview(receiveButton)
    receiveButton.snp.makeConstraints({ (make) in
      make.left.right.equalTo(view)
      make.top.equalTo(400)
      make.height.equalTo(44)
    })
    
    view.addSubview(progressRing)
    progressRing.snp.makeConstraints({ (make) in
      make.size.equalTo(CGSize(width: screenWidth * 0.3, height: screenWidth * 0.3))
      make.centerX.equalToSuperview()
      make.top.equalTo(20)
    })
    
    let localFileButton = UIButton(type: .custom)
    localFileButton.frame = CGRect(x: 0, y: 0, width: 50, height: 60)
    localFileButton.setTitle("传输列表", for: .normal)
    localFileButton.setTitleColor(.darkGray, for: .normal)
    localFileButton.layer.cornerRadius = 22
    localFileButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    localFileButton.tap(action: { _ in
      self.pushTransferViewController()
    })
    
    let item = UIBarButtonItem(customView: localFileButton)
    navigationItem.rightBarButtonItem = item
  }
  
  private func registerNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(newWebTask(notification:)), name: .newUploadTask, object: nil)
  }
  
  @objc func newWebTask(notification: Notification) {
    let uploadRequest = WebClient.shared.uploadRequests.first!
    uploadRequest.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
      DispatchQueue.main.async(execute: {
        print("文件上传进度: \(progress.fractionCompleted)")
        print("当前网速\(NetSpeed.getByteRate())")
        self.progressRing.value = CGFloat(progress.fractionCompleted)
      })
    }
    
  }
  
  private func pushFilePickerViewController() {
    let vc = FilePickerViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  private func pushQRCodeGeneratorController() {
    let localIP = WebManager.localDevice?.ipAddress
    guard let ip = localIP else {
      return
    }
    let url = #"http://\#(ip):\#(WebServer.shared.uploader.port)/upload"#
    let vc = QRCodeGeneratorViewController(content: url)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  private func pushTransferViewController() {
    let vc = TransferViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
}
