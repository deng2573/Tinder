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

}
