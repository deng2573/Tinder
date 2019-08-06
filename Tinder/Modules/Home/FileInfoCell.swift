//
//  FileInformationCell.swift
//  Tinder
//
//  Created by Deng on 2019/7/29.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import FileKit
import TZImagePickerController
import SwipeCellKit

class FileInfoCell: SwipeTableViewCell {

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
  
  lazy var coverImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 5
    return imageView
  }()

  private lazy var playButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(#imageLiteral(resourceName: "video_paly_btn"), for: .normal)
    button.isHidden = true
    button.isUserInteractionEnabled = false
    return button
  }()
  
  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    label.numberOfLines = 1
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
    contentView.addSubview(contentBackgroundView)
    contentBackgroundView.snp.makeConstraints({ (make) in
      make.edges.equalTo(UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16))
    })
    
    contentView.addSubview(coverImageView)
    coverImageView.snp.makeConstraints({ (make) in
      make.centerY.equalToSuperview()
      make.left.equalTo(32)
      make.size.equalTo(CGSize(width: 80, height: 80))
    })
    
    contentView.addSubview(playButton)
    playButton.snp.makeConstraints({ (make) in
      make.center.equalTo(coverImageView)
      make.size.equalTo(CGSize(width: 25, height: 25))
    })
    
    contentView.addSubview(nameLabel)
    nameLabel.snp.makeConstraints({ (make) in
      make.left.equalTo(coverImageView.snp.right).offset(8)
      make.right.equalTo(-32)
      make.bottom.equalTo(coverImageView.snp.centerY).offset(-10)
    })
    
    contentView.addSubview(sizeLable)
    sizeLable.snp.makeConstraints({ (make) in
      make.left.equalTo(nameLabel)
      make.top.equalTo(coverImageView.snp.centerY).offset(10)
    })
  }
  
  func update(path: Path) {
    nameLabel.text = path.fileName
    sizeLable.text = (path.fileSize ?? 0).readableUnit
    
    let pathExtension = path.pathExtension
    
    switch pathExtension.fileType {
    case .image:
      coverImageView.image(url: URL(fileURLWithPath: path.rawValue))
    case .video:
      coverImageView.image(withVideoURL: URL(fileURLWithPath: path.rawValue), placeHolderImage: #imageLiteral(resourceName: "VEDIO"))
    case .excel:
      coverImageView.image = #imageLiteral(resourceName: "EXCEL")
    case .word:
      coverImageView.image = #imageLiteral(resourceName: "WORD")
    case .ppt:
      coverImageView.image = #imageLiteral(resourceName: "PPT")
    case .gif:
      coverImageView.image(url: URL(fileURLWithPath: path.rawValue))
    case .pdf:
      coverImageView.image = #imageLiteral(resourceName: "PDF")
    case .unknown:
      coverImageView.image = #imageLiteral(resourceName: "UNKNOW")
    }
    playButton.isHidden = pathExtension.fileType != .video
  }
  
  func update(file: FileInfo) {
    nameLabel.text = file.name
    sizeLable.text = UInt64((file.data?.count ?? 0)).readableUnit
    
    let pathExtension = file.fileExtension
    let type = pathExtension.fileType
    switch type {
    case .image, .gif, .video:
      let manager = TZImageManager.default()
      if let asset = file.asset {
        manager?.getPhotoWith(asset, completion: { image, info, success in
          self.coverImageView.image = image
        })
      }
    case .excel:
      coverImageView.image = #imageLiteral(resourceName: "EXCEL")
    case .word:
      coverImageView.image = #imageLiteral(resourceName: "WORD")
    case .ppt:
      coverImageView.image = #imageLiteral(resourceName: "PPT")
    case .pdf:
      coverImageView.image = #imageLiteral(resourceName: "PDF")
    case .unknown:
      coverImageView.image = #imageLiteral(resourceName: "UNKNOW")
    }
    playButton.isHidden = pathExtension.fileType != .video
    
    if let path = file.path {
      sizeLable.text = Path(path).fileSize?.readableUnit
      if type == .image || type == .gif {
        coverImageView.image(url: URL(fileURLWithPath:path))
      }
      if type == .video {
        coverImageView.image(withVideoURL: URL(fileURLWithPath: path), placeHolderImage: #imageLiteral(resourceName: "VEDIO"))
      }
    }
  }
}
