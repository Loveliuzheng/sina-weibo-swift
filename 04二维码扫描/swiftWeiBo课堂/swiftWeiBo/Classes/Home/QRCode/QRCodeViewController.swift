//
//  QRCodeViewController.swift
//  swiftWeiBo
//
//  Created by GG on 16/7/7.
//  Copyright © 2016年 GG. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController {

    //scanBGView的高
    @IBOutlet weak var scanBGViewHeight: NSLayoutConstraint!
    
    //冲击波试图与顶部的约束
    @IBOutlet weak var sacnLineTop: NSLayoutConstraint!
    
    //冲击波试图
    @IBOutlet weak var scanlineView: UIImageView!
    
    /// tabBar
    @IBOutlet weak var customTabBar: UITabBar!
    
    //关闭扫描
    @IBAction func closeScan(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       //给tabBar设置一个默认选中的item
       self.customTabBar.selectedItem = self.customTabBar.items![0]
        
        
    }
    
    // 动画要在试图完全显示出来以后再开始
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.startAnimation()
        
        self.startScan()
    
    }
    
    //开始扫描
    private func startScan(){
        
        //1、判断是否支持输入设备
        if self.session.canAddInput(self.inputDevice) == false {
            
            return
        }
        
        //2、判断是否支持输出设备
        if self.session.canAddOutput(self.outPut) == false {
            
            return
            
        }
        
        //3、添加输入设备
        self.session .addInput(self.inputDevice)
        
        //4. 添加输出设备
        self.session.addOutput(self.outPut)
        
        //5. 设置输出设备支持的类型
        outPut.metadataObjectTypes = outPut.availableMetadataObjectTypes
        
        //6、设置代理，用于获取扫描的内容
        outPut.setMetadataObjectsDelegate(self, queue:dispatch_get_main_queue() )
        
        //7、添加图层
        self.view.layer.insertSublayer(self.previewLayer, atIndex: 0)
        
        //8、开始扫描
        
        self.session .startRunning()
        
        
    }
    
    //开始动画
    private func startAnimation(){
    
        //先让冲击波试图处于扫描试图的上面
        self.sacnLineTop.constant = -self.scanBGViewHeight.constant
        //更新约束
        self.view.layoutIfNeeded()
        
        UIView.animateWithDuration(2) {
            
        //重复动画
        UIView.setAnimationRepeatCount(MAXFLOAT)
            
            //设置冲击波试图的终点
            self.sacnLineTop.constant = self.scanBGViewHeight.constant
            //更新约束
            self.view.layoutIfNeeded()

        }
        
    }
    
    
    // MARK: - 有关扫描的懒加载
    
    //1、获取到扫描会话
    private lazy var session:AVCaptureSession = AVCaptureSession()
    
    //2. 获取到输入设备
    private lazy var inputDevice:AVCaptureDeviceInput? = {
       
       let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)

        
        //模拟器不支持摄像头，
        do{
            
          return try! AVCaptureDeviceInput(device: device)

            
        }catch{
            
            print(error)
            return nil
        }
        
    }()
    
    //3. 获取到输出设备
    private lazy var outPut:AVCaptureMetadataOutput =  AVCaptureMetadataOutput()
    
    
    //4.获取到预览图层,需要给当前的扫描会话
    private lazy var previewLayer:AVCaptureVideoPreviewLayer = {
       
        let player = AVCaptureVideoPreviewLayer(session: self.session)
        
        player.frame = self.view.frame
        
        //5. 设置填充模式,不设置填充模式，4s可能会出现问题
        player.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        return player
        
    }()
    
   
    
    
    
    
    
   
    

}


// MARK: - UITabBarDelegate
extension QRCodeViewController:UITabBarDelegate,AVCaptureMetadataOutputObjectsDelegate {
    
    //点击tabBarItem时调用
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        
        self.scanBGViewHeight.constant = item.tag == 0 ? 300 : 300*0.5
        
        self.view.layoutIfNeeded()
        
        //移除掉原来的动画
        self.scanlineView.layer.removeAllAnimations()
        
        //重新开始动画
        self.startAnimation()
        
    }
    
    //获取扫描结果
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        print(metadataObjects.last)
        
    }

    

    
    
}
