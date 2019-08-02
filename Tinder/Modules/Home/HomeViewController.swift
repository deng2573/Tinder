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
import Tiercel

class HomeViewController: ViewController {

  private lazy var uploadButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("我要上传", for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.6196078431, blue: 1, alpha: 1)
    button.layer.cornerRadius = 22
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    button.tap(action: { _ in
//      self.presentPickerController()
//      self.navigationController?.pushViewController(MatchingViewController(), animated: true)
      self.navigationController?.pushViewController(FilePickerViewController(), animated: true)
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
      
//     let manager =  SessionManager("ViewController1222", configuration: SessionConfiguration())
//      
//     
//      
//      manager.download("http://192.168.1.143:80/downloadFiles?path=file:///var/mobile/Media/DCIM/103APPLE/IMG_3996.JPG")?.progress { [weak self] (task) in
//        let per = task.progress.fractionCompleted
//        print("progress： \(String(format: "%.2f", per * 100))%")
//        }.success { [weak self] (task) in
//          
//          // 下载任务成功了
//          print("下载成功")
//        }.failure { [weak self] (task) in
//         
//          print("下载failure")
//          if task.status == .suspended {
//            // 下载任务暂停了
//          }
//          if task.status == .failed {
//            // 下载任务失败了
//          }
//          if task.status == .canceled {
//            // 下载任务取消了
//          }
//          if task.status == .removed {
//            // 下载任务移除了
//          }
//      }
      
//      WebClient.download(url: "", completion: { sut in
//
//      })
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
}
