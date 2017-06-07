//
//  SMHomeViewController.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/5/31.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit

class SMHomeViewController: SMBaseViewController {
    
    var oldIndex: Int = 0
    
    
    //首页顶部标题
    //var homeTitles = ["推荐","热点","上海","视频","社会","娱乐","科技","问答","汽车","财经","军事","体育","段子","美女","国际","趣图","健康","特卖","房产","duo","duo"];
    var homeTitles = [SMHomeTopTitleModel]()
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: SCREENW, height: SCREENH)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
    
    /// 顶部标题
    lazy var titleView: SMScrollTitleView = {
        let titleView = SMScrollTitleView()
        return titleView
    }()
    
    lazy var addTopticVC: SMAddTopicViewController = {
        return SMAddTopicViewController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        homeTitleViewCallBack()
        addTopicItem()
    }
    
    ///设置ui
    private func setupUI() {
        view!.backgroundColor = SMGlobalColor()
        automaticallyAdjustsScrollViewInsets = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = SMColor(r: 210, g: 63, b: 66, a: 1.0)
        navigationItem.titleView = titleView
        view.addSubview(scrollView)
    }
    
    /// 处理标题回调
    private func homeTitleViewCallBack() {
        // 返回标题数量
        titleView.titleArrayClosure { [weak self] (titleArray) in
            self?.homeTitles = titleArray
            //归档标题数据
            self!.archiveTitles(titles: titleArray)
            for topTitle in titleArray {
                let topicVC = SMHomeTopicController()
                topicVC.topTitle = topTitle
                self!.addChildViewController(topicVC)
            }
            self!.scrollViewDidEndDecelerating((self!.scrollView))
            self!.scrollView.contentSize = CGSize(width: SCREENW * CGFloat(titleArray.count), height: SCREENH)
        }
        
        // + 回调
        titleView.addButtonClickClosure { [weak self] in
            self?.addTopticVC.myTopics = self!.homeTitles
            let navi = SMNavigationController(rootViewController: self!.addTopticVC)
            self!.present(navi, animated: true, completion: nil)
            print("add button")
        }
        
        /// 点击了哪个titlelabel回调
        titleView.didSelectTitleLabelClosure { [weak self] (titleLabel) in
            var offset = self!.scrollView.contentOffset
            offset.x = CGFloat((titleLabel.tag)) * (self!.scrollView.width)
            self!.scrollView.setContentOffset(offset, animated: true)
            print(titleLabel.text ?? "没有")
        }
        
    }
    
    ///处理 + 后 点击item的回调
    private func addTopicItem() {
        addTopticVC.didAddTopictItemClosure { [weak self](itemTopic) in
            print(itemTopic.name!)
            var isContain: Bool = false
            for (index,item) in self!.homeTitles.enumerated() {
                if item.name == itemTopic.name {
                    self!.titleView.adjustTitleOffSetToCurrentIndex(currentIndex: index, oldIndex: self!.oldIndex)
                    isContain = true
                    break
                } else {
                    continue
                }
            }
            if !isContain {
                self!.titleView.titles.append(itemTopic)
                self!.titleView.setupUI()
                self!.titleView.adjustTitleOffSetToCurrentIndex(currentIndex: self!.homeTitles.count - 1, oldIndex: self!.oldIndex)
            }
        }
    }
    
    ///归档标题数据
    private func archiveTitles(titles: [SMHomeTopTitleModel]) {
        let path: NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as NSString
        let filePath = path.appendingPathComponent("top_titles.archive")
        
        NSKeyedArchiver.archiveRootObject(titles, toFile: filePath)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}


extension SMHomeViewController: UIScrollViewDelegate {
    
    // MARK: -UIScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        // current index
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        let vc = childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        self.oldIndex = index
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        titleView.adjustTitleOffSetToCurrentIndex(currentIndex: index, oldIndex: oldIndex)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
