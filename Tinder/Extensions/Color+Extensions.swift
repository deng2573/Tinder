//
//  UIColor.swift
//  PointWorld_tea
//
//  Created by mac on 2018/4/4.
//  Copyright © 2018年 LPzee. All rights reserved.
//

import UIKit

extension UIColor {
  
  convenience init(hex: UInt64, alpha: CGFloat = 1) {
    
    let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
    let blue = CGFloat((hex & 0x0000FF)) / 255.0
    
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
  
  class var randomColor: UIColor {
    
    let hue = CGFloat(arc4random() % 256) / 256.0
    let saturation = CGFloat(arc4random() % 128) / 256.0 + 0.5
    let brightness : CGFloat = CGFloat(arc4random() % 128) / 256.0 + 0.5
    
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
  }
  
  var image: UIImage {
    let theColor = self
    let rect = CGRect(x: 0, y: 0, width: 200, height: 50)
    UIGraphicsBeginImageContext(rect.size)
    let context : CGContext? = UIGraphicsGetCurrentContext()
    context!.setFillColor(theColor.cgColor)
    context!.fill(rect)
    let targetImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return targetImage!
  }
}

