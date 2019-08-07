//
//  MyNormalTableViewCell.swift
//  LeMotion
//
//  Created by Deng on 2019/4/3.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class MyNormalTableViewCell: UITableViewCell {
  
  private lazy var titleLable: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.text = ""
    label.textColor = #colorLiteral(red: 0.6392156863, green: 0.6196078431, blue: 0.6823529412, alpha: 1)
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()
  
  private lazy var valueLable: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = #colorLiteral(red: 0.6392156863, green: 0.6196078431, blue: 0.6823529412, alpha: 1)
    label.font = UIFont.systemFont(ofSize: 15)
    return label
  }()
  
  private lazy var arrowImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "cell_arrow"))
    return imageView
  }()
  
  private lazy var lineView: UIView = {
    let view = UIView()
    
    return view
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    setupView()
  }
  
  func setupView() {
    backgroundColor = UIColor.themeBackgroundColor
    contentView.addSubview(titleLable)
    titleLable.snp.makeConstraints({ (make) in
      make.top.equalToSuperview().offset(20)
      make.left.equalToSuperview().offset(30)
      make.bottom.equalToSuperview().offset(-20)
    })
    
    contentView.addSubview(arrowImageView)
    arrowImageView.snp.makeConstraints({ (make) in
      make.centerY.equalTo(titleLable)
      make.right.equalToSuperview().offset(-10)
      make.size.equalTo(CGSize(width: 20, height: 20))
    })
    
    contentView.addSubview(valueLable)
    valueLable.snp.makeConstraints({ (make) in
      make.centerY.equalTo(titleLable)
      make.right.equalTo(arrowImageView.snp.left).offset(-22)
    })
    
    contentView.addSubview(lineView)
    lineView.snp.makeConstraints({ (make) in
      make.bottom.equalToSuperview()
      make.left.right.equalToSuperview()
      make.height.equalTo(0.5)
    })
  }
  
  func update(title: String, value: String = "") {
    titleLable.text = title
    valueLable.text = value
    if value == "未绑定" {
      valueLable.textColor = #colorLiteral(red: 1, green: 0.7450980392, blue: 0, alpha: 1)
    } else {
      valueLable.textColor = #colorLiteral(red: 0.6392156863, green: 0.6196078431, blue: 0.6823529412, alpha: 1)
    }
  }
}
