//
//  MyViewController.swift
//  LeMotion
//
//  Created by Deng on 2019/4/3.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class MyViewController: ViewController {
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    return tableView
  }()
  
  private var cellList = [[StaticTableViewCell]]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
    loadLocalData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadLocalData()
  }
  
  func setUpView() {
    view.addSubview(tableView)
    tableView.backgroundColor = view.backgroundColor
    tableView.snp.makeConstraints { (make) in
      make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    tableView.estimatedRowHeight = 44
    tableView.register(cellType: MyNormalTableViewCell.self)
  }
  
  func loadLocalData() {
    cellList = [
      [
        StaticTableViewCell(cellType: MyNormalTableViewCell.self, title: "兑换记录", didSelectPushTo: ViewController()),
        StaticTableViewCell(cellType: MyNormalTableViewCell.self, title: "我的邀请", didSelectPushTo: ViewController()),
        StaticTableViewCell(cellType: MyNormalTableViewCell.self, title: "排行榜", didSelectPushTo: ViewController()),
        StaticTableViewCell(cellType: MyNormalTableViewCell.self, title: "账号中心", didSelectPushTo: ViewController())
      ]
    ]
    tableView.reloadData()
  }
  
}

extension MyViewController:  UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return cellList.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellList[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = self.cellList[indexPath.section][indexPath.row]
    
    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: item.cellType)
    
    return cell
  }
  
}

extension MyViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = self.cellList[indexPath.section][indexPath.row]
    if let vc = item.didSelectPushTo {
      navigationController?.pushViewController(vc, animated: true)
    }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 10
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.1
  }
  
}
