//
//  MyNormalTableViewCell.swift
//  LeMotion
//
//  Created by Deng on 2019/4/3.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class MyNormalTableViewCell: UITableViewCell {
  
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
  
  private lazy var titleLable: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.text = ""
    label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    label.font = UIFont.boldSystemFont(ofSize: 15)
    return label
  }()
  
  private lazy var iconImageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
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
    
    contentView.addSubview(contentBackgroundView)
    contentBackgroundView.snp.makeConstraints({ (make) in
      make.edges.equalTo(UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8))
    })
    
    contentView.addSubview(titleLable)
    titleLable.snp.makeConstraints({ (make) in
      make.top.equalToSuperview().offset(20)
      make.left.equalToSuperview().offset(25)
      make.bottom.equalToSuperview().offset(-20)
    })
    
    contentView.addSubview(arrowImageView)
    arrowImageView.snp.makeConstraints({ (make) in
      make.centerY.equalTo(titleLable)
      make.right.equalToSuperview().offset(-20)
      make.size.equalTo(CGSize(width: 20, height: 20))
    })
    
    contentView.addSubview(lineView)
    lineView.snp.makeConstraints({ (make) in
      make.bottom.equalToSuperview()
      make.left.right.equalToSuperview()
      make.height.equalTo(0.5)
    })
  }
  
  func update(title: String) {
    titleLable.text = title
  }
}
