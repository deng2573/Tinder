//
//  UIView+Extension.swift
//  PointWorld_tea
//
//  Created by mac on 2018/4/4.
//  Copyright © 2018年 LPzee. All rights reserved.
//

import UIKit

extension UIView {
  var x: CGFloat {
    set {
      self.frame.origin.x = newValue
    }
    get {
      return self.frame.origin.x
    }
  }
  
  var y: CGFloat {
    set {
      self.frame.origin.y = newValue
    }
    get {
      return self.frame.origin.y
    }
  }
  
  var width: CGFloat {
    set {
      self.frame.size.width = newValue
    }
    get {
      return self.frame.width
    }
  }
  
  var height: CGFloat {
    set {
      self.frame.size.height = newValue
    }
    get {
      return self.frame.height
    }
  }
  
  var size: CGSize {
    get {
      return self.frame.size
    }
  }
}

extension UIView {
  @discardableResult
  func addTapGestureTarget(_ target: AnyObject?, action: Selector) -> UITapGestureRecognizer {
    let tapGesture = UITapGestureRecognizer(target: target, action: action)
    self.isUserInteractionEnabled = true
    addGestureRecognizer(tapGesture)
    return tapGesture
  }
  
  @discardableResult
  func addLongPressGesture(_ target: AnyObject?, action: Selector) -> UILongPressGestureRecognizer {
    let longPress = UILongPressGestureRecognizer(target: target, action: action)
    self.isUserInteractionEnabled = true
    addGestureRecognizer(longPress)
    return longPress
  }
  
  @discardableResult
  func addPanGestureTarget(_ target: AnyObject?, action: Selector) -> UIPanGestureRecognizer {
    let panGesture = UIPanGestureRecognizer(target: target, action: action)
    self.isUserInteractionEnabled = true
    addGestureRecognizer(panGesture)
    return panGesture
  }
}


extension UIView {
  func currentController() -> UIViewController? {
    var next:UIView? = self
    repeat{
      if let nextResponder = next?.next, nextResponder is UIViewController {
        return (nextResponder as! UIViewController)
      }
      next = next?.superview
    }while next != nil
    return nil
  }
}

extension UIView {
  func rotate(duration: CFTimeInterval = 0.7, repeatCount: Float = Float.infinity) {
    //让其在z轴旋转
    let rotationAnimation  = CABasicAnimation(keyPath: "transform.rotation.z")
    //旋转角度
    rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
    //旋转周期
    rotationAnimation.duration = duration;
    //旋转累加角度
    rotationAnimation.isCumulative = true;
    //旋转次数
    rotationAnimation.repeatCount = repeatCount;
    self.layer .add(rotationAnimation, forKey: "rotationAnimation")
  }
  //停止旋转
  func stopRotate() {
    layer.removeAllAnimations()
  }
}
