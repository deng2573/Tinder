//
//  MainNavigationController.swift
//  PointWorld_tea
//
//  Created by Deng on 2018/4/13.
//  Copyright © 2018年 LPzee. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
  }
  
  func setupView() {
    navigationBar.isTranslucent = false
    navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainSoftwareHighlightTextColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)]
    navigationBar.barTintColor = #colorLiteral(red: 0.1725490196, green: 0.1764705882, blue: 0.1960784314, alpha: 1)
  }
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    if (viewControllers.count > 0) {
      viewController.hidesBottomBarWhenPushed = true
      viewController.setUpDefaultBackButtonItem()
    }
    super.pushViewController(viewController, animated: true)
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
}

