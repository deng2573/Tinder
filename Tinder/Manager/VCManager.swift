//
//  VCManager.swift
//  LeMotion
//
//  Created by Deng on 2019/6/10.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class VCManager: NSObject {
  static var currentViewController: UIViewController {
    return VCManager.getCurrentViewController(UIApplication.shared.keyWindow!.rootViewController!)
  }
  
  class func getCurrentViewController(_ viewController: UIViewController) -> UIViewController {
    if let viewController = viewController.presentedViewController {
      return getCurrentViewController(viewController)
    }
    if let viewController = viewController as? UINavigationController,
      viewController.viewControllers.count > 0 {
      return getCurrentViewController(viewController.topViewController!)
    }
    if let viewController = viewController as? UITabBarController,
      viewController.viewControllers!.count > 0 {
      return getCurrentViewController(viewController.selectedViewController!)
    }
    return viewController
  }
}

extension VCManager {
//  static func setUpTabBarRootController() {
//    UIApplication.shared.delegate?.window??.rootViewController = AppConfig.isExamineAccount ? ExamineTabBarController() : TabBarController()
//  }
}
