//
//  WebManager.swift
//  Tinder
//
//  Created by Deng on 2019/7/30.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import MMLanScan

class WebManager: NSObject {
  static let shared = WebManager()
  
  let localDevice = LANProperties.localIPAddress()
  private var devices: [MMDevice] = []
  private var finishScan: (([MMDevice]) -> Void)?
  
  private lazy var scanner: MMLANScanner = {
    let scanner = MMLANScanner(delegate: self)
    return scanner!
  }()
  
  func startScan(completion: @escaping (_ devices: [MMDevice]) -> ()) {
    finishScan = completion
    devices.removeAll()
    scanner.start()
  }
  
}

extension WebManager: MMLANScannerDelegate {
  func lanScanDidFindNewDevice(_ device: MMDevice!) {
    if !devices.contains(device) {
      devices.append(device)
    }
  }
  
  func lanScanDidFinishScanning(with status: MMLanScannerStatus) {
    finishScan?(devices)
    scanner.stop()
  }
  
  func lanScanDidFailedToScan() {
    scanner.stop()
  }
}
