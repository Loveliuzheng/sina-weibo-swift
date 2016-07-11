//
//  PoperAnimationController.swift
//  swiftWeiBo
//
//  Created by GG on 16/7/7.
//  Copyright © 2016年 GG. All rights reserved.
//

import UIKit


class PoperAnimationController : NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning{
    
    
    //用于判断消失还是显示
    var isPresent = false
    
    //展示试图的尺寸
    var poperFrame:CGRect?
    
    /**
     告诉系统谁负责展示样式
     
     - parameter presented:  将要展示的控制器
     - parameter presenting: 发起跳转的控制器
     
     - returns: 告诉系统谁负责展示样式
     
     */
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?{
        
        
      let poperPresentC =  PoperPresentationController(presentedViewController: presented, presentingViewController: presenting)
        
        poperPresentC.poperFrame = self.poperFrame
        
        return poperPresentC
        
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
