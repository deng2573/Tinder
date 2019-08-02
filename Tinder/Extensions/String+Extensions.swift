//
//  String+Extensions.swift
//  LeMotion
//
//  Created by Deng on 2019/4/12.
//  Copyright © 2019 Deng. All rights reserved.
//

import Foundation

extension String {
  func substring(before string: String) -> String? {
    guard let range = self.range(of: string) else { return nil }
    return String(self[..<range.lowerBound])
  }
  
  func substring(after string: String) -> String? {
    guard let range = self.range(of: string) else { return nil }
    return String(self[range.upperBound...])
  }
  
  mutating func phoneSecurity() -> String {
    var mobile = self
    if mobile.count >= 11 {
      mobile.replaceSubrange(mobile.index(mobile.startIndex, offsetBy: 3)..<mobile.index(mobile.startIndex, offsetBy: 7), with: "****")
    }
    return mobile
  }
}

