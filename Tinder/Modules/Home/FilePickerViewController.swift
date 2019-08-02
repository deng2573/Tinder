//
//  FilePickerViewController.swift
//  Tinder
//
//  Created by Deng on 2019/7/31.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class FilePickerViewController: UIViewController {
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.backgroundColor = .white
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(cellType: FileTypesCell.self)
    tableView.register(cellType: FileInfoCell.self)
    return tableView
  }()
  
  private lazy var searchController: UISearchController = {
    let searchResultVC = UIViewController()
    searchResultVC.view.backgroundColor = UIColor.red
    let searchController = UISearchController(searchResultsController: searchResultVC)
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
    
    let searchBar = searchController.searchBar
    searchBar.placeholder = "搜索"
    searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    searchBar.returnKeyType = UIReturnKeyType.done
    searchBar.searchBarStyle = .minimal
    searchBar.sizeToFit()
    searchBar.tintColor = UIColor.themeColor
    searchBar.delegate = self
    
    searchBar.setCancleBtn()
    
    return searchController
  }()
  
  private lazy var shareButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("分享", for: .normal)
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

    setUpView()
//    tableView.tableHeaderView = searchController.searchBar
//    tableView.sectionHeaderHeight = 28
  }
  
  private func setUpView() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    view.addSubview(shareButton)
    shareButton.snp.makeConstraints({ (make) in
      make.left.equalTo(40)
      make.right.bottom.equalTo(-40)
      make.height.equalTo(44)
    })
  }
  
}

extension FilePickerViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
     return 1
    }
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FileTypesCell.self)
      cell.fileTypeView.didSelectedAction = { type in
        let fileServer = FileServer.shared
        fileServer.filePicker(type: type)
        fileServer.didSelectedAction = { files in
          self.shareButton.setTitle("分享  \(files.count)", for: .normal)
          WebClient.upload(files: files, url: "http://192.168.1.161:8080/uploadFiles", completion: { sta in
            
          })
        }
      }
      return cell
    }
    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FileInfoCell.self)
    cell.backgroundColor = UIColor.randomColor
    return cell
  }
}

extension FilePickerViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
     return FileTypeItemWidth + 25
    }
    return 100
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

  }
  
//  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    return searchController.searchBar
//  }
//
//  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//    return UIView()
//  }
//
//  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//    return 50
//  }
//
//  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//    return 0.1
//  }
  
}

extension FilePickerViewController: UISearchBarDelegate {
  func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
    
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

  }
}

extension FilePickerViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
  }
}
