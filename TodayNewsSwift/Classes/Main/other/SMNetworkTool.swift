//
//  SMNetworkTool.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/5/31.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import MJRefresh

class SMNetworkTool: NSObject {
    ///单例
    static let shareNetworkTool = SMNetworkTool()
 //********************************************首**页****************************************************/
    ///首页 获取topicTitleLabel
    func loadHomeTitlesData(finished:@escaping (_ topTitles: [SMHomeTopTitleModel]) ->()) {
        let url = BASE_URL + "article/category/get_subscribed/v1/?"
        let params = ["device_id":device_id,
                      "aid":13,
                      "iid":IID] as [String : Any]
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).downloadProgress { progress in
            print("download progress: \(progress.fractionCompleted)")
        }.responseData { (response) in
            if let data = response.result.value {
                let json = JSON(data)
                let dataDict = json["data"].dictionary
                if let data = dataDict!["data"]!.arrayObject  {
                    var topics = [SMHomeTopTitleModel]()
                    for dict in data {
//                        let dic = dict as! [String: AnyObject]
//                        let title = dic["name"] as! String
//                        topics.append(title)
//                        print(title)
                        let title = SMHomeTopTitleModel(dict: dict as! [String: AnyObject])
                        print(title)
                        topics.append(title)
                    }
                    finished(topics)
                }
            }
        }
    }
    
    /// 获取推荐标签
    func loadRecomendTopic(finished: @escaping (_ recommendTopics: [SMHomeTopTitleModel]) ->()) {
        let url = "https://lf.snssdk.com/article/category/get_extra/v1/?"
        let params = ["device_id": device_id,
                      "aid": 13,
                      "iid": IID] as [String : Any]
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).downloadProgress { (progress) in
            
        }.responseJSON { (response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            
            if let value = response.result.value {
                let json = JSON(value)
                let dataDict = json["data"].dictionary
                if let data = dataDict!["data"]!.arrayObject {
                    var topics = [SMHomeTopTitleModel]()
                    for dict in data {
                        let title = SMHomeTopTitleModel(dict: dict as![String: AnyObject])
                        topics.append(title)
                        print(title.name ?? "nil")
                    }
                    finished(topics)
                }
            }
        }
    }
    
    /// 根据标签获取新闻内容
    func loadHomeCategoryNewsFeed(category: String, tableView: UITableView, finished: @escaping(_ nowTime: TimeInterval, _ newsTopics: [SMNewsTopicModel])->()) {
        let url = BASE_URL + "api/news/feed/v39/?"
        let params = ["device_id": device_id,
                      "category": category,
                      "iid": IID]
        tableView.mj_header = MJRefreshHeader(refreshingBlock: { 
            let nowTime = NSDate().timeIntervalSince1970
            Alamofire
            .request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .responseJSON(completionHandler: { (response) in
                tableView.mj_header.endRefreshing()
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败")
                    return
                }
                if let value = response.result.value {
                    let json = JSON(value)
                    let datas = json["data"].array
                    var topics = [SMNewsTopicModel]()
                    for data in datas! {
                        let content = data["content"].stringValue
                        let contentData: NSData = content.data(using: String.Encoding.utf8)! as NSData
                        do {
                            let dict = try JSONSerialization.jsonObject(with: contentData as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            print(dict)
                            let topic = SMNewsTopicModel(dict: dict as! [String: AnyObject])
                            topics.append(topic)
                        } catch {
                            SVProgressHUD.showError(withStatus: "获取数据失败")
                        }
                    }
                    finished(nowTime,topics)
                }
            })
        })
        tableView.mj_header.isAutomaticallyChangeAlpha = true
        tableView.mj_header.beginRefreshing()
    }
    
    
}
