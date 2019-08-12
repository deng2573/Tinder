//
//  AboutAppViewController.swift
//  Tinder
//
//  Created by Deng on 2019/8/8.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class AboutAppViewController: ViewController {
  
  private lazy var logoImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "Logo"))
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 5
    return imageView
  }()
  
  private lazy var nameLable: UILabel = {
    let label = UILabel()
    label.text = "文件互传"
    label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 18)
    return label
  }()
  
  private lazy var versionLable: UILabel = {
    let label = UILabel()
    label.text = "v \(AppConfig.version)"
    label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  private lazy var qqLable: UILabel = {
    let label = UILabel()
    label.text = "QQ:  231151989809088"
    label.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 15)
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
  }
  
  func setUpView() {
    title = "关于"
    view.addSubview(logoImageView)
    logoImageView.snp.makeConstraints({ (make) in
      make.top.equalTo(10)
      make.centerX.equalToSuperview()
      make.size.equalTo(CGSize(width: 100, height: 100))
    })
    
    view.addSubview(nameLable)
    nameLable.snp.makeConstraints({ (make) in
      make.top.equalTo(logoImageView.snp.bottom).offset(50)
      make.left.equalTo(20)
      make.right.equalTo(-20)
    })
    
    view.addSubview(versionLable)
    versionLable.snp.makeConstraints({ (make) in
      make.top.equalTo(nameLable.snp.bottom).offset(15)
      make.left.equalTo(20)
      make.right.equalTo(-20)
    })
    
    view.addSubview(qqLable)
    qqLable.snp.makeConstraints({ (make) in
      make.bottom.equalTo(-30)
      make.left.equalTo(20)
      make.right.equalTo(-20)
    })
  }
}
