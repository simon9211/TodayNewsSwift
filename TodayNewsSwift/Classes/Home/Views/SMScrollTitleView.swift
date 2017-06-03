//
//  SMScrollTitleView.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/5/31.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class SMScrollTitleView: UIView {
    
    ///存放标题模型的数组
    var titles = [SMHomeTopTitleModel]()
    ///存放标题label的数组
    var labels = [SMTitleLabel]()
    ///存放label宽度的数组
    var labelWidths = [CGFloat]()
    /// + 号点击回调
    var addBtnClickClosure: (() ->())?
    /// 点击某个label的回调
    var didSelectTitleLabel: ((_ titleLabel: SMTitleLabel) ->())?
    /// 向外界传递titles的数组
    var titlesClosure: ((_ titleArray: [SMHomeTopTitleModel])->())?
    ///记录当前选中的下标
    var currentIndex = 0
    ///记录上一个下标
    var oldIndex = 0
    
    ///设置滚动视图
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    ///设置 + 按钮
    lazy var addButton: UIButton = {
        let addButton = UIButton(type: .custom)
        addButton.setImage(UIImage(named: "add_channel_titlbar_16x16_"), for: .normal)
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.addTarget(self, action: #selector(addButtonClick), for: .touchUpInside)
        return addButton
    }()
    
    func addButtonClick() {
        addBtnClickClosure!()
    }
    
    ///添加按钮闭包
    func addButtonClickClosure(closure:@escaping ()->()) {
        addBtnClickClosure = closure
    }
    
    
    
    ///暴露给外界，告知外界点击了哪个titlelabel
    func didSelectTitleLabelClosure(closure:@escaping (_ titleLabel: SMTitleLabel)->()) {
        didSelectTitleLabel = closure
    }
    /// 暴露给外界，向外界传递 topic 数组
    func titleArrayClosure(closure:@escaping (_ titleArray: [SMHomeTopTitleModel])->()) {
        titlesClosure = closure
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        ///获取首页顶部标题数据
        SMNetworkTool.shareNetworkTool.loadHomeTitlesData { [weak self](topTitles) in
            ///
            let dict = ["category":"__all__","name":"推荐"]
            let recommend = SMHomeTopTitleModel(dict: dict as [String : AnyObject])
            self?.titles.append(recommend)
            self?.titles += topTitles
            print(topTitles)
            self?.setupUI()
        }
    }
    
    ///
    private func setupUI() {
        addSubview(scrollView)
        addSubview(addButton)
        
        ///布局
        scrollView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.right.equalTo(addButton.snp.left)
        }
         addButton.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self)
            make.width.equalTo(30)
        }
        
        setupTitlesLabel()
        setupLabelsPosition()
        titlesClosure?(titles)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension SMScrollTitleView {
    
    ///add label
    func setupTitlesLabel() {
        for (index,topic) in titles.enumerated() {
            let label = SMTitleLabel()
            label.text = topic.name
            label.tag = index
            label.textColor = KHomeTitleNomalColor
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            label.font = UIFont.systemFont(ofSize: 17)
            label.sizeToFit()
            label.width += kMargin
            labels.append(label)
            labelWidths.append(label.width)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tap:)))
            label.addGestureRecognizer(tap)
            
            scrollView.addSubview(label)
        }
        let currentLabel = labels[currentIndex]
        currentLabel.textColor = .white
        currentLabel.currentScale = KHomeTitleLabelSelectedScale
    }
    
    ///set labels position
    func setupLabelsPosition() {
        var titleX: CGFloat = 0.0
        let titleY: CGFloat = 0.0
        var titleW: CGFloat = 0.0
        let titleH: CGFloat = self.height
        
        for (index, label) in labels.enumerated() {
            titleW = labelWidths[index]
            titleX = kMargin
            if index != 0 {
                let lastLabel = labels[index - 1]
                titleX = lastLabel.frame.maxX + kMargin
            }
            label.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
        }
        
        ///set contentsize
        if let lastLabel = labels.last {
            scrollView.contentSize = CGSize(width: lastLabel.frame.maxX, height: 0)
        }
    }
    
    ///label gesture action
    func titleLabelClick(tap: UITapGestureRecognizer) {
        guard let currentLabel = tap.view as? SMTitleLabel else {
            return
        }
        oldIndex = currentIndex
        currentIndex = currentLabel.tag
        if oldIndex == 0 || oldIndex != currentIndex {
            let oldLabel = labels[oldIndex]
            oldLabel.textColor = KHomeTitleNomalColor
            oldLabel.currentScale = 1.0
            adjustTitleOffSetToCurrentIndex(currentIndex: currentIndex, oldIndex: oldIndex)
            didSelectTitleLabel?(currentLabel)
        }
    }
    
    func adjustTitleOffSetToCurrentIndex(currentIndex: Int, oldIndex: Int) {
        guard oldIndex != currentIndex else {
            return
        }
        ///reset
        let currentLabel = labels[currentIndex]
        currentLabel.textColor = .white
        currentLabel.currentScale = KHomeTitleLabelSelectedScale
        let oldLabel = labels[oldIndex]
        oldLabel.textColor = KHomeTitleNomalColor
        oldLabel.currentScale = 1.0
        var offsetX = (currentLabel.centerX - SCREENW / 2.0 > 0) ? (currentLabel.centerX - SCREENW / 2.0) : 0
        
        let maxOffsetX = (scrollView.contentSize.width - (SCREENW - addButton.width)) > 0 ? (scrollView.contentSize.width - (SCREENW - addButton.width)) : 0
        
        offsetX = offsetX > maxOffsetX ? maxOffsetX : offsetX
        
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    override var frame: CGRect {
        didSet {
            let newFrame = CGRect(x: 0, y: 0, width: SCREENW, height: 44)
            super.frame = newFrame
        }
    }
    
}


class SMTitleLabel: UILabel {
    //
    var currentScale: CGFloat = 1.0{
        didSet {
            transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
        }
    }
    
}
