//
//  SMHomeTopicController.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/6/2.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit

let topicSmallCellID = "SMHomeSmallCell"
let topicMiddleCellID = "SMHomeMiddleCell"
let topicLargeCellID = "SMHomeLargeCell"
let topicNoImageCellID = "SMHomeNoImageCell"

class SMHomeTopicController: UITableViewController {

    ///上一次选中的tabbar index
    var lastSelectedIndex = Int()
    
    private var pullRefreshTime: TimeInterval?
    
    var topTitle: SMHomeTopTitleModel? = nil
    
    var newsTopics = [SMNewsTopicModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setRefresh()
    }

    
    private func setRefresh() {
        pullRefreshTime = NSDate().timeIntervalSince1970
        SMNetworkTool.shareNetworkTool.loadHomeCategoryNewsFeed(category: topTitle!.category!, tableView: tableView) { [weak self] (nowTime, newsTopics) in
            self!.pullRefreshTime = nowTime
            self!.newsTopics = newsTopics
            self!.tableView.reloadData()
        }
    }
    
    private func setupUI() {
        self.definesPresentationContext = true
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 49, right: 0)
        
        //注册cell
        tableView.register(SMHomeSmallCell.self, forCellReuseIdentifier: topicSmallCellID)
        tableView.register(SMHomeMiddleCell.self, forCellReuseIdentifier: topicMiddleCellID)
        tableView.register(SMHomeLargeCell.self, forCellReuseIdentifier: topicLargeCellID)
        tableView.register(SMHomeNoImageCell.self, forCellReuseIdentifier: topicNoImageCellID)
        tableView.estimatedRowHeight = 97
        
        tableView.tableHeaderView = homeSearchBar
        
        NotificationCenter.default.addObserver(self, selector: #selector(tabBarSelected), name: NSNotification.Name(rawValue: SMTabBarDidSelectedNotification), object: nil)
    }
    
    @objc private func tabBarSelected() {
        if lastSelectedIndex == tabBarController?.selectedIndex {
            tableView.mj_header.beginRefreshing()
        }
        lastSelectedIndex = tabBarController!.selectedIndex
    }
    
    private func showPopView(filterWords: [SMFilterWord], point: CGPoint) {
//        let popVC = <#value#>
        
    }
    
    private lazy var homeSearchBar: SMHomeSearchBar = {
        let homeSearchBar = SMHomeSearchBar()
        homeSearchBar.searchBar.delegate = self
        homeSearchBar.frame = CGRect(x: 0, y: 0, width: SCREENW, height: 44)
        return homeSearchBar
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SMHomeTopicController: UITextFieldDelegate {
    
    // MARK: -UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsTopics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsTopic = newsTopics[indexPath.row]
        
        if newsTopic.image_list.count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: topicSmallCellID, for: indexPath) as! SMHomeSmallCell
            cell.newsTopic = newsTopic
            cell.closeButtonClick(closure: { [weak self] (filterWords) in
                // closeButton 相对于 tableView 的坐标
                let point = self!.view.convert(cell.frame.origin, from: tableView)
                
                let convertPoint = CGPoint(x: point.x, y: point.y + cell.closeButton.y)
                //self!.showPopView(filterWords, point: convertPoint)
            })
            return cell
        } else {
            if newsTopic.middle_image?.height != nil {
                if newsTopic.video_detail_info?.video_id != nil || newsTopic.large_image_list.count != 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: topicLargeCellID, for: indexPath) as! SMHomeLargeCell
                    cell.newsTopic = newsTopic
                    cell.closeButtonClick(closure: { [weak self] (filterWords) in
                        // closeButton 相对于 tableView 的坐标
                        let point = self!.view.convert(cell.frame.origin, from: tableView)
                        let convertPoint = CGPoint(x:point.x, y:point.y + cell.closeButton.y)
                        //self!.showPopView(filterWords, point: convertPoint)
                    })
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: topicMiddleCellID, for: indexPath) as! SMHomeMiddleCell
                    cell.newsTopic = newsTopic
                    cell.closeButtonClick(closure: { [weak self] (filterWords) in
                        // closeButton 相对于 tableView 的坐标
                        let point = self!.view.convert(cell.frame.origin, from: tableView)
                        let convertPoint = CGPoint(x:point.x, y:point.y + cell.closeButton.y)
//                        self!.showPopView(filterWords, point: convertPoint)
                    })
                    return cell
                }
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: topicNoImageCellID, for: indexPath) as! SMHomeNoImageCell
                cell.newsTopic = newsTopic
                cell.closeButtonClick(closure: { [weak self] (filterWords) in
                    // closeButton 相对于 tableView 的坐标
                    let point = self!.view.convert(cell.frame.origin, from: tableView)
                    let convertPoint = CGPoint(x:point.x, y:point.y + cell.closeButton.y)
                    //self!.showPopView(filterWords, point: convertPoint)
                })
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let newTopic = newsTopics[indexPath.row]
        return newTopic.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -20 {
            scrollView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        }
    }
}
















