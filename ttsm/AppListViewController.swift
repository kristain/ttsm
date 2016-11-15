//
//  AppListController.swift
//  ttsm
//
//  Created by kristain on 16/8/14.
//  Copyright © 2016年 kristain. All rights reserved.
//

import UIKit
import SDWebImage

class AppListViewController: MainViewController,DataRequestDelegate, UIScrollViewDelegate {

    private lazy var shareView: ShareView = ShareView.shareViewFromXib()
    
    var tableView = UITableView()
    var items1 = [AppsCellModel]()

    
    var request = DataRequest()
    
    private lazy var likeBtn: UIButton = UIButton()
    
    //下拉刷新控件
    var header = MJRefreshNormalHeader()
    
    
    var selectedRow: Int = 0
    var items: [DropdownItem]!
    
    var area_num:String = "1"
    var sort: String = "2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        // 初始化导航条上的内容
        setNav()
        
        tableView = UITableView(frame: CGRectMake(0, 0, AppWidth, AppHeight-NavigationH), style: UITableViewStyle.Plain)
        tableView.dataSource = self
        tableView.delegate = self
        
        //进行网络请求
        request = DataRequest()
        request.delegate = self
        self.pleaseWait()
        request.appListRequest(NSUserDefaults.standardUserDefaults().valueForKey("customer_id") as! String, scene_id:  NSUserDefaults.standardUserDefaults().valueForKey("scene_id") as! String, auth_code: NSUserDefaults.standardUserDefaults().valueForKey("auth_code") as! String, vproduct_type: "app", area_num: area_num, sort: sort)
        
        //MJ进行下拉刷新
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(AppListViewController.downRefresh))
        
        //MJ上拉加载
        self.tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(AppListViewController.upRefresh))
        
        self.view.addSubview(tableView)
        
    }
    
    
    override func prefersStatusBarHidden()-> Bool{
        return false;
    }
    
    private func setNav() {
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),
                    NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 16.0)!]
        navigationItem.title = "可做任务"
        navigationItem.rightBarButtonItems = [UIBarButtonItem(imageName: "share_0", highlImageName: "share_2", targer: self, action: #selector(AppListViewController.sharedBtnClick)),UIBarButtonItem(imageName: "sort_0", highlImageName: "sort_0", targer: self, action: #selector(AppListViewController.showMenu))]
        // 添加收藏按钮
        //navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "share_0", highlImageName: "share_2", targer: self, action: #selector(AppListViewController.sharedBtnClick))
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    private func setButton(btn: UIButton, _ frame: CGRect, _ imageName: String, _ highlightedImageName: String, _ action: Selector) {
        btn.frame = frame
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: highlightedImageName), forState: .Highlighted)
        btn.addTarget(self, action: action, forControlEvents: .TouchUpInside)
    }
    
    //实现协议DataRequestDelegate的方法
    func transforValue(item1: AnyObject) {
        self.clearAllNotice()
        self.items1 = item1 as! [AppsCellModel]
        self.tableView.reloadData()
    }
    
    func transforValue(item1: AnyObject,item2: AnyObject, countMoney: Double, countMoneyRate: Double) {
    }
    
    func transforSuccess(item1: AnyObject) {
        self.clearAllNotice()
        self.errorNotice("网络错误")
    }
    
    /**
     Description:下拉刷新实现方法
     */
    func downRefresh(){
        self.tableView.mj_header.beginRefreshing()
        request = DataRequest()
        request.delegate = self
        request.appListRequest(NSUserDefaults.standardUserDefaults().valueForKey("customer_id") as! String, scene_id:  NSUserDefaults.standardUserDefaults().valueForKey("scene_id") as! String, auth_code: NSUserDefaults.standardUserDefaults().valueForKey("auth_code") as! String, vproduct_type: "app", area_num: area_num, sort: sort)
        //self.tableView.reloadData()
        self.tableView.mj_header.endRefreshing()
    }
    /**
     Description:上拉加载实现方法
     */
    func upRefresh(){
        self.tableView.mj_footer.beginRefreshing()
        //self.tableView.reloadData()
        self.tableView.mj_footer.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //清除磁盘和内存中的缓存
        SDImageCache.sharedImageCache().clearDisk()
        SDImageCache.sharedImageCache().clearMemory()
    }
   
}



