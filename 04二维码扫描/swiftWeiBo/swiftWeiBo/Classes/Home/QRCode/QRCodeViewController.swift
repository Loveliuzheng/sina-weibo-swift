//
//  QRCodeViewController.swift
//  swiftWeiBo
//
//  Created by GG on 16/7/6.
//  Copyright © 2016年 GG. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController {

    @IBOutlet weak var tabBar: UITabBar!
    
    //容器试图的高度
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scanLineView: UIImageView!
    
    

    
    //冲击波的顶部试图
    @IBOutlet weak var scanlineTop: NSLayoutConstraint!
    
    
    @IBAction func closeCode(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.selectedItem = self.tabBar.items![0]
        
        self.tabBar.delegate = self;
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.startAnimatation()
        
        self.startScan()
    }
    
    func startScan() {
        
        //关联输入输出对象
        //1. 判断能否添加输入设备
        if !self.session.canAddInput(self.inputService){
            
            return
        }
        
        //2. 判断能否添加输出对象
        if !self.session.canAddOutput(self.output){
            
            return
        }
        
        //3. 添加输入输出对象
        self.session.addInput(self.inputService)
        self.session.addOutput(self.output)
        
        //4、告诉输出对象，要输出什么类型的数据
        self.output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        //5. 设置代理监听输出对象的输出
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        //6. 添加图层
        view.layer.insertSublayer(self.previewLayer, atIndex: 0)
        
        //7. 开始扫描
        self.session.startRunning()
        
        
    }
    
    //MARK: 懒加载
    
    //1. 获取拍摄会话
    private lazy var session:AVCaptureSession = AVCaptureSession()
    
    //2. 获取输入设备
    private lazy var inputService:AVCaptureDeviceInput? = {
       
        let service = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do{
            // 模拟器没有摄像头
            return try AVCaptureDeviceInput(device: service)
        }catch{
            print(error)
            return nil
        }

        
    }()
    
    //3. 获取输出对象
    private lazy var output:AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    //4. 创建预览图层
    private lazy var previewLayer:AVCaptureVideoPreviewLayer = {
       
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        
        layer.frame = self.view.frame
        
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
      
        
        return layer
    
        
    }()
    
    
    
    
    func startAnimatation()  {
        
        
        self.scanlineTop.constant =  -self.containerViewHeight.constant
        
        self.view.layoutIfNeeded()
        
        UIView.animateWithDuration(2.0) {
            
           UIView.setAnimationRepeatCount(MAXFLOAT)
            
            self.scanlineTop.constant = self.containerViewHeight.constant
            self.view.layoutIfNeeded()
        }
        
    }

}

extension QRCodeViewController:UITabBarDelegate,AVCaptureMetadataOutputObjectsDelegate{
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
         print(item.tag)
        
        containerViewHeight.constant = item.tag == 0 ? 300 : 300*0.5
        
        
       self.scanLineView.layer.removeAllAnimations()
        
        self.startAnimatation()
    }
    
    // 监听扫描到得数据
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        print(metadataObjects.last)
    }
    
    
}
