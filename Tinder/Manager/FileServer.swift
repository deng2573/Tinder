//
//  FileManager.swift
//  Tinder
//
//  Created by Deng on 2019/8/1.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import Photos
import TZImagePickerController
import iCloudDocumentSync

enum FilePickerType {
  case image
  case video
  case cloud
  case local
  
  var icon: UIImage {
    switch self {
    case .image:
      return #imageLiteral(resourceName: "VEDIO_icon")
    case .video:
      return #imageLiteral(resourceName: "VEDIO_icon")
    case .cloud:
      return #imageLiteral(resourceName: "VEDIO_icon")
    case .local:
      return #imageLiteral(resourceName: "VEDIO_icon")
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

class FileServer: NSObject {
  static let shared = FileServer()
  
  func filePicker(type: FilePickerType) {
    let currentVC = VCManager.currentViewController
    
    switch type {
    case .image, .video:
      let imagePickerViewController = TZImagePickerController(maxImagesCount: 9, columnNumber: 4, delegate: nil, pushPhotoPickerVc: true)
      
      imagePickerViewController?.allowTakePicture = true
      imagePickerViewController?.sortAscendingByModificationDate = true
      let isImage = type == .image
      
      imagePickerViewController?.allowPickingGif = isImage
      imagePickerViewController?.allowPickingImage = isImage
      imagePickerViewController?.allowPickingOriginalPhoto = isImage
      imagePickerViewController?.allowPickingMultipleVideo = !isImage
      imagePickerViewController?.allowPickingVideo = !isImage
      imagePickerViewController?.showSelectBtn = true
      
      imagePickerViewController?.didFinishPickingPhotosHandle = { (photos, assets, isSelect) in
//        self.assetsToFiles(assets: NSMutableArray(array: assets!) as! [PHAsset], complete: { files in
//          WebClient.upload(files: files, completion: { satu in
//
//          })
//        })
      }
      
      currentVC.present(imagePickerViewController!, animated: true, completion: nil)
    case .cloud:
    let documentTypes = ["public.content","com.microsoft.powerpoint.ppt","com.apple.iwork.pages.pages","com.apple.iwork.numbers.numbers","com.apple.iwork.keynote.key", "com.microsoft.powerpoint.​pptx", "com.microsoft.word.doc", "com.microsoft.word.docx", "com.microsoft.excel.xls", "com.microsoft.excel.xlsx", "com.adobe.pdf"]
    let documentPickerVC = UIDocumentPickerViewController(documentTypes: documentTypes, in: .open)
    if #available(iOS 11.0, *) {
      documentPickerVC.allowsMultipleSelection = true
    } else {
      // Fallback on earlier versions
    }
    documentPickerVC.delegate = self
    currentVC.present(documentPickerVC, animated: true, completion: nil)
    case .local: break
    }
  }
  
  static func assetToFile(assets: [PHAsset], complete: @escaping (_ files: [FileInfo]) -> ()) {
    let manager = TZImageManager.default()
    var files: [FileInfo] = []
    for (index, asset) in assets.enumerated() {
      let assetType = manager?.getAssetType(asset)
      switch assetType {
      case TZAssetModelMediaTypePhoto, TZAssetModelMediaTypePhotoGif:
        PHImageManager.default().requestImageData(for: asset, options: nil) { data, file, orientation, info in
          if let data = data {
            if assetType == TZAssetModelMediaTypePhoto {
              let file = FileInfo(type: "JPG", data: data)
              files.append(file)
            } else {
              let file = FileInfo(type: "GIF", data: data)
              files.append(file)
            }
            if index == assets.count - 1 {
              complete(files)
            }
          }
        }
      case TZAssetModelMediaTypeVideo:
        PHImageManager.default().requestAVAsset(forVideo: asset, options: nil) { (asset, mix, info) in
          do {
            let avAsset = asset as? AVURLAsset
            let data = try Data(contentsOf: avAsset!.url)
            let file = FileInfo(type: avAsset!.url.pathExtension, data: data)
            files.append(file)
            if index == assets.count - 1 {
              complete(files)
            }
          } catch  {
          }
        }
      default:
        break
      }
    }
  }
}

extension FileServer: UIDocumentPickerDelegate {
  
  func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
    var files: [FileInfo] = []
    for url in urls {
      do {
        let pathExtension = url.pathExtension
        let data = try Data(contentsOf: url)
        let file = FileInfo(type: pathExtension, data: data)
        files.append(file)
      } catch {
        
      }
    }
  }
}
