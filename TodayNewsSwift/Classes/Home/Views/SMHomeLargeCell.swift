//
//  SMHomeBigCell.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/6/6.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit

class SMHomeLargeCell: SMHomeTopicCell {
    
        var newsTopic: SMNewsTopicModel? {
            didSet{
                titleLabel.text = String(newsTopic!.title!)
                timeLabel.text = NSString.changeDateTime(publish_time: newsTopic!.publish_time!)
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
                
                filterWords = (newsTopic?.filter_words)!
                
                var urlString = String()
                
                if let videoDetailInfo = newsTopic?.video_detail_info {
                    // 说明是视频
                    urlString = videoDetailInfo.detail_video_large_image!.url!
                    /// 格式化时间
                    let minute = Int(newsTopic!.video_duration! / 60)
                    let second = newsTopic!.video_duration! % 60
                    rightBottomLabel.text = String(format: "%02d:%02d", minute, second)
                } else { // 说明是大图
                    playButton.isHidden = true
                    urlString = newsTopic!.large_image_list.first!.url!
                    rightBottomLabel.text = "\(newsTopic!.gallary_image_count!)图"
                }
                let url = URL(string: urlString)
                largeImageView.kf.setImage(with: url?.downloadURL)
                if let label = newsTopic?.label {
                    if label == "" {
                        stickLabel.isHidden = true
                    } else {
                        stickLabel.setTitle(" \(label) ", for: .normal)
                        stickLabel.isHidden = false
                    }
                }
            }
        }
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            addSubview(largeImageView)
            
            largeImageView.addSubview(rightBottomLabel)
            
            largeImageView.addSubview(playButton)
            
            largeImageView.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(kMargin)
                make.left.equalTo(titleLabel.snp.left)
                make.right.equalTo(titleLabel.snp.right)
                make.size.equalTo(CGSize(width: SCREENW - 30, height: 170))
            }
            
            rightBottomLabel.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize(width: 50, height: 20))
                make.right.equalTo(largeImageView.snp.right).offset(-7)
                make.bottom.equalTo(largeImageView.snp.bottom).offset(-7)
            }
            
            playButton.snp.makeConstraints { (make) in
                make.center.equalTo(largeImageView)
            }
        }
        
        /// 中间的播放按钮
        private lazy var playButton: UIButton = {
            let playButotn = UIButton()
            playButotn.setImage(UIImage(named: "playicon_video_60x60_"), for: .normal)
            playButotn.sizeToFit()
            playButotn.addTarget(self, action: #selector(playButtonClick), for: .touchUpInside)
            return playButotn
        }()
        
        /// 右下角显示图片数量或视频时长
        lazy var  rightBottomLabel: UILabel = {
            let rightBottomLabel = UILabel()
            rightBottomLabel.textAlignment = .center
            rightBottomLabel.layer.cornerRadius = 10
            rightBottomLabel.layer.masksToBounds = true
            rightBottomLabel.font = UIFont.systemFont(ofSize: 13)
            rightBottomLabel.textColor = UIColor.white
            rightBottomLabel.backgroundColor = SMColor(r: 0, g: 0, b: 0, a: 0.6)
            return rightBottomLabel
        }()
        
        /// 中间大图
        private lazy var largeImageView: UIImageView = {
            let largeImageView = UIImageView()
            largeImageView.backgroundColor = UIColor.lightGray
            return largeImageView
        }()
            
        /// 播放按钮点击
        func playButtonClick() {
            
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

