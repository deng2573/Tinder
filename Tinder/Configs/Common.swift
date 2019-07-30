//
//  Common.swift
//  LeMotion
//
//  Created by Deng on 2019/3/31.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

// 屏幕适应
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let statusBarHeight = UIApplication.shared.statusBarFrame.height
let navigationHeight = statusBarHeight + CGFloat(44)
let isComprehensiveScreen = navigationHeight == 88

var version: String {
  return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
}

enum FilePath {
  // 存储登录账号密码地址
  struct loginPath {
    static let userInfo = "loginuserInfoFile.path"
  }
}

enum AppKey {
  // 高德地图apiKey
  struct ALiPay {
    static let appId = "201712310809"
  }
  struct WeChatPay {
    static let appId = "wxb83a5356c64aa96a"
  }
}
