//
//  String+Extensions.swift
//  LeMotion
//
//  Created by Deng on 2019/4/12.
//  Copyright © 2019 Deng. All rights reserved.
//

import Foundation

extension String {
  mutating func phoneSecurity() -> String {
    var mobile = self
    if mobile.count >= 11 {
      mobile.replaceSubrange(mobile.index(mobile.startIndex, offsetBy: 3)..<mobile.index(mobile.startIndex, offsetBy: 7), with: "****")
    }
    return mobile
  }
}

