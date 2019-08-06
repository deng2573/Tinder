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
  
  public static func upload(file: FileInfo, url: String) {
    if let data = file.data {
      upload(data: data, url: url)
    }
    if let path = file.path {
      upload(path: URL(fileURLWithPath: path), url: url)
    }
  }
  
  public static func upload(files: [FileInfo], url: String, completion: @escaping (Int?) -> Void ) {
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
  
  public static func download(url: String, completion: @escaping (Int?) -> Void ) {
    let url = "http://192.168.1.143:80/download?path=/file.JPG"
//    let parameters = ["path": "/file.JPG"]
    Alamofire.download(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) { (url, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
      let manager = FileManager.default
      let urlForDocument = manager.urls(for: .documentDirectory, in:.userDomainMask)
      let url = urlForDocument[0] as URL
      let folder = url.appendingPathComponent("WebDownload", isDirectory: true)
      
      return (URL(fileURLWithPath: folder.path + "/991.JPG"), [.createIntermediateDirectories, .removePreviousFile])
      }.responseJSON { (response) in
        
        switch response.result {
          
        case .success:
          print("success")
        case .failure: break
          //意外中断后在此处处理下载完成的部分
//         let tmpData = response.resumeData
//          Alamofire.download(resumingWith: tmpData!)
        }
        
    }
    
  }
  
}

//extension Array where Element: Equatable {
//
//  mutating func pw_remove(_ object: Element) -> Bool {
//    if let index = firstIndex(of: object) {
//      self.remove(at: index)
//      return true
//    }
//
//    return false
//  }
//
//}

//extension WebClient {
//  func appendUploadRequest(upload: URLSessionUploadTask)  {
//    uploadTasks.remove(at: uploadTasks.indebo)
//  }
//
//  func removeUploadRequest(upload: URLSessionUploadTask)  {
//
//    upload.task
//    
//    WebClient.manager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downTasks in
//
//    }
//  }
//}






