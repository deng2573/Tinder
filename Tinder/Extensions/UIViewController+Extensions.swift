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
    let backButton = UIButton(type: .custom)
    backButton.frame = CGRect(x: 0, y: 0, width: 22, height: 40)
    backButton.setImage(#imageLiteral(resourceName: "nav_back"), for: .normal)
    backButton.tap(action: { _ in
      self.backToPrevious()
    })
    let item = UIBarButtonItem(customView: backButton)
    navigationItem.leftBarButtonItem = item
  }
  
  private func backToPrevious() {
    guard let _ = navigationController?.presentingViewController, navigationController?.viewControllers.count == 1 else {
      navigationController!.popViewController(animated: true)
      return
    }
    dismiss(animated: true, completion: nil)
  }
  
  func showEmptyPrompt(show: Bool, prompt: String = "暂无数据", topOffset: CGFloat = 0) {
    var emptyView = view.viewWithTag(9990)
    
    if !show {
      emptyView?.removeFromSuperview()
      return
    }
    
    if emptyView != nil, show {
      return
    }
    
    if emptyView == nil, show {
      emptyView = UIView()
      emptyView?.backgroundColor = UIColor.themeBackgroundColor
      emptyView?.tag = 9990
      view.addSubview(emptyView!)
      emptyView?.frame = CGRect(x: 0, y: topOffset, width: view.width, height: view.height - topOffset - 100)
    }
    
    let promptL = UILabel()
    promptL.text = prompt
    promptL.textAlignment = .center
    promptL.font = UIFont.boldSystemFont(ofSize: 16)
    promptL.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    promptL.numberOfLines = 0
    emptyView?.addSubview(promptL)
    promptL.snp.makeConstraints({ (make) in
      make.center.equalTo(emptyView!)
    })
  }
}

