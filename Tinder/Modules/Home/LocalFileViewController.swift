//
//  LocalFileViewController.swift
//  Tinder
//
//  Created by Deng on 2019/8/2.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import FileKit

class LocalFileViewController: ViewController {
  
  var selectedAction: (([FileInfo]) -> Void)?
  
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
    setUpDefaultBackButtonItem()
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

extension LocalFileViewController: UITableViewDataSource {
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

extension LocalFileViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let file = fileList[indexPath.row]
    let fileInfo = FileInfo(name: file.fileName, path: file.rawValue, fileExtension: file.pathExtension)
    selectedAction?([fileInfo])
    dismiss(animated: true, completion: nil)
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
