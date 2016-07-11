//
//  PopoverPresentationController.swift
//  swiftWeiBo
//
//  Created by GG on 16/7/4.
//  Copyright © 2016年 GG. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    
    override func containerViewWillLayoutSubviews() {
        
        let view = UIView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PresentationController.clickContainerView))
        
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = UIColor(white: 0.0,alpha: 0.2)
        
        view.frame = (self.containerView?.frame)!
        
        self.containerView?.insertSubview(view, atIndex: 0)
        
        self.presentedView()?.frame = CGRectMake(100, 56, 200, 200)
        
    }
    
    func clickContainerView() {
        
        self.presentedViewController .dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    
}
