//
//  MySettingViewController.swift
//  Tinder
//
//  Created by Deng on 2019/8/8.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class MySettingViewController: ViewController {
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    return tableView
  }()
  
  private var cellList = [[StaticTableViewCell]]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
    loadCellData()
  }
  
  func setUpView() {
    title = "设置"
    view.addSubview(tableView)
    tableView.backgroundColor = view.backgroundColor
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(cellType: MyNormalTableViewCell.self)
  }
  
  func loadCellData() {
    cellList = [
      [
        StaticTableViewCell(cellType: MyNormalTableViewCell.self, title: "清除缓存", icon: UIImage(), didSelectPushTo: ViewController()),
      ]
    ]
    tableView.reloadData()
  }
  
}

extension MySettingViewController:  UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return cellList.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellList[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = self.cellList[indexPath.section][indexPath.row]
    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: item.cellType)
    if let cell  = cell as? MyNormalTableViewCell {
      cell.update(title: item.title)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
}

extension MySettingViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    HUD.loading()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      HUD.show(text: "清除成功")
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
    return 2
  }
  
}
