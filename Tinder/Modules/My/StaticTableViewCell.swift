//
//  StaticCell.swift
//  LeMotion
//
//  Created by Deng on 2019/4/3.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class StaticTableViewCell {
  
  var cellType: UITableViewCell.Type = UITableViewCell.self
  var title: String
  var icon: UIImage
  var didSelectPushTo: ViewController
  
  init(cellType: UITableViewCell.Type, title: String = "", icon: UIImage = UIImage(), didSelectPushTo: ViewController) {
    self.cellType = cellType
    self.title = title
    self.icon = icon
    self.didSelectPushTo = didSelectPushTo
  }

}
