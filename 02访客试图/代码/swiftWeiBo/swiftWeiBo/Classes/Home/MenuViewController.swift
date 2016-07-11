//
//  MenuViewController.swift
//  swiftWeiBo
//
//  Created by GG on 16/7/4.
//  Copyright © 2016年 GG. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    
    override func viewDidLoad() {
        
        self.layoutUI()
        
    }
    
    var tableView = UITableView(frame: CGRectMake(0, 0, 0, 0), style: .Plain)
    //MARK: 布局试图
    func layoutUI() {
        
        var image = UIImage(named: "popover_background")
        
        image = image?.resizableImageWithCapInsets(UIEdgeInsetsMake((image?.size.height)!/2, 0, (image?.size.width)!/2, 0),resizingMode: .Stretch)
        
        let imageView = UIImageView(image: image)
        
        self.view = imageView
        
        self.view.addSubview(tableView)
        self.tableView .snp_makeConstraints { (make) in
            
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(20, 20, 20, 20))
            
        }
                
    }

}
