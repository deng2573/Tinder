//
//  MatchingDeviceViewController.swift
//  Tinder
//
//  Created by Deng on 2019/7/30.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import MMLanScan

class MatchingViewController: ViewController {
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.backgroundColor = .white
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(cellType: FileInformationCell.self)
    return tableView
  }()
  
  private var devices: [MMDevice] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
    searchDevice()
  }
  
  private func setUpView() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
  
  private func searchDevice() {
    WebManager.shared.startScan { devices in
      for device in devices {
        if !device.isLocalDevice {
          let url = "http://" + device.ipAddress + ":80/Matching"
          WebClient.requestJson(method: .get, url: url, parameters: nil, loading: false, callback: { json, error, status in
            if status == 200 {
              self.devices.append(device)
              self.tableView.reloadData()
            }
          })
        }
      }
    }
  }
}

extension MatchingViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return devices.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let device = devices[indexPath.row]
    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FileInformationCell.self)
    cell.backgroundColor = UIColor.randomColor
    return cell
  }
}

extension MatchingViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let device = devices[indexPath.row]
    let a = PingOperation.init(ipToPing: device.ipAddress) { (error, string) in
      print(error)
      print(string)
    }
    a?.start()
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0.1
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.1
  }
  
}
