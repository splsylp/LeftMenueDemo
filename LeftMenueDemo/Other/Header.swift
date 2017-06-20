//
//  Header.swift
//  LeftMenueDemo
//
//  Created by Tony on 2017/6/20.
//  Copyright © 2016年 Tony. All rights reserved.
//

import UIKit

// 屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
// 屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height


// RGB颜色
func RGB_COLOR(_ r:CGFloat, g:CGFloat, b:CGFloat, alpha:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
}

// 项目主颜色
func MAIN_COLOR() -> UIColor {
    return UIColor(red: 74/255.0, green: 163/255.0, blue: 243/255.0, alpha: 1.0)
}

// 红色
func RED_COLOR() -> UIColor {
    return UIColor(red: 252/255.0, green: 106/255.0, blue: 125/255.0, alpha: 1.0)
}

func rootViewController() -> MainController {
    return UIApplication.shared.keyWindow?.rootViewController as!MainController
}

let FullDistanceScale: CGFloat = 0.64 //侧滑最大距离的比例





