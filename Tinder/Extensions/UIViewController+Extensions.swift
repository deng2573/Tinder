//
//  UIViewController+Extensions.swift
//  PointWorld_tea
//
//  Created by mac on 2018/4/7.
//  Copyright © 2018年 LPzee. All rights reserved.
//

import UIKit

extension UIViewController {
  
  open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    self.view.endEditing(true)
  }
  
  // 给Controller 增加返回按钮
  open func setUpDefaultBackButtonItem() {
    let item = UIBarButtonItem(image: #imageLiteral(resourceName: "VEDIO_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backToPrevious))
    navigationItem.leftBarButtonItem = item
  }
  
  @objc func backToPrevious() {
    guard let _ = navigationController?.presentingViewController, navigationController?.viewControllers.count == 1 else {
      navigationController!.popViewController(animated: true)
      return
    }
    dismiss(animated: true, completion: nil)
  }
  
}
