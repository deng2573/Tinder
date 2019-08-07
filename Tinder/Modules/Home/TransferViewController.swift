//
//  TransferViewController.swift
//  Tinder
//
//  Created by Deng on 2019/8/6.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import JXPagingView
import JXCategoryView

class TransferViewController: ViewController {
  private var pagingView: JXCategoryListContainerView!
  private var categoryView: JXCategoryTitleView!
  private var vcList = [JXCategoryListContentViewDelegate]()
  private var isClick = false
  
  var defaultSelectedIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
    requestHeaderLabels()
  }
  
  func setUpView() {
    title = "传输列表"
    setupCategoryView()
    setupPagingView()
  }
  
  func setupCategoryView() {
    categoryView = JXCategoryTitleView(frame: CGRect(x: 0, y: 0, width: view.width, height: 40))
    categoryView.delegate = self
    categoryView.titles = []
    categoryView.titleFont = UIFont.boldSystemFont(ofSize: 14)
    categoryView.backgroundColor = .white
    categoryView.titleColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    categoryView.titleSelectedColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    categoryView.isTitleColorGradientEnabled = true
    categoryView.isTitleLabelZoomEnabled = true
    categoryView.titleLabelZoomScale = 1.0
    categoryView.cellSpacing = 16
    categoryView.isAverageCellSpacingEnabled = true
    let lineView = JXCategoryIndicatorLineView()
    lineView.indicatorLineViewHeight = CGFloat(0)
    categoryView.indicators = [lineView]
    view.addSubview(categoryView)
    
    let line = UIView()
    line.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
    categoryView.addSubview(line)
    line.snp.makeConstraints { (make) in
      make.left.right.bottom.equalToSuperview()
      make.height.equalTo(0.5)
    }
  }
  
  func setupPagingView(){
    pagingView = JXCategoryListContainerView(delegate: self)
    pagingView.frame = CGRect(x: 0, y: 40 + 0.7, width: view.width, height: view.height - 40 - 64 - 50)
    pagingView.backgroundColor = .white
    pagingView.didAppearPercent = 0.99 //滚动一点就触发加载
    pagingView.scrollView.delegate = self
    view.addSubview(pagingView)
    categoryView.contentScrollView = pagingView.scrollView
  }
  
  func requestHeaderLabels() {
    var titles: [String] = []
    titles = ["正在分享", "传输完成"]
    categoryView.titles = titles
    categoryView.defaultSelectedIndex = defaultSelectedIndex
    pagingView.defaultSelectedIndex = defaultSelectedIndex
    let uploaderVC = UploaderViewController()
    uploaderVC.nav = navigationController
    let localVC = LocalFileViewController()
    localVC.nav = navigationController
    vcList = [uploaderVC, localVC]
    categoryView.reloadData()
    pagingView.reloadData()
  }
}

extension TransferViewController: UIScrollViewDelegate {
  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    let index = scrollView.contentOffset.x / screenWidth
    if isClick {
      pagingView.didClickSelectedItem(at: Int(index))
      isClick = false
    }
  }
}

extension TransferViewController: JXCategoryViewDelegate {
  func categoryView(_ categoryView: JXCategoryBaseView!, didScrollSelectedItemAt index: Int) {
    pagingView.didClickSelectedItem(at: index)
  }
  
  func categoryView(_ categoryView: JXCategoryBaseView!, didClickSelectedItemAt index: Int) {
    isClick = true
  }
}

extension TransferViewController: JXCategoryListContainerViewDelegate {
  func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
    return vcList.count
  }
  
  func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
    return vcList[index]
  }
}
