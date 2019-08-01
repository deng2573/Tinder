//
//  FileInfo.swift
//  Tinder
//
//  Created by Deng on 2019/7/31.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

//class FilePickerInfo: NSObject {
//  var type: FilePickerType
//
//  required override init() {
//    fatalError("init() has not been implemented")
//  }
//  
//  init(type: FilePickerType, icon: UIImage) {
//    self.type = FilePickerType
//    self.icon = icon
//  }
//  
//}

extension String {
//  ["图片", "视频", "云盘", "本地"]
  var fileIcon: UIImage {
    if self == "图片" {
      return #imageLiteral(resourceName: "VEDIO_icon")
    }
    if self == "视频" {
      return #imageLiteral(resourceName: "VEDIO_icon")
    }
    if self == "云盘" {
      return #imageLiteral(resourceName: "VEDIO_icon")
    }
    if self == "本地" {
      return #imageLiteral(resourceName: "VEDIO_icon")
    }
    return #imageLiteral(resourceName: "VEDIO_icon")
  }
}
