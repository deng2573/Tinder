//
//  HUD.swift
//  LeMotion
//
//  Created by Deng on 2019/4/7.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import MBProgressHUD

class HUD {
  private static var allHUD: [MBProgressHUD] = []
  
  static func show(text: String, view: UIView? = nil) {
    hide(view: view)
    if text.isEmpty { return }
    guard let container = view ?? UIApplication.shared.keyWindow else {
      return
    }
    
    let hud = MBProgressHUD(view: container)
    hud.removeFromSuperViewOnHide = true
    hud.mode = .text
    hud.detailsLabel.text = text
    hud.detailsLabel.font = UIFont.boldSystemFont(ofSize: 15)
    hud.detailsLabel.textColor = #colorLiteral(red: 0.3176470588, green: 0.3176470588, blue: 0.3176470588, alpha: 1)
    container.addSubview(hud)
    allHUD.append(hud)
    hud.show(animated: true)
    hud.hide(animated: true, afterDelay: 3)
  }
  
  static func loading(view: UIView? = nil) {
    hide(view: view)
    guard let container = view ?? UIApplication.shared.keyWindow else {
      return
    }
    
    let hud = MBProgressHUD(view: container)
    hud.removeFromSuperViewOnHide = true
    hud.mode = .customView
    hud.minSize = CGSize(width: 60, height: 60)
    let customView = UIView()
    let loadingImageView = UIImageView(image: #imageLiteral(resourceName: "loading"))
    customView.addSubview(loadingImageView)
    loadingImageView.snp.makeConstraints { make in
      make.size.equalTo(CGSize(width: 45, height: 45))
      make.center.equalToSuperview()
    }
    loadingImageView.rotate()
    hud.customView = customView
    container.addSubview(hud)
    allHUD.append(hud)
    hud.show(animated: true)
  }
  
  static func hide(view: UIView? = nil) {
    allHUD.forEach { hud in
      hud.hide(animated: true)
    }
  }
  
}
