//
//  HomeTableViewController.swift
//  swift新浪微博
//
//  Created by GG on 16/7/3.
//  Copyright © 2016年 GG. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         *  利用可选链优化拆包
         */
       self.nologinView?.setNoLoginViewisHome(true, imageName: "visitordiscover_feed_image_house", text: "关注一些人，回这里看看有什么惊喜")
        
        
        if userLogin == true {
            
            let btn = TitleButton(type: .Custom)
            
            btn.setTitleColor(UIColor.darkTextColor(), forState: .Normal)
            
            btn.setTitle("涅槃广广", forState: .Normal)
            
            btn.sizeToFit()
            
            self.navigationItem.titleView = btn
            
            btn.addTarget(self, action:#selector(HomeTableViewController.clickTitleBtn(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    func clickTitleBtn(sender:UIButton) {
        sender.selected = !sender.selected
        print("点击titleBtn")
    }
 
}
