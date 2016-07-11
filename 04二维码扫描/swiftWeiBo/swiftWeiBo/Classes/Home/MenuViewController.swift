//
//  MenuViewController.swift
//  swiftWeiBo
//
//  Created by GG on 16/7/6.
//  Copyright © 2016年 GG. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clearColor()
        
        
        self.layoutUI()
        
        
    }
    
    // MARK: 布局试图
    func layoutUI()  {
        
        //背景试图
        let imageView = UIImageView()
        var image = UIImage(named: "popover_background")
        //上下拉伸，水平的边距设为0，并设置为拉伸样式
        image = image?.resizableImageWithCapInsets(UIEdgeInsetsMake(image!.size.height/2, 0, image!.size.height/2, 0), resizingMode: .Stretch)
        imageView.image = image
        self.view.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            
            make.edges.equalTo(self.view).inset(0)
        }
        
        //tableView
        let tableView = UITableView(frame: CGRectMake(0, 0, 0, 0), style: .Plain)
        self.view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) in
            
            make.edges.equalTo(self.view).inset(20)
            
        }
        
    
    }

    
}
