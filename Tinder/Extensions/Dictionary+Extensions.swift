//
//  Dictionary+Extensions.swift
//  LeMotion
//
//  Created by Deng on 2019/4/10.
//  Copyright © 2019 Deng. All rights reserved.
//

import Foundation

extension Dictionary {
  mutating func merge<S>(_ other: S?)
    where S: Sequence, S.Iterator.Element == (key: Key, value: Value){
      guard let dictionary = other else {
        return
      }
      for (k ,v) in dictionary {
        self[k] = v
      }
  }
}
