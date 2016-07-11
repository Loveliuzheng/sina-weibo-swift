//
//  HomeTableViewController.swift
//  swift新浪微博
//
//  Created by GG on 16/7/3.
//  Copyright © 2016年 GG. All rights reserved.
//

import UIKit

//菜单试图显示与消失的通知名字
let kMenuViewShowORHide = "kMenuViewShowORHide"

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         *  利用可选链优化拆包
         */
       self.nologinView?.setNoLoginViewisHome(true, imageName: "visitordiscover_feed_image_house", text: "关注一些人，回这里看看有什么惊喜")
        
        self.setNavigationBar()
        
        
        //监听菜单栏的显示与消失
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeTableViewController.change), name: kMenuViewShowORHide, object: nil)
    }
    
    
    func change()  {
        
        let titleBtn = self.navigationItem.titleView as! TitleButton
        
        titleBtn.selected = !titleBtn.selected
        
    }
    
    
    
    //MARK:设置navigatinBar
    func setNavigationBar()  {
        
        //设置titleView
        if userLogin == true {
            
            let btn = TitleButton(type: .Custom)
            
            btn.setTitleColor(UIColor.darkTextColor(), forState: .Normal)
            
            btn.setTitle("涅槃广广", forState: .Normal)
            
            btn.sizeToFit()
            
            self.navigationItem.titleView = btn
            
            btn.addTarget(self, action:#selector(HomeTableViewController.clickTitleBtn(_:)), forControlEvents: .TouchUpInside)
            
            
            //设置两侧的barButtonItem
            self.navigationItem.leftBarButtonItem = UIBarButtonItem().customBarButtonItem(self, selector: #selector(HomeTableViewController.homeclickLeft), imageName: "navigationbar_friendattention")
            
            //设置两侧的barButtonItem
            self.navigationItem.rightBarButtonItem = UIBarButtonItem().customBarButtonItem(self, selector: #selector(HomeTableViewController.homeclickRight), imageName: "navigationbar_pop")
        }
        
    }
    
    func homeclickRight() {
        
        //找到storyBoard
        let sb = UIStoryboard(name: "QRCodeViewController", bundle: nil)
        
        //选择要加载的控制器
        
        //instantiateInitialViewController 找到storyboard中左边带箭头的控制器
        
        //instantiateViewControllerWithIdentifier在storyBoard根据标识符找到相应的控制器
      let QRCodeVC = sb.instantiateInitialViewController()
        
      self.presentViewController(QRCodeVC!, animated: true, completion: nil)
        

    }
    
    func homeclickLeft()  {
        
       
    }
    
    func clickTitleBtn(sender:UIButton) {
        
        
//      sender.selected = !sender.selected
        
        
        let menuVC = MenuViewController()
        
        //设置转场动画
//        menuVC.modalTransitionStyle = .FlipHorizontal
        
        //设置模态控制器的展现样式为自定义
        
       // 如果不自定义，模态控制器会将当前控制器给移除，然后显示在window上，
        
       // 若自定义，模态控制器会直接显示在当前控制器的上面
        menuVC.modalPresentationStyle = .Custom
        
        //因为在代理方法里面自定义，所以要挂代理
        menuVC.transitioningDelegate = self.poperAnimationC

    
        self.presentViewController(menuVC, animated: true, completion: nil)
        
    }
    
    //控制动画和展示样式的对象
    private var poperAnimationC:PoperAnimationController = {
       
        let vc = PoperAnimationController()
        
        vc.poperFrame = CGRectMake(100,57,200,250)
        
        return vc
        
    }()
    

    deinit{
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}



