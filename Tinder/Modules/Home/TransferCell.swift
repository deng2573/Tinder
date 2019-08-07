//
//  TransferCell.swift
//  Tinder
//
//  Created by Deng on 2019/8/5.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import Alamofire

class TransferCell: UITableViewCell {
  
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
  
  private lazy var transProgressView: UIProgressView = {
    let progressview = UIProgressView(frame: .zero)
    progressview.clipsToBounds = true
    progressview.progressViewStyle = .bar
    progressview.progressTintColor = #colorLiteral(red: 0.1019607843, green: 0.5490196078, blue: 0.8549019608, alpha: 1)
    progressview.trackTintColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
    progressview.layer.cornerRadius = 2
    return progressview
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
    
    contentView.addSubview(transProgressView)
    transProgressView.snp.makeConstraints({ (make) in
      make.left.equalTo(nameLabel)
      make.right.equalTo(-20)
      make.top.equalTo(coverImageView.snp.centerY).offset(5)
      make.height.equalTo(5)
    })
  }
  
  func update(upload: UploadRequest) {
    nameLabel.text = "文件"
    transProgressView.setProgress(Float(upload.progress.fractionCompleted), animated: false)
    upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
      DispatchQueue.main.async(execute: {
        self.transProgressView.setProgress(Float(progress.fractionCompleted), animated: false)
      })
    }
  }
}
