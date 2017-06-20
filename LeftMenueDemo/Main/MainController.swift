//
//  MainController.swift
//  LeftMenueDemo
//
//  Created by Tony on 2017/6/20.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    private var mainView = UIView()
    public  var rootViewController: TabBarController!
    private var menueViewController: MenueController!
    
    private var panGesture = UIPanGestureRecognizer()
    
    private var middleView: UIView! // 构造主视图
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化视图
        initMain()
        
        // 添加手势
        addPanGesture()
    }
    
    //加载主页面
    func initMain() {
        
        // 初始化middleView
        middleView = UIView(frame: self.view.frame)
        self.view.addSubview(middleView)
        
        // 在middleView上添加子视图
        rootViewController = TabBarController()
        middleView.addSubview(rootViewController!.view)
        
        // 添加左滑视图
        menueViewController = MenueController()
        menueViewController.view.frame.origin.x = -SCREEN_WIDTH
        self.view.addSubview(menueViewController.view)
    }
    
    // 添加拖动手势
    func addPanGesture() {
        panGesture.addTarget(self, action: #selector(self.panAction(_:)))
        middleView.addGestureRecognizer(panGesture)
    }
    
    // 移除拖动手势
    func removePanGesture() {
        middleView.removeGestureRecognizer(panGesture)
    }
    
    //【拖动Middle时的响应】响应 UIPanGestureRecognizer 手势事件
    func panAction(_ recongnizer: UIPanGestureRecognizer) {
        let offsetX = recongnizer.translation(in: self.view).x
        
        if offsetX >= 0 {
            menueViewController.view.frame.origin.x = -SCREEN_WIDTH + offsetX
        }
        
        if recongnizer.state == UIGestureRecognizerState.ended {
            
            // 如果滑动超过1/2，则显示左抽屉
            if offsetX > SCREEN_WIDTH * (FullDistanceScale / 2.0) {
                showLeft()
            } else {
                //显示主页
                showHome()
            }
        }
    }
    
    // 展示左视图，添加手势
    func showLeft() {
        doTheAnimate("left")
    }
    
    // 展示主视图，移除手势
    func showHome() {
        
        UIView.animate(withDuration: 0.30, animations: {
            self.menueViewController.view.frame.origin.x = -SCREEN_WIDTH
        })
        
        mainView.removeFromSuperview()
        
        doTheAnimate("home")
    }
    
    func mainViewDidTap() {
        showHome()
    }
    
    func doTheAnimate(_ showWhat: String) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            if showWhat == "left" {
                self.menueViewController.view.frame.origin.x = -SCREEN_WIDTH + self.view.frame.size.width * FullDistanceScale
                
                let mainViewX = self.menueViewController.view.frame.origin.x + self.menueViewController.view.frame.size.width
                self.mainView = UIView(frame: CGRect(x: mainViewX, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
                self.view.addSubview(self.mainView)
                
                // 添加点击手势
                let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(self.mainViewDidTap))
                self.mainView.addGestureRecognizer(tapGes)
                
                // 添加返回滑动手势
                let backPanGes = UIPanGestureRecognizer.init(target: self, action: #selector(self.recoverPanGes))
                self.mainView.addGestureRecognizer(backPanGes)
                
            } else {
                self.mainView.removeFromSuperview()
            }
            
        }, completion: nil)
    }
    
    // 返回滑动手势处理
    var startX = CGFloat()
    func recoverPanGes(pan: UIPanGestureRecognizer) {
        
        if (pan.state == UIGestureRecognizerState.began) {
            startX = menueViewController.view.frame.origin.x
        }
        
        let offsetX = pan.translation(in: self.view).x
        menueViewController.view.frame.origin.x = startX + offsetX
        
        
        if (pan.state == UIGestureRecognizerState.ended) {
            
            let menueShowWidth = SCREEN_WIDTH + menueViewController.view.frame.origin.x // 左滑现展露出的宽度
            
            // 如果滑动超过1/2，则显示左抽屉
            if menueShowWidth > (SCREEN_WIDTH * FullDistanceScale / 2) {
                UIView.animate(withDuration: 0.2, animations: {
                    self.menueViewController.view.frame.origin.x = -SCREEN_WIDTH + self.view.frame.size.width * FullDistanceScale
                })
                
            } else {
                showHome()
            }
        }
    }
}
