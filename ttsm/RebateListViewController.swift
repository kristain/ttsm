//
//  RebateListViewController.swift
//  ttsm
//
//  Created by kristain on 16/8/16.
//  Copyright © 2016年 kristain. All rights reserved.
//

import UIKit
import SDWebImage

class RebateListViewController: MainViewController,DataRequestDelegate, UIScrollViewDelegate{
    
    private lazy var shareView: ShareView = ShareView.shareViewFromXib()
    private lazy var backBtn: UIButton = UIButton()
    private lazy var sharedBtn: UIButton = UIButton()
    
    private var signUpBtn: UIButton!
    
    private var tipLable: UILabel!
    
    var rebateView: RebateView!
    
    var rebate_type = ""
    
    private lazy var customNav: UIView = {
        let customNav = UIView(frame: CGRectMake(0, 0, AppWidth, NavigationH))
        customNav.backgroundColor = UIColor.whiteColor()
        customNav.alpha = 0.0
        return customNav
    }()
    
    
    var tableView = UITableView()
    var items1 = [AppsCellModel]()
    var items2 = [RebateModel]()
    
    var success_item: AppsCellModel!
    
    var request = DataRequest()
    
    //下拉刷新控件
    var header = MJRefreshNormalHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化导航条上的内容
        setCustomNavigationItem()
        
        tableView = UITableView(frame: CGRectMake(0, 0, AppWidth, AppHeight-400), style: UITableViewStyle.Plain)
        tableView.dataSource = self
        tableView.delegate = self
        
        //进行网络请求
        request = DataRequest()
        request.delegate = self
        self.pleaseWait()
        
        request.rebateListRequest( "",customer_id: NSUserDefaults.standardUserDefaults().valueForKey("customer_id") as! String,  scene_id:  NSUserDefaults.standardUserDefaults().valueForKey("scene_id") as! String)
        
        //MJ进行下拉刷新
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(AppListViewController.downRefresh))
        
        //MJ上拉加载
        self.tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(AppListViewController.upRefresh))
        self.view.addSubview(tableView)
        setUpBottomView()
       
    }

    //实现协议DataRequestDelegate的方法
    func transforValue(item1: AnyObject, item2: AnyObject, countMoney: Double, countMoneyRate: Double) {
        self.clearAllNotice()
        self.items1 = item1 as! [AppsCellModel]
        if(self.items1.count > 0){
            self.tableView.reloadData()
            rebateView = NSBundle.mainBundle().loadNibNamed("RebateView", owner: nil, options: nil).last as!  RebateView
            rebateView.frame = CGRectMake(0, AppHeight-400, AppWidth, 250)
            rebateView.phone.text = NSUserDefaults.standardUserDefaults().valueForKey("auth_code") as? String
            self.view.addSubview(rebateView)
            
            self.items2 = item2 as! [RebateModel]
            rebateView.huafeiBtn.enabled = false
            rebateView.hongbaobtn.enabled = false
            rebateView.weixinBtn.enabled = false
           
            if(self.items2.count > 0){
                for var i = 0; i<self.items2.count; i = i + 1{
                    if(self.items2[i].rebate_name == "weixin_readpacket"){
                        rebateView.weixinBtn.setTitle("拟得微信红包共\(countMoneyRate)元" , forState: .Normal)
                        if(countMoneyRate >= Double(self.items2[i].amount)){
                            rebateView.weixinBtn.enabled = true
                            rebateView.weixinBtn.setSelected(true)
                        }
                    }else if(self.items2[i].rebate_name == "deduction"){
                        rebateView.hongbaobtn.setTitle("本店拟可抵用共\(countMoney)元" , forState: .Normal)
                        if(countMoney >= Double(self.items2[i].amount)){
                             rebateView.hongbaobtn.enabled = true
                        }
                        print("本店拟可抵用共\(countMoney)元");
                    }else{
                        if(countMoneyRate >= Double(self.items2[i].amount)){
                            rebateView.huafeiBtn.enabled = true
                        }
                        rebate_type = self.items2[i].rebate_name
                        rebateView.huafeiBtn.setTitle("\(self.items2[i].rebate_desc_list)共\(countMoneyRate)元" , forState: .Normal)
                         rebateView.huafeiBtn.setTitle("\(self.items2[i].rebate_desc_list)(不可用)" , forState: .Disabled)
                    }
                }
            }
        }else{
            setNoneView();
            signUpBtn.enabled = false
            
        }
       
    }
    
    //实现协议DataRequestDelegate的方法
    func transforValue(item1: AnyObject) {
        self.clearAllNotice()
        self.errorNotice("网络错误")
    }
    
    func transforSuccess(item3: AnyObject) {
        //let suVC = SuccessViewController()
        //navigationController!.pushViewController(suVC, animated: true)
        self.success_item = item3 as! AppsCellModel
        let cityVC = SuccessViewController()
        cityVC.amount = success_item.amount
        cityVC.customer_name = success_item.customer_name
        cityVC.errors = success_item.errors
        cityVC.time = success_item.time
        cityVC.rebate_type = success_item.rebate_type
        cityVC.rebate_type_desc = success_item.rebate_type_desc
        cityVC.num = success_item.num
        cityVC.order_no = success_item.order_no
        
        let nav = MainNavigationController(rootViewController: cityVC)
        presentViewController(nav, animated: true, completion: nil)
    }
    
    private func setCustomNavigationItem() {
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),
                                                            NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 16.0)!]
        navigationItem.title = "拟奖励信息"
        // 添加分享按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "share_0", highlImageName: "share_2", targer: self, action: #selector(RebateListViewController.sharedBtnClick))
        // 添加返回按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .Done, target: self, action: #selector(RebateListViewController.backButtonClick))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = theme.SDBackgroundColor

    }
    
    override func prefersStatusBarHidden()-> Bool{
        return false;
    }
    
    /**
     Description:下拉刷新实现方法
     */
    func downRefresh(){
        self.tableView.mj_header.beginRefreshing()
        request = DataRequest()
        request.rebateListRequest( "",customer_id: NSUserDefaults.standardUserDefaults().valueForKey("customer_id") as! String,  scene_id:  NSUserDefaults.standardUserDefaults().valueForKey("scene_id") as! String)
        self.tableView.reloadData()
        self.tableView.mj_header.endRefreshing()
    }

    private func setNoneView(){
       let noneView = NSBundle.mainBundle().loadNibNamed("NoneView", owner: nil, options: nil).last as!  UIView
        noneView.frame = CGRectMake(0, 0, AppWidth, AppHeight - 400)
        self.view.addSubview(noneView)
    }
    
    
    private func setUpBottomView() {
        // 添加底部报名View
        let bottomView = UIView(frame: CGRectMake(0, AppHeight - NavigationH-20, AppWidth, NavigationH))
        bottomView.backgroundColor = UIColor(red: 0.996, green: 0.502, blue: 0.290, alpha: 1)
        view.addSubview(bottomView)
        
        signUpBtn = UIButton()
        //signUpBtn.setBackgroundImage(UIImage(named: "qfl"), forState: .Disabled)
        signUpBtn.frame = CGRectMake((AppWidth - 158) * 0.5, (49 - 36) * 0.5, 158, 36)
        signUpBtn.setTitle("提交核准 立即到账", forState: .Normal)
        signUpBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        signUpBtn.addTarget(self, action: #selector(RebateListViewController.signUpBtnClick), forControlEvents: .TouchUpInside)
        bottomView.addSubview(signUpBtn)
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //清除磁盘和内存中的缓存
        SDImageCache.sharedImageCache().clearDisk()
        SDImageCache.sharedImageCache().clearMemory()
    }
}

