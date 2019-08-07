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
  var title = ""
  var value = ""
  var didSelectPushTo: ViewController?
  
  init(cellType: UITableViewCell.Type, title: String = "", value: String = "", didSelectPushTo: ViewController? = nil) {
    self.cellType = cellType
    self.title = title
    self.value = value
    self.didSelectPushTo = didSelectPushTo
  }

}
