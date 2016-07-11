//
//  HomeTableViewController.swift
//  swift新浪微博
//
//  Created by GG on 16/7/3.
//  Copyright © 2016年 GG. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {

    override func viewDidLoad() {
        super.viewDidLoad()
   
        if self.userLogin == false {
        
          self.visistorView?.setVisistorViewisHome(true, imageName: "visitordiscover_feed_image_house", text: "关注一些人，回这里看看有什么惊喜")
        
        }
        
    
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.createBarButtonItem("navigationbar_friendattention", target: self, action: #selector(HomeTableViewController.clickLeft))
        
         self.navigationItem.rightBarButtonItem = UIBarButtonItem.createBarButtonItem("navigationbar_pop", target: self, action: #selector(HomeTableViewController.clickRight))
        
        let titleBtn = TitleButton()
        
        titleBtn.setTitle("涅槃广广", forState: .Normal)
        
        titleBtn.sizeToFit()
        
        titleBtn.addTarget(self, action: #selector(HomeTableViewController.clickTitleView(_:)), forControlEvents: .TouchUpInside)
        
        self.navigationItem.titleView = titleBtn
        
        
        
    }
    
    func clickTitleView(sender:UIButton) {
        
        sender.selected  = !sender.selected
        
        let vc = MenuViewController()
        vc.modalTransitionStyle = .FlipHorizontal
        vc.modalPresentationStyle = .Custom
        vc.transitioningDelegate = self
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    func clickLeft()  {
        
        print("clickLeft")
    }
    
    func clickRight()  {
        
        print("clickRight")
    }
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        return PresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
     var isPresent = false
    /**
     告诉系统谁来负责model的展现动画
     
     - parameter presented:  被展现的试图
     - parameter presenting: 发起的试图
     
     - returns: 谁来负责
     */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        isPresent = true
        return self;
        
    }
    
   
    /**
     谁来负责model的消失动画
     
     - parameter dismissed: 被关闭的试图
     
     - returns: 谁来负责
     */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        isPresent = false
        return self
        
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        
        return 0.5
        
    }
    
    //transitionContext 上下文，里面保存了动画需要的所有参数
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        
        if isPresent == true {
            
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
            
            transitionContext.containerView()?.addSubview(toView!)
            
            toView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            
            toView?.transform = CGAffineTransformMakeScale(1, 0)
            
            UIView.animateWithDuration(0.5, animations: {
                
                toView?.transform = CGAffineTransformIdentity
                
            }) { (_) in
                
                transitionContext.completeTransition(true)
            }

        }else{
            
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            transitionContext.containerView()?.addSubview(fromView!)
            
            fromView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            
            UIView.animateWithDuration(0.5, animations: {
                
                    fromView?.transform = CGAffineTransformMakeScale(1, 0.00001)
                
//                fromView?.transform = CGAffineTransformIdentity
                
            }) { (_) in
                
                transitionContext.completeTransition(true)
            }

        }
        
       
    }
    
    //告诉系统动画，无论是显示还是消失都会调用这个方法
    func animationEnded(transitionCompleted: Bool){
        
        
        
        
    }
    
    
 
}
