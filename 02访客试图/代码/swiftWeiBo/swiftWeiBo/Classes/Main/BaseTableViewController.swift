//
//  BaseTableViewController.swift
//  swiftWeiBo
//
//  Created by GG on 16/7/3.
//  Copyright © 2016年 GG. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    var userLogin = false
    
    var visistorView:VisitorView?
    
    override func loadView() {
        
        userLogin ? super.loadView() : self.setVisitorView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    private func setVisitorView() {
        
        self.visistorView = VisitorView()
        self.visistorView!.backgroundColor = UIColor.whiteColor()
        self.view = self.visistorView
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: #selector(BaseTableViewController.registerClick))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: #selector(BaseTableViewController.loginClick))
        
    }
    
    func registerClick()  {
        
        print("注册")
    }
    
    func loginClick()  {
        
        print("登录")
    }


}
