//
//  FeedbackViewController.swift
//  Tinder
//
//  Created by Deng on 2019/8/8.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class FeedbackViewController: ViewController {
  private lazy var textView: UITextView = {
    let textView = UITextView(frame: .zero)
    textView.backgroundColor = .white
    textView.clipsToBounds = true
    textView.layer.cornerRadius = 5
    textView.font = UIFont.boldSystemFont(ofSize: 14)
    textView.textColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
    textView.isScrollEnabled = false
    textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    textView.textContainer.lineFragmentPadding = 0
    return textView
  }()
  
  private lazy var saveButton: UIButton = {
    let button = UIButton(type: .custom)
    button.layer.masksToBounds = true
    button.layer.cornerRadius = 22
    button.backgroundColor = .white
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.setTitle("提交", for: .normal)
    button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    button.tap(action: { _ in
      HUD.loading()
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        HUD.show(text: "提交成功, 谢谢你的意见")
        self.navigationController?.popViewController(animated: true)
      }
    })
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
  }
  
  private func setUpView() {
    title = "意见反馈"
    view.addSubview(textView)
    textView.snp.makeConstraints({ (make) in
      make.top.equalTo(10)
      make.left.equalTo(16)
      make.right.equalTo(-16)
      make.height.equalTo(250)
    })
    
    view.addSubview(saveButton)
    saveButton.snp.makeConstraints({ (make) in
      make.top.equalTo(textView.snp.bottom).offset(60)
      make.centerX.equalToSuperview()
      make.left.equalTo(20)
      make.right.equalTo(-20)
      make.height.equalTo(44)
    })
  }
}
