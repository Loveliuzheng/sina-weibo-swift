//
//  NoLoginView.swift
//  swiftWeiBo
//
//  Created by GG on 16/7/5.
//  Copyright © 2016年 GG. All rights reserved.
//

import UIKit

class NoLoginView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //添加试图
        self.addSubview(self.maskBGView)
        self.addSubview(self.circleView)
        self.addSubview(self.noteLabel)
        self.addSubview(self.iconView)
        
        //给子试图布局
        self.addLayout()
        
    }
    
    //MARK: 留接口设置各模块的置空样式
    func setNoLoginViewisHome(isHome:Bool,imageName:String,text:String){
    
        self.circleView.hidden = !isHome
        
        self.iconView.image = UIImage(named: imageName)
        
        self.noteLabel.text = text
        
        if isHome == true {
            
            self.startAnimation()
            
        }
        
    }
    
    //开始动画
    func startAnimation()  {
        
        //创建一种核心动画对象,keyPath指定什么样的动画
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        //设置动画的结束
        animation.toValue = 2 * M_PI
        animation.duration = 14
        animation.repeatCount = MAXFLOAT
        
        //动画结束以后不移除
        animation.removedOnCompletion = false
        
        //将动画添加到试图的layer层
        self.circleView.layer.addAnimation(animation, forKey: nil)
        
    }
    

    //MARK:给试图添加约束
    private func addLayout()  {
        
        self.maskBGView.snp_makeConstraints { (make) in
            make.edges.equalTo(self).inset(0)
        }
        
        self.circleView.snp_makeConstraints { (make) in
            
            make.center.equalTo(self)
            
        }
        
        
        self.noteLabel.snp_makeConstraints { (make) in
            
            make.width.equalTo(240)
            
            make.top.equalTo(self.circleView.snp_bottom).offset(10)
            
            make.centerX.equalTo(circleView.snp_centerX)
        }
        
        self.iconView.snp_makeConstraints { (make) in
            
            make.center.equalTo(self)
            
        }

    }
    
    
    //MARK: 懒加载创建试图
    
    /// 背景试图
    private lazy var maskBGView:UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "visitordiscover_feed_mask_smallicon")
        
        return imageView
        
    }()
    
    //圈图
    private lazy var circleView:UIImageView = {
       
        let imageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        
        
        return imageView
        
    }()
    
    //提示语
    
    private lazy var noteLabel:UILabel = {
        
       let label = UILabel()
        
       label.font = UIFont.systemFontOfSize(17)
       label.textColor = UIColor.darkGrayColor()
       label.text = "世纪东方绿卡圣诞节疯狂了就爱上了咖啡加拉克束带结发垃圾啊失联飞机拉斯克奖的疯狂拉升减肥抵抗力"
       label.numberOfLines = 0
        
        return label
        
    }()
    
    //模块的icon图标
    private lazy var iconView:UIImageView = {
       
        let imageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        
        return imageView
        
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
     * 如果父类中有required的构造方法，子类一旦重写任何构造方法，都必须实现父类中require修饰的方法
     
     * 从xib加载试图时调用
     */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

}
