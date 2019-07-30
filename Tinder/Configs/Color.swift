//
//  Colors.swift
//  LeMotion
//
//  Created by Deng on 2019/3/29.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

extension UIColor {
  static let mainSoftwareBackgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1490196078, blue: 0.1568627451, alpha: 1)
  static let mainSoftwareNormalBackgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1490196078, blue: 0.1568627451, alpha: 1)
  static let mainSoftwareNormalTextColor = #colorLiteral(red: 0.1450980392, green: 0.1490196078, blue: 0.1568627451, alpha: 1)
  static let mainSoftwareHighlightTextColor = #colorLiteral(red: 1, green: 0.7450980392, blue: 0, alpha: 1)
}
// 主页
extension UIColor {
  static let homeBackgroundColor = #colorLiteral(red: 0.2862745098, green: 0.2784313725, blue: 0.3215686275, alpha: 1)
}

extension UIImage {
  static let homeTabBarbackgroundImage = UIColor.homeBackgroundColor.image
  static let normalTabBarbackgroundImage = UIColor.mainSoftwareBackgroundColor.image
}
