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
