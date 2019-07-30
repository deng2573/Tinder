//
//  PWNetwork.swift
//  PointWorld_tea
//
//  Created by Deng on 2018/4/4.
//  Copyright © 2018年 LPzee. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import EVReflection
import MobileCoreServices

let netErrorMsg = "网络加载失败,稍后再试...."
let netFailureMsg = "暂无网络,请检查网络状态...."

class WebClient: NSObject {
  private static let manager: SessionManager = initManager()
  
  private static func initManager() -> SessionManager {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForResource = 15
    return SessionManager(configuration: configuration)
  }
  
  private static var isReachable: Bool {
    return NetworkReachabilityManager()?.isReachable ?? false
  }
  
  public static func requestJson(method: HTTPMethod = .post, url: String, parameters: [String: Any]? = nil, loading: Bool = false, callback: @escaping(JSON?, String, Int?) -> Void) {
    // 检测网路状态
    if !isReachable { callback(nil, netFailureMsg, nil); return }

    // Loading
    if loading { HUD.loading() }
    // 请求
    manager.request(url, method: method, parameters: parameters).responseJSON { response in
      HUD.hide()
      guard let result = response.result.value else {
        callback(nil, netErrorMsg, nil)
        return
      }
      // 解析数据
      let json = JSON(result)
      let status = json["status"].intValue
      let msg = json["msg"].stringValue
      let data = json["data"]
      // 登录超时
      if status == 406 {
        callback(nil, msg, status)
        return
      }
      // 请求成功
      if status == 200 {
        callback(data, msg, status)
        return
      }
      callback(nil, msg, status)
    }
  }
  

  public static func requestObject<T: NSObject>(method: HTTPMethod = .post, url: String, parameters: [String: Any]? = nil, loading: Bool = false, callback: @escaping (T?, String, Int?) -> Void) where T: EVReflectable {
    requestJson(method: method, url: url, parameters: parameters, loading: loading) { json, msg, status in
      guard let data = json?.rawString() else {
        return callback(nil, msg, status)
      }
      let object = T(json: data)
      return callback(object, msg, status)
    }
  }
  
  public static func requestObjectList<T: NSObject>(method: HTTPMethod = .post, url: String, parameters: [String: Any]? = nil, loading: Bool = false, callback: @escaping ([T]?, String, Bool) -> Void) where T: EVReflectable {
    requestJson(method: method, url: url, parameters: parameters, loading: loading) { json, msg, status in
      guard let array = json?.arrayValue else {
        return callback(nil, msg, true)
      }
      let objects = array.map({ json -> T in
      if let data = json.rawString() {
        return T(json: data)
      }
      return T()
      })
      return callback(objects, msg, status == 401)
    }
  }
  
  public static func upload(files: [FileInfo], completion: @escaping (Int?) -> Void ) {
    Alamofire.upload( multipartFormData: { multipartFormData in
      for (index, file) in files.enumerated() {
        multipartFormData.append(file.data, withName: "files[]", fileName: "file\(index).\(file.type)", mimeType: file.type.mimeType)
      }
    }, to: "http://192.168.1.143:80/uploadFiles", headers: [:], encodingCompletion: { encodingResult in
      switch encodingResult {
      case .success(let upload, _, _):
        upload.responseJSON { response in
          guard let result = response.result.value else {
            completion(nil)
            return
          }
          guard JSON(result)["status"].intValue == 1 else {
            completion(nil)
            return
          }
        }
        //获取上传进度
        upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
          print("文件上传进度: \(progress.fractionCompleted)")
        }
      case .failure:
        completion(nil)
      }
    })
  }
  
}


class FileInfo: EVObject {
  var data: Data
  var type: String // 文件后缀
  
  init(type: String, data: Data) {
    self.type = type
    self.data = data
  }
  
  required init() {
    fatalError("init() has not been implemented")
  }
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
}
