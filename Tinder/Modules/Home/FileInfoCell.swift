//
//  FileInformationCell.swift
//  Tinder
//
//  Created by Deng on 2019/7/29.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import FileKit

class FileInfoCell: UITableViewCell {

  private lazy var coverImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 5
    return imageView
  }()

  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    label.numberOfLines = 0
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  private lazy var sizeLable: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    label.numberOfLines = 0
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    setUpView()
  }
  
  private func setUpView() {
    contentView.addSubview(coverImageView)
    coverImageView.snp.makeConstraints({ (make) in
      make.top.left.equalTo(16)
      make.size.equalTo(CGSize(width: 100, height: 40))
    })
    
    contentView.addSubview(nameLabel)
    nameLabel.snp.makeConstraints({ (make) in
      make.left.equalTo(coverImageView.snp.right).offset(8)
      make.bottom.equalTo(coverImageView.snp.centerY).offset(-5)
    })
    
    contentView.addSubview(sizeLable)
    sizeLable.snp.makeConstraints({ (make) in
      make.left.equalTo(nameLabel)
      make.top.equalTo(coverImageView.snp.centerY).offset(5)
    })
  }
  
  func update(file: Path) {
    nameLabel.text = file.fileName
    sizeLable.text = "\(file.fileSize ?? 0 / 1024 / 1024)"
  }
}
