//
//  SMHomeViewController.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/5/31.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit

class SMHomeViewController: SMBaseViewController {
    
    //首页顶部标题
    var homeTitles = ["推荐","热点","上海","视频","社会","娱乐","科技","问答","汽车","财经","军事","体育","段子","美女","国际","趣图","健康","特卖","房产","duo","duo"];
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = UIScreen.main.bounds
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view!.backgroundColor = SMGlobalColor()
        automaticallyAdjustsScrollViewInsets = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = SMColor(r: 210, g: 63, b: 66, a: 1.0)
        view.addSubview(scrollView)
    }
    
    
    
}


extension SMHomeViewController: UIScrollViewDelegate {
    
}
