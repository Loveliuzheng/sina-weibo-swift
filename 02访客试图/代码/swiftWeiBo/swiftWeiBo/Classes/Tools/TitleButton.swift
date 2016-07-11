//
//  TitleButton.swift
//  swiftWeiBo
//
//  Created by GG on 16/7/4.
//  Copyright © 2016年 GG. All rights reserved.
//

import Foundation
import UIKit
class TitleButton: UIButton {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.setTitleColor(UIColor.darkTextColor(), forState: .Normal)
        
        self.titleLabel?.font = UIFont.systemFontOfSize(17)
        
        self.setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
        
         self.setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Selected)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.titleLabel?.frame.origin.x = 0
        
        self.imageView?.frame.origin.x = (self.titleLabel?.frame.size.width)!
    }
    
}