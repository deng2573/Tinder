//
//  VideoPlayerCellData.swift
//  Tinder
//
//  Created by Deng on 2019/8/6.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import YBImageBrowser

class VideoPlayerCellData: NSObject {
  var url: URL!
}

extension VideoPlayerCellData: YBImageBrowserCellDataProtocol {
  func yb_classOfBrowserCell() -> AnyClass {
    return VideoPlayerCell.self
  }
}
