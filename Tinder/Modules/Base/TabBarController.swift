//
//  MainTabBarControllerViewController.swift
//  PointWorld_tea
//
//  Created by mac on 2018/4/4.
//  Copyright © 2018年 LPzee. All rights reserved.
//

import UIKit

enum TabTitle: String {
  case home = "首页"
  case shopping = "商城"
  case news = "乐闻"
  case my   = "我的"
}

class TabBarController: UITabBarController {
  
  private var itemTitles: [TabTitle] = []
  private var itemImages: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainTabBar()
  }
  
  func setupMainTabBar() {
    var viewControllers = [UIViewController]()
    viewControllers.append(NavigationController(rootViewController: HomeViewController()))
    
    itemTitles.append(.home)
    itemTitles.append(.shopping)
    itemTitles.append(.news)
    itemTitles.append(.my)
    
    itemImages.append("tab_home")
    itemImages.append("tab_shopping")
    itemImages.append("tab_news")
    itemImages.append("tab_my")
    
    let itemSelectedImages = itemImages.map({title in
      "\(title)_selected"
    })
    
    for i in 0..<itemTitles.count {
      let itemViewController = viewControllers[i]
      itemViewController.tabBarItem = UITabBarItem(title: itemTitles[i].rawValue,
                                                   image: UIImage(named: itemImages[i])?.withRenderingMode(.alwaysOriginal),
                                                   selectedImage: UIImage(named: itemSelectedImages[i])?.withRenderingMode(.alwaysOriginal))
      itemViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9450980392, green: 0.8588235294, blue: 0.01176470588, alpha: 1)], for: .selected)
      
      itemViewController.tabBarItem.tag = i
    }
    
    setViewControllers(viewControllers, animated: false)
    tabBar.backgroundImage = UIImage.homeTabBarbackgroundImage
    tabBar.clipsToBounds = true
  }
 
}

extension TabBarController: UITabBarControllerDelegate {
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    tabBar.backgroundImage = item.tag == 0 ?  UIImage.homeTabBarbackgroundImage : UIImage.normalTabBarbackgroundImage
  }
}
