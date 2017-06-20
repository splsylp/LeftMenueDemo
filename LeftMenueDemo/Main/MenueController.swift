//
//  MenueController.swift
//  LeftMenueDemo
//
//  Created by Tony on 2017/6/20.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class MenueController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = RGB_COLOR(0, g: 0, b: 0, alpha: 0.80)
        
        let btn = UIButton(frame: CGRect(x: 20 + SCREEN_WIDTH * (1 - FullDistanceScale), y: 100, width: 100, height: 50))
        btn.setTitle("点我啊！", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = RED_COLOR()
        btn.addTarget(self, action: #selector(btnClicked), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
    }
    
    func btnClicked() {
        
        let drawer = rootViewController()
        drawer.showHome()
        
        let tab = rootViewController().rootViewController as TabBarController
        let navController = tab.viewControllers![tab.selectedIndex] as! NavigationController
        navController.pushViewController(TestController(), animated: true)
    }
}
