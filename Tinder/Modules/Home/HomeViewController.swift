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
    button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    button.layer.cornerRadius = screenWidth * 0.4 / 2
    button.setImage(#imageLiteral(resourceName: "home_up"), for: .normal)
    button.tap(action: { _ in
      self.pushFilePickerViewController()
    })
    return button
  }()
  
  private lazy var shareLabel: UILabel = {
    let label = UILabel()
    label.text = "我要分享"
    label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    label.clipsToBounds = true
    label.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    label.textAlignment = .center
    label.layer.cornerRadius = 5
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }()
  
  private lazy var receiveButton: UIButton = {
    let button = UIButton(type: .custom)
    button.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    button.layer.cornerRadius = screenWidth * 0.4 / 2
    button.setImage(#imageLiteral(resourceName: "home_down"), for: .normal)
    button.tap(action: { _ in
      self.pushQRCodeGeneratorController()
    })
    return button
  }()
  
  private lazy var receiveLabel: UILabel = {
    let label = UILabel()
    label.text = "我要接收"
    label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.clipsToBounds = true
    label.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    label.layer.cornerRadius = 5
    label.textAlignment = .center
    return label
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
  }
  
  private func setUpView() {
    title = "首页"
    view.addSubview(shareButton)
    shareButton.snp.makeConstraints({ (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(view.snp.centerY).offset(-60)
      make.size.equalTo(CGSize(width: screenWidth * 0.4, height: screenWidth * 0.4))
    })
    
    view.addSubview(receiveButton)
    receiveButton.snp.makeConstraints({ (make) in
      make.centerX.equalTo(shareButton)
      make.top.equalTo(view.snp.centerY).offset(10)
      make.size.equalTo(shareButton)
    })
    
    view.addSubview(shareLabel)
    shareLabel.snp.makeConstraints({ (make) in
      make.centerX.equalTo(shareButton)
      make.top.equalTo(shareButton.snp.bottom).offset(10)
      make.size.equalTo(CGSize(width: 100, height: 25))
    })
    
    view.addSubview(receiveLabel)
    receiveLabel.snp.makeConstraints({ (make) in
      make.centerX.equalTo(shareButton)
      make.top.equalTo(receiveButton.snp.bottom).offset(10)
      make.size.equalTo(shareLabel)
    })
    
    let localFileButton = UIButton(type: .custom)
    localFileButton.frame = CGRect(x: 0, y: 0, width: 50, height: 60)
    localFileButton.setTitle("传输列表", for: .normal)
    localFileButton.setTitleColor(.darkGray, for: .normal)
    localFileButton.layer.cornerRadius = 22
    localFileButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    localFileButton.tap(action: { _ in
      self.pushTransferViewController()
    })
    
    let item = UIBarButtonItem(customView: localFileButton)
    navigationItem.rightBarButtonItem = item
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
    let vc = LocalFileViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  private func upload() {
    WebClient.upload(path: URL(fileURLWithPath: "/var/mobile/Containers/Data/Application/F33284FD-52BB-436D-B153-49FE27CA9560/Documents/WebUpload/1.png"), url: "http://192.168.1.143:80/uploadFiles")
  }
}
