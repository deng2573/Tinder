//
//  BaseViewController.swift
//  LeMotion
//
//  Created by Deng on 2019/3/28.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .mainSoftwareBackgroundColor
    hideNavigationBarShadowLine()
  }
  
  // 隐藏与显示导航条阴影线
  func hideNavigationBarShadowLine() {
    navigationController?.navigationBar.shadowImage = UIImage()
  }
  
  func showNavigationBarShadowLine() {
    navigationController?.navigationBar.shadowImage = nil
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}
