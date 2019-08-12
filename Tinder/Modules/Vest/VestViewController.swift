//
//  VestViewController.swift
//  Tinder
//
//  Created by Deng on 2019/8/12.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class VestViewController: ViewController {
 
  private lazy var vestView: VestWebView = {
    let view = VestWebView(frame: .zero)
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupVestView()
    vestRequest()
  }
  
  private func setupVestView() {
    title = "首页"
    view.addSubview(vestView)
    vestView.snp.makeConstraints({ (make) in
      make.edges.equalToSuperview()
    })
  }
  
  private func vestRequest() {
    VestManager.vestInfo { result in
      if let info = result {
        if info.code != 200 || !info.is_wap {
          UIApplication.shared.delegate?.window??.rootViewController = TabBarController()
          return
        }
        self.vestView.load(urlString: info.wap_url)
      }
    }
  }
}
