//
//  PWPlayerControlView.swift
//  PointWorld_tea
//
//  Created by Deng on 2019/3/6.
//  Copyright © 2019 LPzee. All rights reserved.
//

import UIKit
import ZFPlayer

class PWPlayerControlView: ZFPlayerControlView {
  var pwPortraitControlView: PWPortraitControlView! // 自定义竖屏样式
  var pwLandScapeControlView: PWLandScapeControlView! // 自定义横幕样式
  var replayAction: (()->Void)?
  
  override init(frame: CGRect) {
    pwPortraitControlView = PWPortraitControlView()
    pwLandScapeControlView = PWLandScapeControlView()
    
    super.init(frame: frame)
    bottomPgrogress.removeFromSuperview()
    activity.loadingView.lineWidth = 3
    activity.speedTextLabel.font = UIFont.systemFont(ofSize: 14)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    pwPortraitControlView.replayView.replayAction = {
      if let replayAction = self.replayAction {
        replayAction()
      }
    }
    pwLandScapeControlView.replayView.replayAction = {
      if let replayAction = self.replayAction {
        replayAction()
      }
    }
  }
  
  override var portraitControlView: ZFPortraitControlView! {
    return pwPortraitControlView
  }
  
  override var landScapeControlView: ZFLandScapeControlView! {
    return pwLandScapeControlView
  }
  
  func showReplay(show: Bool) {
    pwPortraitControlView.replayView.isHidden = !show
    pwLandScapeControlView.replayView.isHidden = !show
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


class PWPortraitControlView: ZFPortraitControlView {
  fileprivate var replayView: ReplayView! // 重播
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    slider.setThumbImage(UIImage(named: "player_slider_btn"), for: .normal)
    slider.maximumTrackImage = UIImage(named: "player_slider_max")
    slider.minimumTrackImage = UIImage(named: "player_slider_min")
    slider.bufferTrackTintColor = .clear
    
    currentTimeLabel.font = UIFont.systemFont(ofSize: 10)
    totalTimeLabel.font = UIFont.systemFont(ofSize: 10)
    
    fullScreenBtn.setImage(UIImage(named: "player_fullscreen"), for: .normal)
    
    playOrPauseBtn.removeFromSuperview()
    bottomToolView.addSubview(playOrPauseBtn)
    playOrPauseBtn.setImage(UIImage(named: "player_play"), for: .normal)
    playOrPauseBtn.setImage(UIImage(named: "player_pause"), for: .selected)
    
    titleLabel.isHidden = true
    
    replayView = ReplayView(frame: frame, type: .portrait)
    addSubview(replayView)
    sendSubviewToBack(replayView)
    replayView.isHidden = true
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let width = bounds.size.width
    let sliderW = (width - 40 * 4 - 32) * 0.7
    
    slider.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.size.equalTo(CGSize(width: sliderW , height: 40))
    }
    currentTimeLabel.snp.makeConstraints { make in
      make.centerY.equalTo(self.slider)
      make.right.equalTo(slider.snp.left).offset(-16)
    }
    totalTimeLabel.snp.makeConstraints { make in
      make.centerY.equalTo(self.slider)
      make.left.equalTo(slider.snp.right).offset(16)
    }
    playOrPauseBtn.snp.makeConstraints { make in
      make.left.equalToSuperview()
      make.centerY.equalTo(self.slider)
      make.size.equalTo(CGSize(width: 40, height: 40))
    }
    fullScreenBtn.snp.makeConstraints { make in
      make.right.equalToSuperview()
      make.centerY.equalTo(self.slider)
      make.size.equalTo(CGSize(width: 40, height: 40))
    }
    replayView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  override func playOrPause() {
    playOrPauseBtn.isSelected = !playOrPauseBtn.isSelected;
    if playOrPauseBtn.isSelected {
      if player?.progress ?? 0 >= Float(1) {
        player?.currentPlayerManager.replay!()
      } else {
        player?.currentPlayerManager.play!()
      }
    } else {
      player?.currentPlayerManager.pause!()
    }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class PWLandScapeControlView: ZFLandScapeControlView {
  fileprivate var replayView: ReplayView! // 重播
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backBtn.setImage(UIImage(named: "player_back"), for: .normal)
    
    slider.setThumbImage(UIImage(named: "player_slider_btn"), for: .normal)
    slider.maximumTrackImage = UIImage(named: "player_slider_max")
    slider.minimumTrackImage = UIImage(named: "player_slider_min")
    slider.bufferTrackTintColor = .clear
    
    currentTimeLabel.font = UIFont.systemFont(ofSize: 12)
    totalTimeLabel.font = UIFont.systemFont(ofSize: 12)

    playOrPauseBtn.setImage(UIImage(named: "player_play"), for: .normal)
    playOrPauseBtn.setImage(UIImage(named: "player_pause"), for: .selected)
    
    replayView = ReplayView(frame: frame, type: .landScape)
    addSubview(replayView)
    sendSubviewToBack(replayView)
    replayView.isHidden = true
    
    lockBtn.removeFromSuperview()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    currentTimeLabel.snp.makeConstraints { make in
      make.centerY.equalTo(self.slider)
      make.right.equalTo(slider.snp.left).offset(-8)
    }
    totalTimeLabel.snp.makeConstraints { make in
      make.centerY.equalTo(self.slider)
      make.left.equalTo(slider.snp.right).offset(8)
    }
    replayView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  override func playOrPause() {
    playOrPauseBtn.isSelected = !playOrPauseBtn.isSelected;
    if playOrPauseBtn.isSelected {
      if player?.progress ?? 0 >= Float(1) {
        player?.currentPlayerManager.replay!()
      } else {
        player?.currentPlayerManager.play!()
      }
    } else {
      player?.currentPlayerManager.pause!()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

enum PlayerDirection {
  case portrait
  case landScape
}

class ReplayView: UIView {
  fileprivate var type: PlayerDirection = .portrait
  var replayAction: (()->Void)?
  
  init(frame: CGRect, type: PlayerDirection) {
    
    super.init(frame: frame)
    self.type = type
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    let bgView = UIImageView()
    bgView.clipsToBounds = true
    bgView.isUserInteractionEnabled = true
    bgView.contentMode = .scaleAspectFill
    bgView.image = UIImage(named: "player_replay_bg")
    addSubview(bgView)
    bgView.snp.makeConstraints({ (make) in
      make.edges.equalTo(self)
    })
    
    var replayBtnW = 50
    var space = 10
    if type == .portrait {
      replayBtnW = 30
      space = 5
    }
    
    let replayBtn = UIButton(type: .custom)
    replayBtn.setImage(UIImage(named: "player_replay"), for: .normal)
    bgView.addSubview(replayBtn)
    replayBtn.snp.makeConstraints({ (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(bgView.snp.centerY).offset(-space)
      make.size.equalTo(CGSize(width: replayBtnW, height: replayBtnW))
    })
    
    let replayL = UILabel()
    replayL.font = UIFont.boldSystemFont(ofSize: 14)
    replayL.textColor = .white
    replayL.text = "重播"
    bgView.addSubview(replayL)
    replayL.snp.makeConstraints({ (make) in
      make.centerX.equalToSuperview()
      make.top.equalTo(bgView.snp.centerY).offset(space)
    })
    
    replayBtn.tap { _ in
      self.replayAction?()
    }
  }
}
