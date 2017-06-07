//
//  NSString+Extension.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/6/6.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit

extension NSString {
    
    //返回文字高度
    class func boundingRectWithString(string: NSString, size: CGSize, fontSize: CGFloat) -> CGFloat {
        return string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)], context: nil).size.height
    }
    
    ///处理日期
    class func changeDateTime(publish_time: Int) -> String {
        //把秒转成时间
        let publishTime = Date(timeIntervalSince1970: TimeInterval(publish_time))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
        let dleta = Date().timeIntervalSince(publishTime)
        
        if dleta <= 0 {
            return "刚刚"
        } else if dleta < 60 {
            return "\(Int(dleta))秒前"
        } else if dleta < 3600 {
            return "\(Int(dleta / 60))分钟前"
        } else {
            let calendar = Calendar.current
            let comp = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day,Calendar.Component.hour,Calendar.Component.minute,Calendar.Component.second], from: Date())
            let comp2 = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day,Calendar.Component.hour,Calendar.Component.minute,Calendar.Component.second], from: publishTime)
            if comp.year == comp2.year {
                if comp.day == comp2.day {
                    return "\(comp.hour! - comp2.hour!)小时前"
                } else {
                    return "\(comp2.month) - \(comp2.day) \(comp2.hour):\(comp2.minute)"
                }
            } else {
                return "\(comp2.year) - \(comp2.month) - \(comp2.day) \(comp2.hour):\(comp2.minute)"
            }            
        }

    }
    
}
