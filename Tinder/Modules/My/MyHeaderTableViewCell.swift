//
//  MyHeaderTabViewCell.swift
//  LeMotion
//
//  Created by Deng on 2019/4/3.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class MyHeaderTableViewCell: UITableViewCell {

  private lazy var contentBackgroundView: UIView = {
    let view = UIView(frame: .zero)
    view.backgroundColor = .white
    view.layer.shadowColor = UIColor.lightGray.cgColor
    view.layer.borderColor = view.layer.shadowColor
    view.layer.borderWidth = 0.01
    view.layer.cornerRadius = 5
    view.layer.shadowOpacity = 0.2
    view.layer.shadowRadius = 5
    view.layer.shadowOffset = .zero
    return view
  }()
  
  private lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "avatar"))
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 35
    return imageView
  }()
  
  private lazy var nameLable: UILabel = {
    let label = UILabel()
    label.text = "未设置"
    label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    label.font = UIFont.boldSystemFont(ofSize: 18)
    return label
  }()
  
  private lazy var accountLable: UILabel = {
    let label = UILabel()
    label.text = "ID:  TF0001"
    label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()

  private lazy var arrowImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "cell_arrow"))
    return imageView
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    setUpView()
  }
  
  func setUpView() {
    backgroundColor = UIColor.themeBackgroundColor
    
    contentView.addSubview(contentBackgroundView)
    contentBackgroundView.snp.makeConstraints({ (make) in
      make.edges.equalTo(UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8))
    })
    
    contentView.addSubview(avatarImageView)
    avatarImageView.snp.makeConstraints({ (make) in
      make.centerY.equalToSuperview()
      make.left.equalTo(25)
      make.size.equalTo(CGSize(width: 70, height: 70))
    })
    
    contentView.addSubview(nameLable)
    nameLable.snp.makeConstraints({ (make) in
      make.top.equalTo(avatarImageView).offset(6)
      make.left.equalTo(avatarImageView.snp.right).offset(10)
    })
    
    contentView.addSubview(accountLable)
    accountLable.snp.makeConstraints({ (make) in
      make.bottom.equalTo(avatarImageView).offset(-6)
      make.left.equalTo(nameLable)
    })
    
    contentView.addSubview(arrowImageView)
    arrowImageView.snp.makeConstraints({ (make) in
      make.centerY.equalTo(accountLable)
      make.right.equalToSuperview().offset(-20)
      make.size.equalTo(CGSize(width: 20, height: 20))
    })
  }
  
  func update() {
    if let userInfo = UserInfoManager.readUserInfo() {
      nameLable.text = userInfo.nickName.isEmpty ? "未设置" : userInfo.nickName
      if !userInfo.avatar.isEmpty, let avatarData = Data(base64Encoded: userInfo.avatar) {
        avatarImageView.image = UIImage(data: avatarData)
      }
    }
  }
}








