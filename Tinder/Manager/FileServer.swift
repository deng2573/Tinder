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
import FileKit

class FileServer: NSObject {
  static let shared = FileServer()
  
  var didSelectedAction: (([FileInfo]) -> Void)?
  
  private var selectedAssets: [PHAsset] = []
  
  private var selectedDocuments: [URL] = []
  
  private var selectedLocalFiles: [URL] = []
  
  private var selectedFileInfos: [FileInfo] = []
  
  func filePicker(type: FilePickerType) {
    let currentVC = VCManager.currentViewController
    
    switch type {
    case .image, .video:
      let imagePickerViewController = TZImagePickerController(maxImagesCount: 1000000, columnNumber: 4, delegate: nil, pushPhotoPickerVc: true)
      imagePickerViewController?.selectedAssets = NSMutableArray(array: selectedAssets)
      imagePickerViewController?.allowTakePicture = true
      imagePickerViewController?.sortAscendingByModificationDate = true
      let isImage = type == .image
      
      imagePickerViewController?.allowPickingGif = isImage
      imagePickerViewController?.allowPickingImage = isImage
      imagePickerViewController?.allowPickingOriginalPhoto = isImage
      imagePickerViewController?.allowPickingMultipleVideo = !isImage
      imagePickerViewController?.allowPickingVideo = !isImage
      imagePickerViewController?.showSelectBtn = true
      
      imagePickerViewController?.didFinishPickingPhotosHandle = { (photos, assets, isSelectOriginalPhoto) in
        var newAssets: [PHAsset] = []
        let assets = assets as! [PHAsset]
        for asset in assets {
          if !self.selectedAssets.contains(asset) {
            newAssets.append(asset)
          }
        }
        self.selectedAssets = assets
        for file in self.selectedFileInfos {
          if let asset = file.asset {
            if !self.selectedAssets.contains(asset) {
              self.removeFile(info: file)
            }
          }
        }
        self.assetToFile(assets: newAssets, complete: { files in
          self.selectedFileInfos.append(contentsOf: files)
          DispatchQueue.main.async(execute: {
            self.didSelectedAction?(self.selectedFileInfos)
          })

        })
      }
      
      currentVC.present(imagePickerViewController!, animated: true, completion: nil)
    case .cloud:
    let documentTypes = ["public.content","com.microsoft.powerpoint.ppt","com.apple.iwork.pages.pages","com.apple.iwork.numbers.numbers","com.apple.iwork.keynote.key", "com.microsoft.powerpoint.​pptx", "com.microsoft.word.doc", "com.microsoft.word.docx", "com.microsoft.excel.xls", "com.microsoft.excel.xlsx", "com.adobe.pdf"]
    let documentPickerVC = UIDocumentPickerViewController(documentTypes: documentTypes, in: .open)
    if #available(iOS 11.0, *) {
      documentPickerVC.allowsMultipleSelection = true
    }
    documentPickerVC.delegate = self
    currentVC.present(documentPickerVC, animated: true, completion: nil)
    case .local:
      let localFileVC = LocalFileViewController()
      localFileVC.isFilePick = true
      localFileVC.selectedAction = { files in
        var selectPaths: [String] = []
        for selectFile in self.selectedFileInfos {
          if let selectPath = selectFile.path {
            selectPaths.append(selectPath)
          }
        }
        
        for file in files {
          if let path = file.path {
            if !selectPaths.contains(path) {
              self.selectedFileInfos.append(file)
            }
          }
        }
        
        DispatchQueue.main.async(execute: {
          self.didSelectedAction?(self.selectedFileInfos)
        })
      }
      currentVC.present(NavigationController(rootViewController: localFileVC), animated: true, completion: nil)
    }
  }
  
  func removeFile(info: FileInfo) {
    if let index = selectedFileInfos.firstIndex(of: info) {
      selectedFileInfos.remove(at: index)
    }
    DispatchQueue.main.async(execute: {
      self.didSelectedAction?(self.selectedFileInfos)
    })
  }
  
  private func assetToFile(assets: [PHAsset], complete: @escaping (_ files: [FileInfo]) -> ()) {
    let manager = TZImageManager.default()
    var files: [FileInfo] = []
    for (index, asset) in assets.enumerated() {
      let assetType = manager?.getAssetType(asset)
      switch assetType {
      case TZAssetModelMediaTypePhoto, TZAssetModelMediaTypePhotoGif:
        PHImageManager.default().requestImageData(for: asset, options: nil) { data, file, orientation, info in
          if let data = data {
            let url = info?["PHImageFileURLKey"] as! URL
            let name = url.fileName
            let file = FileInfo(name: name, data: data, fileExtension: url.pathExtension, asset: asset)
            files.append(file)
            if index == assets.count - 1 {
              complete(files)
            }
          }
        }
      case TZAssetModelMediaTypeVideo:
        PHImageManager.default().requestAVAsset(forVideo: asset, options: nil) { (newAsset, mix, info) in
          do {
            let avAsset = newAsset as? AVURLAsset
            let url = avAsset!.url
            let name = url.fileName
            let data = try Data(contentsOf: url)
            let file = FileInfo(name: name, data: data, fileExtension: url.pathExtension, asset: asset)
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
    let shared = iCloud.shared()
    shared?.setupiCloudDocumentSync(withUbiquityContainer: nil)
    if shared?.checkAvailability() ?? false {
      var files: [FileInfo] = []
      for (index, url) in urls.enumerated() {
        guard let document = iCloudDocument(fileURL: url) else { return }
        NSFileCoordinator().coordinate(readingItemAt: url, options: [], error: nil) { url in
          do {
            let pathExtension = url.pathExtension
            let name = document.localizedName()?.substring(before: ".\(pathExtension)") ?? "文件"
            let data = try Data(contentsOf: url)
            let file = FileInfo(name: name, data: data, fileExtension: pathExtension)
            files.append(file)
            if index == urls.count - 1 {
              selectedFileInfos.append(contentsOf: files)
              DispatchQueue.main.async(execute: {
                self.didSelectedAction?(self.selectedFileInfos)
              })
            }
          } catch(let error) {
            print(error)
          }
        }
      }
    }
  }
}

extension URL {
  var fileName: String {
    let path = Path(url: self)
    return path?.fileName.substring(before: ".\(pathExtension)") ?? "文件"
  }
}
