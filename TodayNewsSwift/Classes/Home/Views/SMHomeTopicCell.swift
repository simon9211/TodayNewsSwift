//
//  SMHomeTopicCell.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/6/4.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit
import SnapKit

class SMHomeTopicCell: UITableViewCell {

    var filterWords = [SMFilterWord]()
    var closeButtonClosure: ((_ filterWords: [SMFilterWord])->())?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(avatarImageView)
        
        contentView.addSubview(nameLabel)
        
        contentView.addSubview(commentLabel)
        
        contentView.addSubview(timeLabel)
        
        contentView.addSubview(stickLabel)
        
        contentView.addSubview(closeButton)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(kHomeMargin)
            make.right.equalTo(self).offset(-kHomeMargin)
        }
    
        avatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.bottom.equalTo(self.snp.bottom).offset(-kHomeMargin)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp.right).offset(5)
            make.centerY.equalTo(avatarImageView)
        }
        
        commentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.centerY.equalTo(nameLabel)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(commentLabel.snp.right).offset(5)
            make.centerY.equalTo(avatarImageView)
        }
        
        stickLabel.snp.makeConstraints { (make) in
            make.left.equalTo(timeLabel.snp.right).offset(5)
            make.centerY.equalTo(avatarImageView)
            make.height.equalTo(15)
        }
        
        closeButton.snp.makeConstraints { (make) in
            make.right.equalTo(titleLabel.snp.right)
            make.centerY.equalTo(avatarImageView)
            make.size.equalTo(CGSize(width: 17, height: 12))
        }
        
    }
    
    ///置顶 热 广告 视屏
    lazy var stickLabel: UIButton = {
        let stickLabel = UIButton()
        stickLabel.isHidden = true
        stickLabel.layer.cornerRadius = 3
        stickLabel.layer.masksToBounds = true
        stickLabel.sizeToFit()
        stickLabel.isUserInteractionEnabled = false
        stickLabel.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        stickLabel.setTitleColor(SMColor(r: 241, g: 91, b: 94, a: 1.0), for: .normal)
        stickLabel.layer.borderColor = SMColor(r: 241, g: 91, b: 94, a: 1.0).cgColor
        stickLabel.layer.borderWidth = 0.5
        return stickLabel
    }()
    
    /// 新闻标题
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    /// 用户头像
    lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        return avatarImageView
    }()
    
    /// 用户名
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor = UIColor.lightGray
        return nameLabel
    }()
    
    /// 评论
    lazy var commentLabel: UILabel = {
        let commentLabel = UILabel()
        commentLabel.font = UIFont.systemFont(ofSize: 12)
        commentLabel.textColor = UIColor.lightGray
        return commentLabel
    }()
    
    /// 时间
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.lightGray
        return timeLabel
    }()
    
    /// 举报按钮
    lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named: "add_textpage_17x12_"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonAtion), for: .touchUpInside)
        return closeButton
    }()
    
    func closeButtonAtion() {
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
