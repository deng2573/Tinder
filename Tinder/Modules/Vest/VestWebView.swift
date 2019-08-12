//
//  VestWebView.swift
//  Tinder
//
//  Created by Deng on 2019/8/12.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import WebKit

class VestWebView: WKWebView {
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect) {
    let webViewConfiguration = WKWebViewConfiguration()
    webViewConfiguration.allowsInlineMediaPlayback = true
    webViewConfiguration.preferences.javaScriptEnabled = true
    super.init(frame: frame, configuration: webViewConfiguration)
  }
  
  func load(urlString: String) {
    if let url =  URL(string: urlString) {
      let urlRequest = URLRequest(url: url)
      load(urlRequest)
    }
  }
}
