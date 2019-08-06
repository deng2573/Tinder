//
//  UIImageView+Extensions.swift
//  PointWorld_tea
//
//  Created by Deng on 2018/4/19.
//  Copyright © 2018年 LPzee. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
  func image(url: URL, placeholder: UIImage? = nil) {
    sd_setImage(with: url, placeholderImage: placeholder)
  }
}
