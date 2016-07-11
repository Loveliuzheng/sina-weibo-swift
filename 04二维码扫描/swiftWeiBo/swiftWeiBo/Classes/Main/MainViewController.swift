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
        
        /**
         *  tinColor: tabBarItem的颜色
         
         *  barTintColor: tabbar的颜色
         */
        self.tabBar.tintColor = UIColor.orangeColor()
        
        self.addTabBarVC()
        
    }
    
    //MARK: 建议在viewWillAppear中设置子控件的frame
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
         self.addMidBtn()
        
        
    }
    
    /// 将btn设置为全局变量
    let btn = UIButton(type: .Custom)
    
    //MARK:添加中间按钮
    private func addMidBtn(){
        
       btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        
       btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState:.Highlighted)
        
       btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        
       btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        
        //设置btnFrame
       let screenW = UIScreen.mainScreen().bounds.size.width
        
       let btnW = screenW / CGFloat((self.viewControllers?.count)!)
        let btnH:CGFloat = 49
        let btnX:CGFloat = 2 * btnW
        let btnY:CGFloat = 0
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH)
        
        self.tabBar.addSubview(btn)
       
        btn.addTarget(self, action: #selector(MainViewController.clickBtn), forControlEvents: .TouchUpInside)
        
    }
    
    func clickBtn() {
        
        print("点击加号")
    }
    
    //MARK: 添加子控制器
    private func addTabBarVC(){
        
    self.addTabBarChildrenVC("HomeTableViewController", title: "首页", imageName: "tabbar_home")
        
    self.addTabBarChildrenVC("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
        
    self.addTabBarChildrenVC("NilViewController", title: "", imageName: "")
    self.addTabBarChildrenVC("DiscoverTableViewController", title: "发现", imageName: "tabbar_discover")
        
    self.addTabBarChildrenVC("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
    }
    

    private func addTabBarChildrenVC(className:String,title:String,imageName:String){
        
        /*
         * 将字符串类名转化为类
         
          1、动态的获取命名空间
          2、拼接类名： 命名空间 + . + 类名
          3、将拼接好的类名转化为一个类
          4、指定是哪一种类
          5、利用该类创建对象
         
          PS：工程名中有中文的话，记得在product name修改成英文，设置为全英文，不能有空格
         
         OC打印一个类
         
           <ViewController: 0x7ff9ea79a450>
         
           UIViewController *VC =  [[NSClassFromString(@"UIViewController") alloc]init];
         
         swift打印一个类
         
           <swiftWeiBo.MainViewController: 0x7ff15a599e90>
         
           var claName:AnyClass =  NSClassFromString("swiftWeiBo" + "." + "UIViewController")!
         
         */
        
        /*
           动态获取命名空间: 命名空间就是用来区分完全相同的类，举个栗子
         
              一班，二班都有教叫小明的，我喊一声『一班的小明』，『一班』就是命名空间
         */
        let namespace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        //swift中字符串转化为一个类
        let claName:AnyClass =  NSClassFromString(namespace + "." + className)!
        
        //指定claName是一个控制器类
        let claVC = claName as! UIViewController.Type
        
        //用转化成控制器的类创建一个对象
        let vc = claVC.init()
        
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        let nav = UINavigationController(rootViewController: vc)
        
        self.addChildViewController(nav)
        
    }
    
}






