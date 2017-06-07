//
//  SMHomeSmallCell.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/6/5.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit

class SMHomeSmallCell: SMHomeTopicCell {

    var newsTopic: SMNewsTopicModel? {
        didSet{
            titleLabel.text = newsTopic!.title as? String
            timeLabel.text = NSString.changeDateTime(publish_time: newsTopic!.publish_time!)
            if let sourceAvater = newsTopic?.source_avatar {
                nameLabel.text = newsTopic?.source
                avatarImageView.setCircleHeader(url: sourceAvater)
            }
            
            if let mediaInfo = newsTopic?.media_info {
                nameLabel.text = mediaInfo.name
                avatarImageView.setCircleHeader(url: mediaInfo.avatar_url!)
            }
            
            if let commentCount = newsTopic!.comment_count {
                commentCount >= 10000 ? (commentLabel.text = "\(commentCount / 10000)万评论") : (commentLabel.text = "\(commentCount)评论")
            } else {
                commentLabel.isHidden = true
            }
            
            filterWords = newsTopic!.filter_words
            
            if newsTopic!.image_list.count > 0 {
                for index in 0..<newsTopic!.image_list.count {
                    let imageView = UIImageView()
                    let imageList = newsTopic!.image_list[index]
                    let urlLlist = imageList.url_list![index]
                    let urlString = urlLlist["url"] as! NSString
                    if urlString.hasSuffix(".webp") {
                        let range = urlString.range(of: ".webp")
                        let url = urlString.substring(to: range.location)
                        let u = URL(string: url)
                        imageView.kf.setImage(with: u?.downloadURL)
                    } else {
                        let u = URL(string: urlString as String )
                        imageView.kf.setImage(with: u?.downloadURL)
                    }
                    let x: CGFloat = CGFloat(index) * (newsTopic!.imageW + 6)
                    imageView.frame = CGRect(x: x, y: 0, width: newsTopic!.imageW, height: newsTopic!.imageH)
                    imageView.backgroundColor = UIColor.lightGray
                    middleView.addSubview(imageView)
                }
            }
            
            if let label = newsTopic?.label {
                stickLabel.setTitle(" \(label) ", for: .normal)
                stickLabel.isHidden = false
            }
        }
    }
    
    /// 中间 3 张图的容器
    private lazy var middleView: UIView = {
        let middleView = UIView()
        return middleView
    }()
    
    override func closeButtonAtion() {
        closeButtonClosure!(filterWords)
    }
    
    func closeButtonClick(closure:@escaping (_ filterWords: [SMFilterWord])->()) {
        closeButtonClosure = closure
    }

}
