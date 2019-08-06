//
//  VideoPalyerDemoViewController.swift
//  PointWorld_tea
//
//  Created by Deng on 2019/3/7.
//  Copyright © 2019 LPzee. All rights reserved.
//

import UIKit

class VideoPalyerViewController: ViewController {
  
  private var playerView = PWVideoPalyerView()
  
  private var url: URL
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(url: URL) {
    self.url = url
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    playerView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth / 16 * 9)
    playerView.center = view.center
    playerView.player.orientationWillChange = { player , isFullScreen in
      self.setNeedsStatusBarAppearanceUpdate()
    }
    view.addSubview(playerView)
    playerView.play(url: url)
  }
  
  override var prefersStatusBarHidden: Bool {
    return playerView.player.isStatusBarHidden
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return playerView.player.isFullScreen ? .lightContent : .default
  }
  
  override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
    return .slide
  }

  override var shouldAutorotate: Bool {
    return playerView.player.shouldAutorotate
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return playerView.player.isFullScreen ? .landscape : .portrait
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    playerView.player.isViewControllerDisappear = false
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(animated)
    playerView.player.isViewControllerDisappear = true
  }
  
}


