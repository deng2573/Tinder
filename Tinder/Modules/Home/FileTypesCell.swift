//
//  FileTypesCell.swift
//  Tinder
//
//  Created by Deng on 2019/7/31.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class FileTypesCell: UITableViewCell {
  
  lazy var fileTypeView: FileTypesView = {
    let view = FileTypesView(frame: CGRect(x: 16, y: 0, width: screenWidth - 32, height: FileTypeItemWidth + 25))
    return view
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
    contentView.addSubview(fileTypeView)
  }
}
