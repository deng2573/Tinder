//
//  Int+Extensions.swift
//  LeMotion
//
//  Created by Deng on 2019/4/12.
//  Copyright © 2019 Deng. All rights reserved.
//

import Foundation

extension Int {
  var data: Data {
    var int = self
    return Data(bytes: &int, count: MemoryLayout<Int>.size)
  }
}
