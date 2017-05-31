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

/// 屏幕的宽
let SCREENW = UIScreen.main.bounds.size.width
/// 屏幕的高
let SCREENH = UIScreen.main.bounds.size.height

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
