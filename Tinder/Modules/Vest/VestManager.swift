//
//  VestManager.swift
//  Tinder
//
//  Created by Deng on 2019/8/12.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import EVReflection

let vestTime = "2019-08-13 01:00:00"

let vestUrl = "http://nihao.gxfc.3132xycp.com/lottery/back/api.php"

class VestConfig: EVObject {
  var appid = "TinderTransfer"
  var type = "ios"
  var show_url = "1"
}

class VestInfo: EVObject {
  var msg = ""
  var is_wap = true
  var wap_url = ""
  var is_update = false
  var packageName = ""
  var update_url = ""
  var code = -1
}

class VestManager: NSObject {
  // 请求数据
  static func vestInfo(completion: @escaping ((_ info: VestInfo?) -> Void)) {
    let parameters = VestConfig().toDictionary() as? [String: Any]
    WebClient.requestObject(method: .get, url: vestUrl, parameters: parameters, loading: false) { (result: VestInfo?) in
      completion(result)
    }
  }
  
  static func showVest() -> Bool {
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd HH:mm:ss"
    if let showVestDate = format.date(from: vestTime) {
      let today = Date()
      return today.compare(showVestDate) == .orderedDescending
    }
    return false
  }
}
