//
//  HomeViewController.swift
//  Tinder
//
//  Created by Deng on 2019/7/29.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

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
  
  private let netManager = NetworkReachabilityManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupHomeView()
    networkMonitoring()
  }
  
  private func setupHomeView() {
    title = "首页"
    view.addSubview(shareLabel)
    shareLabel.snp.makeConstraints({ (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(view.snp.centerY).offset(-60)
      make.size.equalTo(CGSize(width: 100, height: 25))
    })
    
    view.addSubview(shareButton)
    shareButton.snp.makeConstraints({ (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(shareLabel.snp.top).offset(-15)
      make.size.equalTo(CGSize(width: screenWidth * 0.4, height: screenWidth * 0.4))
    })
    
    view.addSubview(receiveButton)
    receiveButton.snp.makeConstraints({ (make) in
      make.centerX.equalToSuperview()
      make.top.equalTo(view.snp.centerY)
      make.size.equalTo(shareButton)
    })
    
    view.addSubview(receiveLabel)
    receiveLabel.snp.makeConstraints({ (make) in
      make.centerX.equalToSuperview()
      make.top.equalTo(receiveButton.snp.bottom).offset(15)
      make.size.equalTo(shareLabel)
    })
    
    let localFileButton = UIButton(type: .custom)
    localFileButton.frame = CGRect(x: 0, y: 0, width: 50, height: 60)
    localFileButton.setTitle("电脑上传", for: .normal)
    localFileButton.setTitleColor(.darkGray, for: .normal)
    localFileButton.layer.cornerRadius = 22
    localFileButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    localFileButton.tap(action: { _ in
      self.pushPCAddressViewController()
    })
    
    let item = UIBarButtonItem(customView: localFileButton)
    navigationItem.rightBarButtonItem = item
  }
  
  private func pushFilePickerViewController() {
    let vc = FilePickerViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  private func pushQRCodeGeneratorController() {
    
    guard let serverUrl = WebServer.shared.uploader.serverURL else {
      HUD.show(text: "当前不再局域网环境中, 请连接WiFi, 稍后重试")
      return
    }
    let url = serverUrl.absoluteString + "upload"
    let vc = QRCodeGeneratorViewController(content: url)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  private func pushPCAddressViewController() {
    let vc = PCAddressViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  private func networkMonitoring() {
    netManager?.listener = { status in
      switch status {
      case .reachable(let type):
        if type == .ethernetOrWiFi {
        } else {
          HUD.show(text: "当前不再局域网环境中, 请连接WiFi启动服务")
        }
      default:
        break
      }
    }
    netManager?.startListening()
  }
}
