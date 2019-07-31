//
//  UISearchBar+Extensions.swift
//  Tinder
//
//  Created by Deng on 2019/7/31.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

extension UISearchBar {
  func setCancleBtn()  {
    for view in self.subviews {
      if let _cls = NSClassFromString("UINavigationButton") {
        if view.isKind(of: _cls) {
          guard let btn = view as? UIButton else { return }
          btn.setTitle("取消", for: .normal)
          btn.setTitleColor(UIColor.red, for: .normal)
          return
        }
      }
    }
  }
}
