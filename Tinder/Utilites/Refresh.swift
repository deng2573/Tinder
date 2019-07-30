//
//  PWRefresh.swift
//  PointWorld_tea
//
//  Created by Deng on 2018/4/25.
//  Copyright © 2018年 LPzee. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh

class PWRefreshHeader: MJRefreshNormalHeader {
  // 自定义重写
  override func prepare() {
    super.prepare()
    lastUpdatedTimeLabel.isHidden = true
    isAutomaticallyChangeAlpha = true
    stateLabel.textColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    stateLabel.font = UIFont.systemFont(ofSize: 14)
  }
}

class PWRefreshFooter: MJRefreshAutoNormalFooter {
  // 自定义重写
  override func prepare() {
    super.prepare()
    stateLabel.textColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    stateLabel.font = UIFont.systemFont(ofSize: 14)
    setTitle("我是有底线的~~", for: .noMoreData)
  }
}
