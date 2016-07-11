//
//  MainViewController.swift
//  swift新浪微博
//
//  Created by GG on 16/7/3.
//  Copyright © 2016年 GG. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.tabBar.tintColor = UIColor.orangeColor()
        
       self.addTabBarChildren()
        
       
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
         self.setupEditBtn()
        
        
    }
    
    
    //MARK:添加中间加号按钮
    private func setupEditBtn(){
        
        let screenW = UIScreen.mainScreen().bounds.size.width
        
        let btnW = screenW/CGFloat((self.viewControllers?.count)!)
        let btnH:CGFloat = 49
        let btnY:CGFloat = 0
        let btnX = btnW * 2
        
        let editBtn = UIButton(type: .Custom)
        editBtn.frame = CGRectMake(btnX, btnY, btnW, btnH)
        
        
        editBtn.setBackgroundImage(UIImage(named:"tabbar_compose_button"), forState: .Normal)
        editBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        
    editBtn.setImage(UIImage(named:"tabbar_compose_icon_add"), forState: UIControlState.Normal)
    editBtn.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        self.tabBar.addSubview(editBtn)
        
        editBtn.addTarget(self, action: #selector(MainViewController.clickAdd), forControlEvents: .TouchUpInside)
    }
    
    func clickAdd() {
        
       print("点击加号")
        
    }
    
    //MARK:添加子控制器
    private func addTabBarChildren(){
        
    self.addChildController("HomeTableViewController", title: "首页", image: "tabbar_home", selectedImage:"tabbar_home_highlighted")
    self.addChildController("MessageTableViewController", title: "消息", image: "tabbar_message_center", selectedImage:"tabbar_message_center_highlighted")
        
    self.addChildController("EditViewController", title: "", image: "", selectedImage: "")
    self.addChildController("DiscoverTableViewController", title: "广场", image: "tabbar_discover", selectedImage:"tabbar_discover_highlighted")
    self.addChildController("ProfileTableViewController", title: "我", image: "tabbar_profile", selectedImage:"tabbar_profile_highlighted")

    }
    
    private func addChildController(className:String,title:String,image:String,selectedImage:String){
        
        let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        let claName:AnyClass = NSClassFromString(nameSpace + "." + className)!
        
        let vcCla = claName as! UIViewController.Type
        
        let vc = vcCla.init()
        vc.title = title
        vc.tabBarItem.image = UIImage(named: image)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImage)
        
        let nav = UINavigationController(rootViewController: vc)
        self.addChildViewController(nav)
     
    }
   
        
    

}