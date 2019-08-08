//
//  UserInfoManager.swift
//  Tinder
//
//  Created by Deng on 2019/8/8.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class UserInfoManager: NSObject {
  static func readUserInfo() -> UserInfo? {
    let info = UserDefaults.standard.string(forKey: FilePath.Account.userInfo)
    return UserInfo(json: info)
  }
  
  static func writeUserInfo(userInfo: UserInfo?) {
    UserDefaults.standard.set(userInfo?.toJsonString(), forKey:FilePath.Account.userInfo)
  }
}
