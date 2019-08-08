//
//  Const.swift
//  Tinder
//
//  Created by Deng on 2019/8/8.
//  Copyright © 2019 Deng. All rights reserved.
//

import Foundation
import UIKit

@_exported import Alamofire
@_exported import UITableView_FDTemplateLayoutCell


let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let statusBarHeight = UIApplication.shared.statusBarFrame.height
let navigationHeight = statusBarHeight + CGFloat(44)
let isComprehensiveScreen = navigationHeight == 88


enum FilePath {
  // 存储登录账号密码地址
  struct Account {
    static let userInfo = "UserInfoFile.path"
  }
}

enum AppKey {
  // 高德地图apiKey
  struct ALiPay {
    static let appId = ""
  }
  struct WeChatPay {
    static let appId = ""
  }
}
