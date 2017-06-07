
//
//  UIImageView+Extension.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/6/6.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setCircleHeader(url: String) {
        let u = URL(string: url)
        
        let placeholder = UIImage(named: "home_head_default_29x29_")
        self.kf.setImage(with: u?.downloadURL, placeholder: placeholder, options: nil, progressBlock: nil) { (image, error,cacheType, imageURL) in
            self.image = (image == nil) ? placeholder : image
        }
    }
}
