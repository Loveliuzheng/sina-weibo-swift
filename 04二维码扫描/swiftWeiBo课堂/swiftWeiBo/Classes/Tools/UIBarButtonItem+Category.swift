//
//  UIBarButtonItem+Category.swift
//  swiftWeiBo
//
//  Created by GG on 16/7/6.
//  Copyright © 2016年 GG. All rights reserved.
//

import Foundation
import UIKit

// 给UIBarButtonItem添加类目
extension UIBarButtonItem {
    //设置按钮的target和方法
    func customBarButtonItem(target:AnyObject?,selector:Selector,imageName:String) -> UIBarButtonItem {
        
        let btn = UIButton(type: .Custom)
        
        btn.setBackgroundImage(UIImage(named: imageName), forState: .Normal)
        
        btn.setBackgroundImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        
        btn.frame = CGRectMake(0, 0, 40, 40)
        
        btn.addTarget(target, action: selector, forControlEvents: .TouchUpInside)
        
        return UIBarButtonItem(customView: btn)

    }
    
    
    
}