/// MARK:- 所有按钮的事件
extension AppListViewController {
    
    /// 分享
    func sharedBtnClick() {
        shareView.shareVC = self
        let shareModel = ShareModel(shareTitle: theme.ShareTitle, shareURL: theme.ShareURL, image: UIImage(named: "author"), shareDetail: theme.ShareDetail)
        shareView.shareModel = shareModel
        view.addSubview(shareView)
        shareView.showShareView(CGRectMake(0, AppHeight - theme.ShareViewHeight - NavigationH-20, AppWidth, theme.ShareViewHeight))
    }
    
    //更改城市监听事件
    func cityChange(noti: NSNotification) {
        if let currentCityName = noti.object as? String {
            self.cityRightBtn.setTitle(currentCityName, forState: .Normal)
            print("更改城市:\(currentCityName)")
            if(currentCityName == "北京"){
                area_num = "1"
            }else if(currentCityName == "南京"){
                area_num = "108"
            }else if(currentCityName == "宁波"){
                 area_num = "122"
            }else if(currentCityName == "广州"){
                 area_num = "231"
            }else if(currentCityName == "成都"){
                 area_num = "269"
            }else if(currentCityName == "杭州"){
                 area_num = "121"
            }else if(currentCityName == "济南"){
                 area_num = "169"
            }else if(currentCityName == "苏州"){
                 area_num = "112"
            }else if(currentCityName == "青岛"){
                 area_num = "170"
            }
            downRefresh()
        }
    }
    
    /// 排序
    func showMenu(){
        let item1 = DropdownItem(title: "结算最快")
        let item2 = DropdownItem(title: "佣金最高")
        let item3 = DropdownItem( title: "发布最新")
        let item4 = DropdownItem(title: "预计用时最短")
        
        items = [item1, item2, item3, item4]
        let menuView = DropdownMenu(navigationController: navigationController!, items: items, selectedRow: selectedRow)
        menuView.delegate = self
        menuView.showMenu(onNavigaitionView: false)
    }
}

extension AppListViewController: DropdownMenuDelegate {
    func dropdownMenu(dropdownMenu: DropdownMenu, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(self.selectedRow != indexPath.row){
            request = DataRequest()
            request.delegate = self
            if(indexPath.row == 0 ){
               sort = "2"
            }else if(indexPath.row == 1 ){
                sort = "1"
            }else if(indexPath.row == 2 ){
                sort = "3"
            }else if(indexPath.row == 3 ){
                sort = "4"
            }
            request.appListRequest(NSUserDefaults.standardUserDefaults().valueForKey("customer_id") as! String, scene_id:  NSUserDefaults.standardUserDefaults().valueForKey("scene_id") as! String, auth_code: NSUserDefaults.standardUserDefaults().valueForKey("auth_code") as! String, vproduct_type: "app",area_num: area_num, sort: sort)
        }
        self.selectedRow = indexPath.row
        print("selectedRow: \(self.selectedRow)")
        
        /*let alertConroller = UIAlertController(title: "Nice", message: "You choose \(items[indexPath.row].title)", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alertConroller.addAction(okAction)
        presentViewController(alertConroller, animated: true) {
            print("dropdownMenu")
        }*/
       
    }
}

extension AppListViewController: DropUpMenuDelegate {
    func dropUpMenu(dropUpMenu: DropUpMenu, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alertConroller = UIAlertController(title: "Nice", message: "DropUpMenu didselect \(indexPath.row) text:\(items[indexPath.row].title)", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alertConroller.addAction(okAction)
        presentViewController(alertConroller, animated: true) {
            print("dropUpMenu")
        }
    }
    
    func dropUpMenuCancel(dropUpMenu: DropUpMenu) {
        print("dropUpMenuCancel")
    }
}
