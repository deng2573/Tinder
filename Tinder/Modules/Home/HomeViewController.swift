//
//  HomeViewController.swift
//  Tinder
//
//  Created by Deng on 2019/7/29.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import TZImagePickerController
import MMLanScan

class HomeViewController: ViewController {

  private lazy var uploadButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("我要上传", for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.6196078431, blue: 1, alpha: 1)
    button.layer.cornerRadius = 22
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    button.tap(action: { _ in
//      self.presentPickerController()
      self.navigationController?.pushViewController(MatchingViewController(), animated: true)
    })
    
    return button
  }()
  
  private lazy var listButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("上传列表", for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.6196078431, blue: 1, alpha: 1)
    button.layer.cornerRadius = 22
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    button.tap(action: { _ in
      self.navigationController?.pushViewController(TransferViewController(), animated: true)
    })
    
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(uploadButton)
    uploadButton.snp.makeConstraints({ (make) in
      make.left.right.equalTo(view)
      make.top.equalTo(16)
      make.height.equalTo(44)
    })
    
    view.addSubview(listButton)
    listButton.snp.makeConstraints({ (make) in
      make.left.right.equalTo(view)
      make.top.equalTo(100)
      make.height.equalTo(44)
    })
  }
  
  private func presentPickerController() {
    let imagePickerViewController = TZImagePickerController(maxImagesCount: 9, columnNumber: 4, delegate: nil, pushPhotoPickerVc: true)

    imagePickerViewController?.allowTakePicture = true
    imagePickerViewController?.sortAscendingByModificationDate = true
    
    imagePickerViewController?.allowPickingGif = true
    imagePickerViewController?.allowPickingVideo = true
    imagePickerViewController?.allowPickingImage = true
    imagePickerViewController?.allowPickingOriginalPhoto = true
    imagePickerViewController?.allowPickingMultipleVideo = true
    imagePickerViewController?.showSelectBtn = false
    
    imagePickerViewController?.didFinishPickingPhotosHandle = { (photos, assets, isSelect) in
      
      
      self.assetsToFiles(assets: NSMutableArray(array: assets!) as! [PHAsset], complete: { files in
        WebClient.upload(files: files, completion: { satu in
          
        })
      })
    }
    
    present(imagePickerViewController!, animated: true, completion: nil)
  }
  
  private func assetsToFiles(assets: [PHAsset], complete: @escaping (_ files: [FileInfo]) -> ()) {
    WebServer.shared.addUploadHandler()
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
