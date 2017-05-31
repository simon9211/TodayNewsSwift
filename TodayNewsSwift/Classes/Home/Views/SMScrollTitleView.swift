//
//  SMScrollTitleView.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/5/31.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit
import Kingfisher

class SMScrollTitleView: UIView {
    
    ///存放标题模型的数组
    var titles = [String]()
    ///存放标题label的数组
    var labels = [SMTitleLabel]()
    ///存放label宽度的数组
    private var labelWidths = [CGFloat]()
    /// + 号点击回调
    var addBtnClickClosure: (() ->())?
    /// 点击某个label的回调
    var didSelectTitleLabel: ((_ titleLabel: SMTitleLabel) ->())?
    /// 向外界传递titles的数组
    var titlesClosure: ((_ titleArray: [String])->())?
    ///记录当前选中的下标
    private var currentIndex = 0
    ///记录上一个下标
    private var oldIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    
}


class SMTitleLabel: UILabel {
    //
    var currentScale: CGFloat = 1.0{
        didSet {
//            transform = __CGAffineTransformMake(<#T##a: CGFloat##CGFloat#>, <#T##b: CGFloat##CGFloat#>, <#T##c: CGFloat##CGFloat#>, <#T##d: CGFloat##CGFloat#>, <#T##tx: CGFloat##CGFloat#>, <#T##ty: CGFloat##CGFloat#>)
        }
    }
    
}
