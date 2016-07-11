//
//  VisitorView.swift
//  swiftWeiBo
//
//  Created by GG on 16/7/3.
//  Copyright © 2016年 GG. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    func setVisistorViewisHome(isHome:Bool,imageName:String,text:String) {
        
        self.iconView.hidden = !isHome
        
        homeView.image = UIImage(named: imageName)
        messageLabel.text = text
        
        if isHome {
            
            self.startAnimation()
        }
        
       
        
    }
    
    func startAnimation()  {
        
        
        let  animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * M_PI
        animation.duration = 20
        animation.repeatCount = MAXFLOAT
        
        animation.removedOnCompletion = false
        
        iconView.layer.addAnimation(animation, forKey: nil)
        
        
        
    }
    

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        //添加子控件
        self.addSubview(iconView)
        self.addSubview(maskBGView)
        self.addSubview(homeView)
        self.addSubview(messageLabel)
        
        //布局子控件
        iconView.snp_makeConstraints { (make) in
            
            make.center.equalTo(self)
        }
        
        maskBGView.snp_makeConstraints { (make) in
            
            make.edges.equalTo(0)
            
        }
        
        homeView.snp_makeConstraints { (make) in
            
            make.center.equalTo(self)
        }
        
        messageLabel.snp_makeConstraints { (make) in
            
           make.width.equalTo(224)
            
           make.top.equalTo(iconView.snp_bottom)
            
            make.centerX.equalTo(iconView)
            
        }
        
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
    //MARK: 懒加载控件
    private lazy var iconView:UIImageView = {
        
        let image = UIImage(named: "visitordiscover_feed_image_smallicon")
        
        let iv = UIImageView(image:image)
        
        return iv
       
    }()
    
    private lazy var maskBGView:UIImageView = {
       
        let bgView = UIImageView(image:UIImage(named: "visitordiscover_feed_mask_smallicon"))
       
        return bgView
        
    }()
    
    private lazy var homeView:UIImageView = {
       
        let hV = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        
        return hV
        
    }()
    
    private lazy var messageLabel:UILabel = {
       
        let messagelabel = UILabel()
        
        messagelabel.textColor = UIColor.darkGrayColor()
        messagelabel.numberOfLines  = 0
        messagelabel.text = "阿里看电视就发了水电费加拉克是打飞机拉伸胜利大街菲利克斯解放路扣水电费的弗兰克就"
        
        return messagelabel
        
    }()

}
