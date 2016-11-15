//
//  SuccessViewController.swift
//  ttsm
//
//  Created by kristain on 16/8/18.
//  Copyright © 2016年 kristain. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController, DataRequestDelegate, UIActionSheetDelegate {
    
    private lazy var shareView: ShareView = ShareView.shareViewFromXib()
    
    private var signUpBtn: UIButton!
    
    private var shareBtn: UIButton!
    
    var errors: String!
    var order_no: String!
    var time: String!
    var rebate_type: String!
    var rebate_type_desc: String!
    var num: String!
    var amount: String!
    var customer_name: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // 初始化导航条上的内容
        setNav()
        
        
        setUpBottomView()
    }
    
    
    private func setNav() {
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),
                                                            NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 16.0)!]
        navigationItem.title = "成功奖励信息"
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = theme.SDBackgroundColor
        
       let sucView = NSBundle.mainBundle().loadNibNamed("SucView", owner: nil, options: nil).last as!  SucView
        sucView.frame = CGRectMake(0, 0, AppWidth, AppHeight - 90-41)
        view.addSubview(sucView)
        
        
        if(errors != ""){
            sucView.order.text = errors
           
        }else{
            if(order_no != ""){
                 sucView.order.text = "单号\(order_no)号奖励已成功发放"
                 sucView.time_text.text = "当前时间是\(time)"
                
                
                if(rebate_type == "weixin_readpacket"){
                    sucView.select_type.text = "你选择:微信奖励,"
                    sucView.fanli_text.text = "您有效选择\(num)个,红包金额共\(amount)元 请到微信拆红包"
                }else if(rebate_type == "deduction"){
                    sucView.select_type.text = "你选择:购物抵扣奖励,"
                    sucView.fanli_text.text = "您有效选择\(num)个,需店主抵用\(amount)元 请拿此页给本店店主查看。"
                    sucView.customer_name.text = "\(customer_name)"
                }else{
                    sucView.select_type.text = "你选择:\(rebate_type_desc)奖励,"
                    sucView.fanli_text.text = "您有效选择\(num)个,共\(amount)元"
                    sucView.customer_name.text = "\(customer_name)"
                }
                 sucView.label1.text = "如您觉得实际奖励金额与预计不一致时："
                 sucView.label2.text = "1.部分结果数据仍暂时未出，请隔5分钟再进入本页。"
                 sucView.label3.text = "2.你没有按要求正确进行相关操作（注册，复制邀请码，下单，绑卡等），没有正确输入您注册时用的手机号码。此时可联系客服。"
                 sucView.Label4.text = "3.部分APP的奖励结算时间还没到；请耐心等候。"
                 sucView.Label5.text = "4.本店仅抵用在本店扫码产生的奖励，非本店扫码产生的奖励不能在本店抵用。"
            }else{
                 sucView.order.text = "很抱歉，系统没能发送奖励"
                 sucView.order.textColor = UIColor.redColor()
                 sucView.label1.text = ""
                sucView.label2.text = "1.您没有正确输入您注册应用时的手机号码，或者没有按要求正确进行相关操作（如注册,登陆，填入邀请码,下单,绑卡,刷脸等）。"
                sucView.label3.text = "2.当前红包金额不足1.00元，无法发微信红包，请继续努力。"
                sucView.Label4.text = "3.当前红包发放繁忙，请重试。"
                sucView.Label5.text = "4.微信红包0点到8点休息，请您稍后再来吧。"
            }
           
        }
        
        
        
    }
    override func prefersStatusBarHidden()-> Bool{
        return false;
    }
    
    
    //实现协议DataRequestDelegate的方法
    func transforValue(item1: AnyObject) {
        
    }
    func transforValue(item1: AnyObject, item2: AnyObject, countMoney: Double, countMoneyRate: Double) {
        
    }

    
    func transforSuccess(item1: AnyObject) {
        
    }
    
    private func setUpBottomView() {
        let bottomView = UIView(frame: CGRectMake(0, AppHeight - NavigationH-20, AppWidth, NavigationH))
        bottomView.backgroundColor = UIColor(red: 0.996, green: 0.502, blue: 0.290, alpha: 1)
        view.addSubview(bottomView)
        
        signUpBtn = UIButton()
        //signUpBtn.setBackgroundImage(UIImage(named: "qfl"), forState: .Disabled)
        signUpBtn.frame = CGRectMake(0, (49 - 36) * 0.5, 158, 36)
        signUpBtn.setTitle("再去下载", forState: .Normal)
        signUpBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        signUpBtn.addTarget(self, action: #selector(SuccessViewController.backButtonClick), forControlEvents: .TouchUpInside)
        bottomView.addSubview(signUpBtn)
        shareBtn = UIButton()
        //signUpBtn.setBackgroundImage(UIImage(named: "qfl"), forState: .Disabled)
        shareBtn.frame = CGRectMake(AppWidth/2, (49 - 36) * 0.5, 158, 36)
        shareBtn.setTitle("分享", forState: .Normal)
        shareBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        shareBtn.addTarget(self, action: #selector(SuccessViewController.sharedBtnClick), forControlEvents: .TouchUpInside)
        
        bottomView.addSubview(shareBtn)
        
    }
    
    
}

/// MARK:- 所有按钮的事件
extension SuccessViewController {
    /// 返回
    func backButtonClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /// 分享
    func sharedBtnClick() {
        shareView.shareVC = self
        let shareModel = ShareModel(shareTitle: theme.ShareTitle, shareURL: theme.ShareURL, image: UIImage(named: "author"), shareDetail: theme.ShareDetail)
        shareView.shareModel = shareModel
        view.addSubview(shareView)
        shareView.showShareView(CGRectMake(0, AppHeight - theme.ShareViewHeight - NavigationH-20, AppWidth, theme.ShareViewHeight))
    }
    
}
