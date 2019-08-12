//
//  AppConfig.swift
//  LeMotion
//
//  Created by Deng on 2019/6/17.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

struct AppConfig {

  static var isDebug: Bool {
    var status: Bool
    #if DEBUG
    status = true
    #else
    status = false
    #endif
    return status
  }

  static var version: String {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
  }
}

extension UIFont {
  static func themeFont(size: CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
  }
}

enum FilePath {
  // 存储登录账号密码地址
  struct Account {
    static let userInfo = "UserInfoFile.path"
  }
}

enum AppKey {
  // 极光
  struct JPushAPP {
    static let key = "65291c20cdb37550ee0d61f8"
  }
}
