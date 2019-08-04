//
//  QRCodeRecognizerViewController.swift
//  Tinder
//
//  Created by Deng on 2019/8/4.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class QRCodeRecognizerViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(QRImageView)
		QRImageView.snp.makeConstraints({ (make) in
			make.center.equalToSuperview()
			make.size.equalTo(CGSize(width: screenWidth * 0.7, height: screenWidth * 0.7))
		})
	}
	
}
