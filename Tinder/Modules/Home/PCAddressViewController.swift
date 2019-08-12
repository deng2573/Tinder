//
//  PCAddressViewController.swift
//  Tinder
//
//  Created by Deng on 2019/8/9.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class PCAddressViewController: ViewController {
  
  private lazy var wifiImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "home_wifi"))
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 5
    return imageView
  }()
  
  private lazy var tipsLable: UILabel = {
    let label = UILabel()
    label.text = "在电脑浏览器地址输入"
    label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  private lazy var addressLable: UILabel = {
    let label = UILabel()
    label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 18)
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
  }
  
  func setUpView() {
    title = "电脑上传"
    view.addSubview(wifiImageView)
    wifiImageView.snp.makeConstraints({ (make) in
      make.top.equalTo(50)
      make.centerX.equalToSuperview()
      make.size.equalTo(CGSize(width: 100, height: 100))
    })
    
    view.addSubview(tipsLable)
    tipsLable.snp.makeConstraints({ (make) in
      make.top.equalTo(wifiImageView.snp.bottom).offset(70)
      make.left.equalTo(20)
      make.right.equalTo(-20)
    })
    
    view.addSubview(addressLable)
    addressLable.snp.makeConstraints({ (make) in
      make.top.equalTo(tipsLable.snp.bottom).offset(20)
      make.left.equalTo(20)
      make.right.equalTo(-20)
    })
    
    guard let serverUrl = WebServer.shared.uploader.serverURL else {
      HUD.show(text: "当前不再局域网环境中, 请连接WiFi, 稍后重试")
      return
    }
    
    addressLable.text = serverUrl.absoluteString
  }
}
