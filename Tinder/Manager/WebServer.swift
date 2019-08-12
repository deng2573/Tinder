//
//  WebServer.swift
//  Tinder
//
//  Created by Deng on 2019/7/29.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import GCDWebServer
import FileKit

let WebUploadPathName = "WebUpload"

class WebServer: NSObject {
  static let shared = WebServer()
  
  lazy var uploader: GCDWebUploader = {
    let uploader = GCDWebUploader(uploadDirectory: uploadPath)
    uploader.delegate = self
    uploader.allowHiddenItems = true
    uploader.title = "文件传输"
    uploader.footer = ""
    return uploader
  }()

  lazy var uploadPath: String = {
    let manager = FileManager.default
    let urlForDocument = manager.urls(for: .documentDirectory, in:.userDomainMask)
    let url = urlForDocument[0] as URL
    let folder = url.appendingPathComponent(WebUploadPathName, isDirectory: true)
    let exist = manager.fileExists(atPath: folder.path)
    if !exist {
      try! manager.createDirectory(at: folder, withIntermediateDirectories: true,
                                   attributes: nil)
    }
    return folder.path
  }()
  
  func start() {
    addMatchingHandler()
    addDownloadHandler()
		uploader.start()
    print(uploader.port)
  }

}

extension WebServer {
  func addMatchingHandler() {
    uploader.addHandler(forMethod: "GET", path: "/Matching", request: GCDWebServerMultiPartFormRequest.self) { (request, completionBlock) in
      let contentType = "application/json"
      let result = WebResult(status: 200, msg: "设备匹配成功")
      let response = GCDWebServerDataResponse.init(jsonObject: result.toDictionary(), contentType: contentType)
      completionBlock(response)
    }
  }
  
  func addDownloadHandler() {
    uploader.addHandler(forMethod: "GET", path: "/downloadFiles", request: GCDWebServerMultiPartFormRequest.self) { (request, completionBlock) in
      let relativePath = request.query?["path"] ?? ""
      do {
        let data = try Data.read(from: Path(relativePath))
        let response = GCDWebServerStreamedResponse.init(contentType: "", asyncStreamBlock: { completionBlock in
          completionBlock(data, nil)
        })
        completionBlock(response)
      } catch(let error) {
        print(error)
      }
    }
  }
}

extension WebServer: GCDWebUploaderDelegate {
  func webUploader(_: GCDWebUploader, didUploadFileAtPath path: String) {
    print("[UPLOAD] \(path)")
  }
  
  func webUploader(_: GCDWebUploader, didDownloadFileAtPath path: String) {
    print("[DOWNLOAD] \(path)")
  }
  
  func webUploader(_: GCDWebUploader, didMoveItemFromPath fromPath: String, toPath: String) {
    print("[MOVE] \(fromPath) -> \(toPath)")
  }
  
  func webUploader(_: GCDWebUploader, didCreateDirectoryAtPath path: String) {
    print("[CREATE] \(path)")
  }
  
  func webUploader(_: GCDWebUploader, didDeleteItemAtPath path: String) {
    print("[DELETE] \(path)")
  }
}
