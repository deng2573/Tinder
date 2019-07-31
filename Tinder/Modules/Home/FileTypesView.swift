//
//  FileTypesView.swift
//  Tinder
//
//  Created by Deng on 2019/7/31.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

let FileTypeItemWidth = (screenWidth - 32 - 3 * 20) / 4

class FileTypesView: UIView {

  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: FileTypeItemWidth, height: FileTypeItemWidth + 25)
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 20
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.isScrollEnabled = false
    collectionView.delegate = self
    collectionView.dataSource = self
    return collectionView
  }()
  
  private var itemList: [FileType] = []
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpView()
    setUpItemList()
  }

  private func setUpView() {
    addSubview(collectionView)
    collectionView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    collectionView.register(cellType: FileTypeCell.self)
  }
  
  func setUpItemList() {
    let items = ["图片", "视频", "云盘", "本地"]
    for item in items {
      let fileType = FileType(type: item, icon: item.fileIcon)
      itemList.append(fileType)
      collectionView.reloadData()
    }
  }
}

extension FileTypesView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
}

extension FileTypesView: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return itemList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let type = itemList[indexPath.row]
    let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: FileTypeCell.self)
    cell.update(info: type)
    return cell
  }
}


class FileTypeCell: UICollectionViewCell {
  
  private lazy var fileIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 2
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
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpView()
  }
  
  private func setUpView() {
    contentView.addSubview(fileIcon)
    fileIcon.snp.makeConstraints({ (make) in
      make.top.centerX.equalToSuperview()
      make.size.equalTo(CGSize(width: FileTypeItemWidth, height: FileTypeItemWidth))
    })
    
    contentView.addSubview(nameLabel)
    nameLabel.snp.makeConstraints({ (make) in
      make.top.equalTo(fileIcon.snp.bottom).offset(5)
      make.centerX.equalToSuperview()
    })
  }
  
  func update(info: FileType) {
//    fileIcon.image = info.icon
    nameLabel.text = info.type
    fileIcon.backgroundColor = UIColor.randomColor
  }
}