//
//  QRCodeGenerateViewController.swift
//  Tinder
//
//  Created by Deng on 2019/8/4.
//  Copyright © 2019 Deng. All rights reserved.
//

import UIKit
import EFQRCode

class QRCodeGeneratorViewController: ViewController {
	
	private var content: String = ""
	
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(content: String) {
    super.init(nibName: nil, bundle: nil)
    self.content = content
  }

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
      make.size.equalTo(CGSize(width: screenWidth * 0.6, height: screenWidth * 0.6))
    })
    generateQRImage()
	}
	
	private func generateQRImage() {
		let generator = EFQRCodeGenerator(content: content, size: EFIntSize(width: 1024, height: 1024))
    if let QRImage = generator.generate() {
      QRImageView.image = UIImage(cgImage: QRImage)
    }
	}
	
}
