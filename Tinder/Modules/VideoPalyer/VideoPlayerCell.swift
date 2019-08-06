//
//  VideoPlayerCell.swift
//  Tinder
//
//  Created by Deng on 2019/8/6.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import YBImageBrowser

class VideoPlayerCell: UICollectionViewCell {

  lazy var playerView: PWVideoPalyerView = {
    let playerView = PWVideoPalyerView(frame: .zero)
    
    return playerView
  }()
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpView()
  }
  
  private func setUpView() {
    contentView.addSubview(playerView)
    playerView.snp.makeConstraints({ (make) in
      make.edges.equalToSuperview()
    })
  }
}

extension VideoPlayerCell: YBImageBrowserCellProtocol {
  func yb_initializeBrowserCell(withData data: YBImageBrowserCellDataProtocol, layoutDirection: YBImageBrowserLayoutDirection, containerSize: CGSize) {
    if let data = data as? VideoPlayerCellData {
      playerView.play(url: data.url)
    }
  }
}
