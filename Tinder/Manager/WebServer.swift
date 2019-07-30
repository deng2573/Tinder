//
//  WebServer.swift
//  Tinder
//
//  Created by Deng on 2019/7/29.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import GCDWebServer

let WebUploadPathName = "WebUpload"

class WebServer: NSObject {
  static let shared = WebServer()
  
  private lazy var uploader: GCDWebUploader = {
    let uploader = GCDWebUploader(uploadDirectory: uploadPath)
    uploader.delegate = self
    uploader.allowHiddenItems = true
    uploader.addGETHandler(forBasePath: "/", directoryPath: uploadPath, indexFilename: nil, cacheAge: 3600, allowRangeRequests: false)
    uploader.addHandler(forMethod: "GET", path: "/", request: GCDWebServerRequest.self) { request -> GCDWebServerResponse? in
      return GCDWebServerDataResponse(htmlTemplate: Bundle.main.path(forResource: "index", ofType: "html")!, variables: [:])
    }
    
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
    addUploadHandler()
    uploader.start()
    print(uploader.port)
  }

}

extension WebServer {
  func addUploadHandler() {
    uploader.addHandler(forMethod: "POST", path: "/uploadFiles", request: GCDWebServerMultiPartFormRequest.self) { (request, completionBlock) in
      
      let contentType = "application/json"
      _ = (request as! GCDWebServerMultiPartFormRequest).firstFile(forControlName: "file")
      _ = (request as! GCDWebServerMultiPartFormRequest).firstArgument(forControlName: "")?.string
      
      
      let response = GCDWebServerDataResponse.init(jsonObject: ["status": "1"], contentType: contentType)
      completionBlock(response)
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
