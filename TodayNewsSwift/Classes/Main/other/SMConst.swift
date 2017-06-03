//
//  SMConst.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/5/31.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

//　https://github.com/hrscy/TodayNews

import UIKit

let SMFirstLaunch = "firstLaunch"
let SMTabBarDidSelectedNotification = "SMTabBarDidSelectedNotification"

let IID: String = "5034850950"
let device_id: String = "6096495334"

let BASE_URL = "http://lf.snssdk.com/"
/// 是否登录
let isLogin = "isLogin"
/// code 码 200 操作成功
let RETURN_OK = 200
/// 间距
let kMargin: CGFloat = 10.0
/// 首页新闻间距
let kHomeMargin: CGFloat = 15.0
/// 圆角
let kCornerRadius: CGFloat = 5.0
/// 线宽
let klineWidth: CGFloat = 1.0
/// 首页顶部标签指示条的高度
let kIndicatorViewH: CGFloat = 2.0
/// 新特性界面图片数量
let kNewFeatureCount = 4
/// 顶部标题的高度
let kTitlesViewH: CGFloat = 35
/// 顶部标题的y
let kTitlesViewY: CGFloat = 64
/// 动画时长
let kAnimationDuration = 0.25


/// 屏幕的宽
let SCREENW = UIScreen.main.bounds.size.width
/// 屏幕的高
let SCREENH = UIScreen.main.bounds.size.height

let KHomeTitleNomalColor = SMColor(r: 235, g: 235, b: 235, a: 1.0)
let KHomeTitleLabelSelectedScale: CGFloat = 1.1


/// RGBA的颜色设置
func SMColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 背景灰色
func SMGlobalColor() -> UIColor {
    return SMColor(r: 245, g: 245, b: 245, a: 1)
}

/// 红色
func SMGlobalRedColor() -> UIColor {
    return SMColor(r: 245, g: 80, b: 83, a: 1.0)
}

/// iPhone 5
let isIPhone5 = SCREENH == 568 ? true : false
/// iPhone 6
let isIPhone6 = SCREENH == 667 ? true : false
/// iPhone 6P
let isIPhone6P = SCREENH == 736 ? true : false
