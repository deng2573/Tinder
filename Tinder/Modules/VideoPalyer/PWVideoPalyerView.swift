//
//  PWVideoPalyerView.swift
//  PointWorld_tea
//
//  Created by Deng on 2019/3/6.
//  Copyright © 2019 LPzee. All rights reserved.
//

import UIKit
import ZFPlayer

class PWVideoPalyerView: UIView {
  var player: ZFPlayerController!
  fileprivate var playerManager: ZFAVPlayerManager!
  fileprivate var controlView: PWPlayerControlView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpPlayer()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setUpPlayer() {
    playerManager = ZFAVPlayerManager()
    
    controlView = PWPlayerControlView()
    controlView.autoHiddenTimeInterval = 5
    controlView.autoFadeTimeInterval = 0.5
    
    player = ZFPlayerController.player(withPlayerManager: playerManager, containerView: self)
    player.controlView = controlView
    player.pauseWhenAppResignActive = false
    
    // 视频准备播放
    player.playerReadyToPlay = { asset, url in
      print("开始播放")
    }
    // 视频正在播放
    player.playerPlayStateChanged = { asset, state in
      switch state {
      case .playStatePlaying:
        self.controlView.showReplay(show: false)
        break
      default:
        break
      }
    }
    // 视频播放完成
    player.playerDidToEnd = { asset in
      self.controlView.showReplay(show: true)
      self.controlView.pwPortraitControlView.playOrPause()
    }
    // 点击重播
    controlView.replayAction = {
      self.playerManager.replay()
    }
  }
  
  func play(url: URL) {
    player.assetURLs = [url]
    player.playTheIndex(0)
    playerManager.play()
  }
  
  func pause() {
    playerManager.pause()
  }
}