/// MARK:- 所有按钮的事件
extension RebateListViewController {
    
    /// 分享
    func sharedBtnClick() {
        shareView.shareVC = self
        let shareModel = ShareModel(shareTitle: theme.ShareTitle, shareURL: theme.ShareURL, image: UIImage(named: "author"), shareDetail: theme.ShareDetail)
        shareView.shareModel = shareModel
        view.addSubview(shareView)
        shareView.showShareView(CGRectMake(0, AppHeight - theme.ShareViewHeight - NavigationH-20, AppWidth, theme.ShareViewHeight))
    }
    
    /// 返回
    func backButtonClick() {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /// 提交
    func signUpBtnClick() {
        
        let regex = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        guard predicate.evaluateWithObject(rebateView.phone.text) else{
            self.clearAllNotice()
            self.errorNotice("手机号码错误!")
            return
        }
        if(!rebateView.hongbaobtn.selected && !rebateView.huafeiBtn.selected && !rebateView.weixinBtn.selected){
            self.clearAllNotice()
            self.errorNotice("请选择奖励")
            return
        }
      
        if(rebateView.hongbaobtn.selected){
            rebate_type = "deduction"
        }else if(rebateView.weixinBtn.selected){
            rebate_type = "weixin_readpacket"
        }
        if(rebate_type != ""){
            request = DataRequest()
            request.delegate = self
            request.doRebateRequest(rebateView.phone.text!, rebate_type: rebate_type, auth_code: NSUserDefaults.standardUserDefaults().valueForKey("auth_code") as! String, customer_id: NSUserDefaults.standardUserDefaults().valueForKey("customer_id") as! String, scene_id: NSUserDefaults.standardUserDefaults().valueForKey("scene_id") as! String)
        }else{
             self.errorNotice("不支持奖励")
            
           
        }
    }
    
    //更改城市监听事件
    func cityChange(noti: NSNotification) {
        if let currentCityName = noti.object as? String {
            self.cityRightBtn.setTitle(currentCityName, forState: .Normal)
            print("更改城市:\(currentCityName)")
        }
    }
   

    
}

