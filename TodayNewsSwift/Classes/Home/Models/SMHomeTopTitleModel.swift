//
//  SMHomeTopTitleModel.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/6/1.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit

class SMHomeTopTitleModel: NSObject, NSCoding {

    var category: String? = ""
    var web_url: String? = ""
    var flags: Int? = 0
    var name:String? = ""
    var tip_new: Int? = 0
    var default_add: Int? = 0
    var concern_id: String? = ""
    var type: Int? = 0
    var icon_url: String? = ""
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        category = dict["category"] as? String
        web_url = dict["web_url"] as? String
        flags = dict["flags"] as? Int
        name = dict["name"] as? String
        tip_new = dict["tip_new"] as? Int
        default_add = dict["default_add"] as? Int
        concern_id = dict["concern_id"] as? String
        type = dict["type"] as? Int
        icon_url = dict["icon_url"] as? String
    }
    
    
    /*
     "category": "news_hot",
     "web_url": "",
     "flags": 0,
     "name": "热点",
     "tip_new": 0,
     "default_add": 1,
     "concern_id": "",
     "type": 4,
     "icon_url": ""
     */
    required init?(coder aDecoder: NSCoder) {
        super.init()
        category = aDecoder.decodeObject(forKey: "category") as! String?
        web_url = aDecoder.decodeObject(forKey: "web_url") as! String?
        flags = Int(aDecoder.decodeCInt(forKey: "flags"))
        name = aDecoder.decodeObject(forKey: "name") as! String?
        tip_new = Int(aDecoder.decodeCInt(forKey: "tip_new"))
        default_add = Int(aDecoder.decodeCInt(forKey: "default_add"))
        concern_id = aDecoder.decodeObject(forKey: "concern_id") as! String?
        type = Int(aDecoder.decodeCInt(forKey: "type"))
        icon_url = aDecoder.decodeObject(forKey: "icon_url") as! String?
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(category, forKey: "category")
        aCoder.encode(web_url, forKey: "web_url")
        aCoder.encode(flags, forKey: "flags")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(tip_new, forKey: "tip_new")
        aCoder.encode(default_add, forKey: "default_add")
        aCoder.encode(concern_id, forKey: "concern_id")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(icon_url, forKey: "icon_url")
    }
    
}
