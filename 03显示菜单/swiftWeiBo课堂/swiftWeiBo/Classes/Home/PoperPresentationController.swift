//
//  PoperPresentationController.swift
//  swiftWeiBo
//
//  Created by GG on 16/7/6.
//  Copyright © 2016年 GG. All rights reserved.
//

import UIKit

class PoperPresentationController: UIPresentationController {


    //试图将要展示时调用
    override func containerViewWillLayoutSubviews() {
        
        //遮罩
        let view = UIView()
        view.backgroundColor = UIColor.blackColor()
        view.alpha = 0.3
        let tap = UITapGestureRecognizer(target: self, action: #selector(PoperPresentationController.clickmaskView))
        view.addGestureRecognizer(tap)
        view.frame = UIScreen.mainScreen().bounds
        
        //self.contaionerView容器试图，在容器试图上放遮罩
        self.containerView?.insertSubview(view, atIndex: 0)
        
        //展示的试图
        self.presentedView()?.frame = CGRectMake(100, 57, 200, 250)
        
        
    }
    
    func clickmaskView()  {
        
        //找到弹出的控制器，dismiss
        self.presentedViewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    
}
