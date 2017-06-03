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
}
