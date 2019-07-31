//
//  WebResult.swift
//  Tinder
//
//  Created by Deng on 2019/7/31.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import EVReflection

class WebResult: EVObject {
  var status: Int
  var msg: String
  var data: String?
  
  init(status: Int, msg: String, data: String? = nil) {
    self.status = status
    self.msg = msg
    self.data = data
  }
  
  required init() {
    fatalError("init() has not been implemented")
  }
}
