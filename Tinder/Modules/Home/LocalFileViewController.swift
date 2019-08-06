//
//  LocalFileViewController.swift
//  Tinder
//
//  Created by Deng on 2019/8/2.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import FileKit
import JXPagingView
import JXCategoryView
import YBImageBrowser

class LocalFileViewController: ViewController {
  var nav: UINavigationController?
  var selectedAction: (([FileInfo]) -> Void)?
  var isFilePick = false
  
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
    cell.update(path: file)
    return cell
  }
}

extension LocalFileViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let file = fileList[indexPath.row]
    
    if isFilePick {
      let fileInfo = FileInfo(name: file.fileName, path: file.rawValue, fileExtension: file.pathExtension)
      selectedAction?([fileInfo])
      dismiss(animated: true, completion: nil)
      return
    }

    if let nav = navigationController {
      self.nav = nav
    }
    var browserDatas:[YBImageBrowserCellDataProtocol] = []
    let cell = tableView.cellForRow(at: indexPath) as! FileInfoCell
    let pathExtension = file.pathExtension
    if pathExtension.fileType == .image {
      let data = YBImageBrowseCellData()
      data.url = URL(fileURLWithPath: file.rawValue)
      data.sourceObject = cell.coverImageView
      browserDatas.append(data)
    } else if pathExtension.fileType == .video {
//      let videoPlayVC = VideoPalyerViewController(url: URL(fileURLWithPath: file.rawValue))
//      self.nav?.pushViewController(videoPlayVC, animated: true)
//      return
      let data = YBVideoBrowseCellData()
      data.url = URL(fileURLWithPath: file.rawValue)
      data.sourceObject = cell.coverImageView
      browserDatas.append(data)
    } else {
      let documentInteractionVC = UIDocumentInteractionController()
      documentInteractionVC.delegate = self
      documentInteractionVC.url = URL(fileURLWithPath: file.rawValue)
      documentInteractionVC.presentPreview(animated: true)
    }
    
    if !browserDatas.isEmpty {
      let browser = YBImageBrowser()
      browser.dataSourceArray = browserDatas
      browser.currentIndex = 0
      browser.show()
    }
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

extension LocalFileViewController: JXCategoryListContentViewDelegate {
  func listDidAppear() {
    
  }
  func listView() -> UIView! {
    return view
  }
}

extension LocalFileViewController: UIDocumentInteractionControllerDelegate {
  func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
    return self
  }
  
  func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
    return view
  }
  
  func documentInteractionControllerRectForPreview(_ controller: UIDocumentInteractionController) -> CGRect {
    return view.frame
  }
}
