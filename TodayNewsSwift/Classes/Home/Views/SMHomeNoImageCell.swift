//
//  SMHomeNoImageCell.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/6/7.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit

class SMHomeNoImageCell: SMHomeTopicCell {

    
    var newsTopic: SMNewsTopicModel? {
        didSet{
            titleLabel.text = String(newsTopic!.title!)
            if let publishTime = newsTopic?.publish_time {
                timeLabel.text = NSString.changeDateTime(publish_time: publishTime)
            }
            
            if let sourceAvatar = newsTopic?.source_avatar {
                nameLabel.text = newsTopic!.source
                avatarImageView.setCircleHeader(url: sourceAvatar)
            }
            
            if let mediaInfo = newsTopic!.media_info {
                nameLabel.text = mediaInfo.name
                avatarImageView.setCircleHeader(url: mediaInfo.avatar_url!)
            }
            
            if let commentCount = newsTopic!.comment_count {
                commentCount >= 10000 ? (commentLabel.text = "\(commentCount / 10000)万评论") : (commentLabel.text = "\(commentCount)评论")
            } else {
                commentLabel.isHidden = true
            }
            
            filterWords = newsTopic!.filter_words
            if let label = newsTopic?.label {
                stickLabel.setTitle(" \(label) ", for: .normal)
                stickLabel.isHidden = false
                closeButton.isHidden = (label == "置顶") ?  true : false
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    /// 举报按钮点击
    override func closeButtonAtion() {
        closeButtonClosure!(filterWords)
    }
    
    /// 举报按钮点击回调
    func closeButtonClick(closure:@escaping (_ filterWords: [SMFilterWord])->()) {
        closeButtonClosure = closure
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
