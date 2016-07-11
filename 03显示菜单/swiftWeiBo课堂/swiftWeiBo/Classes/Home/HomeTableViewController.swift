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
        menuVC.transitioningDelegate = self
        
    
        self.presentViewController(menuVC, animated: true, completion: nil)
        
    }
    
    deinit{
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    //用于判断消失还是显示
    var isPresent = false
 
}


// MARK: -UIViewControllerTransitioningDelegate
extension HomeTableViewController:UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning{
    
    
    
    /**
     告诉系统谁负责展示样式
     
     - parameter presented:  将要展示的控制器
     - parameter presenting: 发起跳转的控制器
     
     - returns: 告诉系统谁负责展示样式
     
     */
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?{
        
        return PoperPresentationController(presentedViewController: presented, presentingViewController: presenting)
        
    }
    
    //显示时谁负责动画
    // 返回的对象要遵守UIViewControllerAnimatedTransitioning协议
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        isPresent = true
        return self
        
    }
    
    // 消失时谁负责动画
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        isPresent = false
        return self
        
    }
    
    //设置动画时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        
        
        return 0.5
    }
    
    //获取动画的上下文，transitionContext能得到动画的所有信息，试图显示和消失都会调用这个方法
    
    // 实现这个方法，动画就需要再这里自定义，系统动画动画效果会消失
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        //获取到控制器
//        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
//        let fromeVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        
      
  NSNotificationCenter.defaultCenter().postNotificationName(kMenuViewShowORHide, object: nil)
        
        if isPresent == true {
            
            //找到要显示的试图
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
            
            //将toView放在容器试图上面
            transitionContext.containerView()?.addSubview(toView!)
            
            //设置锚点,设置动画的开始位置
            toView?.layer.anchorPoint = CGPointMake(0.5, 0)
            
            //首先将y轴缩放为0
            toView?.transform = CGAffineTransformMakeScale(1, 0)
            
            //设置动画
            UIView.animateWithDuration(0.5, animations: {
                
                //恢复到原来的尺寸
                toView?.transform = CGAffineTransformIdentity
                
            }) { (_) in
                
                //动画结束告诉上下文
                transitionContext.completeTransition(true)
                
            }
            

        }else{
            
            //找到要消失的试图
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            //设置锚点,设置动画的开始位置
            fromView?.layer.anchorPoint = CGPointMake(0.5, 0)
            
            //设置消失动画
            UIView.animateWithDuration(0.5, animations: { 
                
                //将y轴缩放为0,CGFloat有时稍微不准确
                fromView?.transform = CGAffineTransformMakeScale(1, 0.00001)
                
                
              }, completion: { (_) in
                    
                 //动画完成一定要告诉上下文
                transitionContext.completeTransition(true)
            })
            

        }
        
        


        
        
        
    }
    
    //试图显示和消失完毕都会调用这个方法
    func animationEnded(transitionCompleted: Bool){
        
        
        
    }

    
    
    
}











