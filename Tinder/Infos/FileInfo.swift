//
//  FileInfo.swift
//  Tinder
//
//  Created by Deng on 2019/7/31.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import Photos
import EVReflection
import MobileCoreServices

enum FilePickerType {
  case image
  case video
  case cloud
  case local
  
  var icon: UIImage {
    switch self {
    case .image:
      return #imageLiteral(resourceName: "icon_pic")
    case .video:
      return #imageLiteral(resourceName: "icon_video")
    case .cloud:
      return #imageLiteral(resourceName: "icon_cloud")
    case .local:
      return #imageLiteral(resourceName: "icon_file")
    }
  }
  
  var name: String {
    switch self {
    case .image:
      return "图片"
    case .video:
      return "视频"
    case .cloud:
      return "云盘"
    case .local:
      return "本地"
    }
  }
}

extension String {

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


enum FileType {
  case image
  case video
  case excel
  case word
  case ppt
  case gif
  case pdf
  case unknown
}

extension String {
  var mimeType: String {
    if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                       self as NSString,
                                                       nil)?.takeRetainedValue() {
      if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?
        .takeRetainedValue() {
        return mimetype as String
      }
    }
    //文件资源类型如果不知道，传万能类型application/octet-stream，服务器会自动解析文件类
    return "application/octet-stream"
  }
  
  var fileType: FileType {
    if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                       self as CFString,
                                                       nil)?.takeRetainedValue() {
      if UTTypeConformsTo(uti, kUTTypeImage) {
        return .image
      }
      if UTTypeConformsTo(uti, kUTTypeGIF) {
        return .gif
      }
      if UTTypeConformsTo(uti, kUTTypeVideo) || UTTypeConformsTo(uti, kUTTypeMovie) {
        return .video
      }
      if UTTypeConformsTo(uti, kUTTypePDF) {
        return .pdf
      }
      if self == "pptx" || self == "ppt" {
        return .ppt
      }
      if self == "xls" || self == "xlsx" {
        return .excel
      }
      if self == "doc" || self == "docx" {
        return .word
      }
    }
    //文件资源类型如果不知道，传万能类型application/octet-stream，服务器会自动解析文件类
    return .unknown
  }
}

extension UInt64 {
  public var kilobytes: Double {
    return Double(self) / 1_000
  }
  
  public var megabytes: Double {
    return kilobytes / 1_000
  }
  
  public var gigabytes: Double {
    return megabytes / 1_000
  }
  
  public var readableUnit: String {
    switch self {
    case 0..<1_000:
      return "\(self) B"
    case 1_000..<(1_000 * 1_000):
      return "\(Int(kilobytes)) K"
    case 1_000..<(1_000 * 1_000 * 1_000):
      return "\(String(format: "%.1f", megabytes)) M"
    case (1_000 * 1_000 * 1_000)...UInt64.max:
      return "\(String(format: "%.2f", gigabytes)) G"
    default:
      return "\(self) B"
    }
  }
}

class FileInfo: EVObject {
  var name: String
  var fileExtension: String // 文件后缀
  var data: Data?
  var path: String? // 文件本地路径
  var asset: PHAsset? // 本地资源
  
  init(name: String, data: Data? = nil, path: String? = nil, fileExtension: String, asset: PHAsset? = nil) {
    self.name = name
    self.data = data
    self.path = path
    self.fileExtension = fileExtension
    self.asset = asset
  }
  
  required init() {
    fatalError("init() has not been implemented")
  }
}
