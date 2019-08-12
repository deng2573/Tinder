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

import FileKit

let netErrorMsg = "网络加载失败,稍后再试...."
let netFailureMsg = "暂无网络,请检查网络状态...."

class WebClient: NSObject {

  static let shared = WebClient()
  
  var uploadRequests: [UploadRequest] = []
  var uploadTasks: [URLSessionUploadTask] = []
  
  private static let manager: SessionManager = initManager()
  
  private static func initManager() -> SessionManager {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForResource = 81809808
    return SessionManager(configuration: configuration)
  }
  
  private static var isReachable: Bool {
    return NetworkReachabilityManager()?.isReachable ?? false
  }
  
  public static func requestJson(method: HTTPMethod = .post, url: String, parameters: [String: Any]? = nil, loading: Bool = false, callback: @escaping(JSON?) -> Void) {
    // 检测网路状态
    if !isReachable { callback(nil); return }
    // Loading
    if loading { HUD.loading() }
    // 请求
    manager.request(url, method: method, parameters: parameters).responseJSON { response in
      HUD.hide()
      guard let result = response.result.value else {
        callback(nil)
        return
      }
      callback(JSON(result))
    }
  }
  

  public static func requestObject<T: NSObject>(method: HTTPMethod = .post, url: String, parameters: [String: Any]? = nil, loading: Bool = false, callback: @escaping (T?) -> Void) where T: EVReflectable {
    requestJson(method: method, url: url, parameters: parameters, loading: loading) { json in
      guard let data = json?.rawString() else {
        return callback(nil)
      }
      let object = T(json: data)
      return callback(object)
    }
  }
  
  public static func requestObjectList<T: NSObject>(method: HTTPMethod = .post, url: String, parameters: [String: Any]? = nil, loading: Bool = false, callback: @escaping ([T]?) -> Void) where T: EVReflectable {
    requestJson(method: method, url: url, parameters: parameters, loading: loading) { json in
      guard let array = json?.arrayValue else {
        return callback(nil)
      }
      let objects = array.map({ json -> T in
      if let data = json.rawString() {
        return T(json: data)
      }
      return T()
      })
      return callback(objects)
    }
  }
  
  public static func upload(path: URL, url: String) {
    let uploadRequest = Alamofire.upload(path, to: url)
    WebClient.shared.uploadRequests.append(uploadRequest)
    NotificationCenter.default.post(Notification(name: .newUploadTask))
    NotificationCenter.default.post(name: .newUploadTask, object: uploadRequest)
  }
  
  public static func upload(data: Data, url: String) {
    let uploadRequest = Alamofire.upload(data, to: url)
    WebClient.shared.uploadRequests.append(uploadRequest)
    NotificationCenter.default.post(name: .newUploadTask, object: uploadRequest)
  }
  
  public static func upload(files: [FileInfo], url: String) {
    Alamofire.upload( multipartFormData: { multipartFormData in
      for file in files {
        if let data = file.data {
           multipartFormData.append(data, withName: "files[]", fileName: "\(file.name).\(file.fileExtension)", mimeType: file.fileExtension.mimeType)
        }
        if let path = file.path {
          let fileManager = FileManager.default
          let data = fileManager.contents(atPath: path)
          multipartFormData.append(data!, withName: "files[]", fileName: "\(file.name).\(file.fileExtension)", mimeType: file.fileExtension.mimeType)
        }
      }
    }, to: url, headers: [:], encodingCompletion: { encodingResult in
      switch encodingResult {
      case .success(let upload, _, _):
        WebClient.shared.uploadRequests.append(upload)
        NotificationCenter.default.post(name: .newUploadTask, object: upload)
      case .failure: break
      }
    })
  }
}
