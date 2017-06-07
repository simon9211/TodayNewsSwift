//
//  SMHomeSearch.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/6/4.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit
import SnapKit

class SMHomeSearchBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = SMGlobalColor()
        addSubview(searchBar)
    }
    
    lazy var searchBar: SMSearchBar = {
        let searchBar = SMSearchBar()
        searchBar.placeholder = "搜索"
        return searchBar
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SMSearchBar: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.cornerRadius = kCornerRadius
        layer.masksToBounds = true
        let searchIcon = UIImageView()
        font = UIFont.systemFont(ofSize: 15)
        searchIcon.image = UIImage(named: "search_discover_16x16_")
        searchIcon.width = 16
        searchIcon.height = 16
        leftView = searchIcon
        leftViewMode = .always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
