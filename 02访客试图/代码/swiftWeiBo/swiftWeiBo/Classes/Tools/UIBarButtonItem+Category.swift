//
//  UIBarButtonItem+Category.swift
//  swiftWeiBo
//
//  Created by GG on 16/7/4.
//  Copyright © 2016年 GG. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    class func createBarButtonItem(imageName:String,target:AnyObject?,action:Selector) -> UIBarButtonItem{
        
        let btn = UIButton(type: .Custom)
        btn.frame = CGRectMake(0, 0, 30, 30)
        btn.setBackgroundImage(UIImage(named: imageName), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        return UIBarButtonItem(customView: btn)
        
        
    }
    
    
    
}