//
//  QRCodeGenerateViewController.swift
//  Tinder
//
//  Created by Deng on 2019/8/4.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit

class QRCodeGeneratorViewController: ViewController {
	
	private var content: String = ""
	
//	init(content: String) {
//		self.content = content
//		super.init()
//	}
//
//	required init?(coder aDecoder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
	
	private lazy var QRImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 5
		return imageView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(QRImageView)
		QRImageView.snp.makeConstraints({ (make) in
			make.center.equalToSuperview()
			make.size.equalTo(CGSize(width: screenWidth * 0.7, height: screenWidth * 0.7))
		})
	}
	
	private func generateQRImage() {
		
	}
	
}
