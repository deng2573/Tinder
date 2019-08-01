//
//  TransceiverListViewController.swift
//  Tinder
//
//  Created by Deng on 2019/7/29.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import FileKit

class TransferViewController: ViewController {
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.backgroundColor = .white
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(cellType: FileInfoCell.self)
    return tableView
  }()
  
  private var fileList: [Path] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
    obtainLocalFiles()
  }
  
  private func setUpView() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
  
  private func obtainLocalFiles() {
    let path = Path(WebServer.shared.uploadPath)
    fileList = path.children()
    tableView.reloadData()
  }
}

extension TransferViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fileList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let file = fileList[indexPath.row]
    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FileInfoCell.self)
    cell.update(file: file)
    return cell
  }
}

extension TransferViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

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

//extension TransferViewController: JXCategoryListContentViewDelegate {
//  func listDidAppear() {
//
//  }
//  func listView() -> UIView! {
//    return view
//  }
//}
