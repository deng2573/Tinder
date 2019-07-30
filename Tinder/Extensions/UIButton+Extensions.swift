//
//  UIButton+Extensions.swift
//  PointWorld_tea
//
//  Created by Deng on 2018/4/9.
//  Copyright © 2018年 LPzee. All rights reserved.
//

import UIKit
import Kingfisher

extension UIButton {
  func tap(for controlEvents: UIControl.Event = .touchUpInside, action:@escaping (UIButton)->()) {
    let eventObj = AssociatedClosureClass(eventClosure: action)
    eventClosureObj = eventObj
    addTarget(self, action: #selector(eventExcuate(_:)), for: controlEvents)
  }
  
  struct AssociatedClosureClass {
    var eventClosure: (UIButton)->()
  }
  
  private struct AssociatedKeys {
    static var eventClosureObj:AssociatedClosureClass?
  }
  
  private var eventClosureObj: AssociatedClosureClass{
    set{
      objc_setAssociatedObject(self, &AssociatedKeys.eventClosureObj, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      
    }
    get{
      return (objc_getAssociatedObject(self, &AssociatedKeys.eventClosureObj) as? AssociatedClosureClass)!
    }
  }

  @objc private func eventExcuate(_ sender: UIButton){
    eventClosureObj.eventClosure(sender)
  }
  
}

extension UIButton {
  enum ButtonImageEdgeInsetsStyle {
    case top    //上图下文字
    case left   //左图右文字
    case bottom //下图上文字
    case right  //右图左文字
  }
  // style:图片位置 space:图片与文字的距离
  func layoutButtonImageEdgeInsetsStyle(style: ButtonImageEdgeInsetsStyle, space: CGFloat) {
    let imageWidth: CGFloat = (self.imageView?.frame.size.width)!
    let imageHeight: CGFloat = (self.imageView?.frame.size.height)!
    
    var labelWidth: CGFloat = 0
    var labelHeight: CGFloat = 0
    
    labelWidth = (self.titleLabel?.intrinsicContentSize.width)!
    labelHeight = (self.titleLabel?.intrinsicContentSize.height)!
    
    var imageEdgeInsets:UIEdgeInsets = UIEdgeInsets.zero
    var labelEdgeInsets:UIEdgeInsets = UIEdgeInsets.zero
    
    switch style {
    case .top:
      imageEdgeInsets = UIEdgeInsets(top: -labelHeight-space/2.0, left: 0, bottom: 0, right: -labelWidth)
      labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight-space/2.0, right: 0)
    case .left:
      imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0)
      labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0)
    case .bottom:
      imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight-space/2.0, right: -labelWidth)
      labelEdgeInsets = UIEdgeInsets(top: -imageHeight-space/2.0, left: -imageWidth, bottom: 0, right: 0)
    case .right:
      imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+space/2.0, bottom: 0, right: -labelWidth-space/2.0)
      labelEdgeInsets = UIEdgeInsets(top: 0, left: -labelWidth-space/2.0, bottom: 0, right: labelWidth+space/2.0)
    }
    
    self.titleEdgeInsets = labelEdgeInsets
    self.imageEdgeInsets = imageEdgeInsets
  }
  
  func image(url: String, placeholder: UIImage? = nil) {
//    sd_setImage(with: URL(string: NetURL.site + url), for: .normal, placeholderImage: placeholder, options: .retryFailed, completed: nil)
  }
}
