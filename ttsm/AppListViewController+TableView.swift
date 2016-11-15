//
//  AppListViewController+TableView.swift
//  ttsm
//
//  Created by kristain on 16/8/14.
//  Copyright © 2016年 kristain. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

// MARK: - UITableViewDelegate, UITableViewDataSource
extension AppListViewController: UITableViewDelegate, UITableViewDataSource{
    /**
     Description
     - returns: 块的数量，因为TableView的风格是plain，所以是1，默认也为1
     */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     Description
     - returns: 每一个section有多少行。若为0的时候，则cellForIndexPath。。。不进行cell的绘制
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items1.count
    }
    /**
     Description:该函数进行cell的绘制，包括系统定义或者自定义
     - parameter indexPath: 当前所在行
     - returns: 返回cell
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let initIdentifier = "MyCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(initIdentifier) as? NewsTableViewCell
        if cell == nil{
            tableView.registerNib(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: initIdentifier)
            cell = tableView.dequeueReusableCellWithIdentifier(initIdentifier) as? NewsTableViewCell
        }
        //进行cell的绘制
        let model = self.items1[indexPath.row]
        
        //let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        //hud.labelText = "正在加载中，请稍候"
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            //异步加载图片
            cell?.headerImage.sd_setImageWithURL(NSURL(string: model.imageUri))
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cell?.headerLabel.text = model.vProductName
                var rebateType = ""
                if(model.rebatePeriod == "1"){
                    rebateType = "及时返利。"
                }else if(model.rebatePeriod == "2"){
                    rebateType = "次日返利。"
                }else if(model.rebatePeriod == "3"){
                    rebateType = "周返。"
                }else if(model.rebatePeriod == "4"){
                    rebateType = "半月返。"
                }
                cell?.productDescLabel.text = "\(rebateType)\(model.timecost)分钟。\(model.size)\(model.vProductDesc)"
                cell?.priceLabel.text = "+\(model.productPrice)元"
                  cell?.demoButton.tag = model.id
                if(model.demoURI != ""){
                    cell?.demoButton.setTitle("示例", forState: UIControlState.Normal)
                }else{
                    cell?.demoButton.setTitle("", forState: UIControlState.Normal)
                }
                cell?.demoButton.addTarget(self, action: #selector(AppListViewController.demoBtnClicked), forControlEvents: UIControlEvents.TouchUpInside)
                
                cell?.inventCodeButton.tag = model.id
                if(model.inviteCode != ""){
                    cell?.inventCodeButton.setTitle("邀请码", forState: UIControlState.Normal)
                }else{
                    cell?.inventCodeButton.setTitle("", forState: UIControlState.Normal)
                }
                cell?.inventCodeButton.addTarget(self, action: #selector(AppListViewController.copyInventCodeClicked), forControlEvents: UIControlEvents.TouchUpInside)
               
                if(model.vProductType == "weixin"){
                    if(model.attentionStatus == 1){
                        cell?.downButton.setTitle("已关注", forState: UIControlState.Normal)
                    }else{
                        cell?.downButton.setTitle("关注", forState: UIControlState.Normal)
                    }
                }else if(model.vProductType == "newbie"){
                    if(model.signStatus == 1){
                         cell?.downButton.setTitle("已签到", forState: UIControlState.Normal)
                    }else{
                         cell?.downButton.setTitle("签到", forState: UIControlState.Normal)
                    }
                }else{
                    cell?.downButton.setTitle("下载", forState: UIControlState.Normal)
                }
                cell?.downButton.tag = model.id
                cell?.downButton.addTarget(self, action: #selector(AppListViewController.downClicked), forControlEvents: UIControlEvents.TouchUpInside)
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
               // hud.hide(true)
               // hud.removeFromSuperview()
            })
        }
        return cell!
    }
    
    //点击示例按钮
    func demoBtnClicked(sender:UIButton) {
        let demouri = self.items1[sender.tag].demoURI
        if(demouri != ""){
            let newsController = DemoViewController()
            newsController.listUrl = demouri
            let nav = MainNavigationController(rootViewController: newsController)
            presentViewController(nav, animated: true, completion: nil)
        }else{
            self.errorNotice("没有示例页面", autoClear: true)
        }
    }
    
    //点击邀请码
    func copyInventCodeClicked(sender:UIButton){
        let inviteCode = self.items1[sender.tag].inviteCode
        if(inviteCode != ""){
            UIPasteboard.generalPasteboard().string = "\(inviteCode)"
            self.successNotice("复制成功")
        }else{
            self.errorNotice("没有邀请码", autoClear: true)
        }
    }
    
    //点击下载按钮
    func downClicked(sender:UIButton){
        let productType = self.items1[sender.tag].vProductType
        if(productType == "newbie"){
            request = DataRequest()
            request.doDownCount(self.items1[sender.tag].vProduct_key, auth_code: NSUserDefaults.standardUserDefaults().valueForKey("auth_code") as! String, customer_id: NSUserDefaults.standardUserDefaults().valueForKey("customer_id") as! String, scene_id:  NSUserDefaults.standardUserDefaults().valueForKey("scene_id") as! String);
             self.successNotice("已获一元红包,请去拿奖励。")
        }else if(productType == "weixin"){
            request = DataRequest()
            request.doDownCount(self.items1[sender.tag].vProduct_key, auth_code: NSUserDefaults.standardUserDefaults().valueForKey("auth_code") as! String, customer_id: NSUserDefaults.standardUserDefaults().valueForKey("customer_id") as! String, scene_id:  NSUserDefaults.standardUserDefaults().valueForKey("scene_id") as! String);
            
            let newsController = AttentionViewController()
            newsController.listUrl = self.items1[sender.tag].downloadIosURI
            newsController.weixinDesc = self.items1[sender.tag].weixinDesc
            newsController.weixinTitle = self.items1[sender.tag].weixinTitle
            newsController.weixinImageUrl = self.items1[sender.tag].weixinImageUrl
            print("点击关注:downloadIosURI:\(self.items1[sender.tag].downloadIosURI) weixinDesc:\(self.items1[sender.tag].weixinDesc) weixinTitle:\(self.items1[sender.tag].weixinTitle) ")
            let nav = MainNavigationController(rootViewController: newsController)
            presentViewController(nav, animated: true, completion: nil)
        }else{
            let cityVC = DownViewController()
            cityVC.listUrl = self.items1[sender.tag].downloadIosURI
            print("url:\(self.items1[sender.tag].downloadIosURI)")
            let nav = MainNavigationController(rootViewController: cityVC)
            presentViewController(nav, animated: true, completion: nil)
        }
    }

    
    /**
     Description点击cell之后进行的相关操作
     */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("点击详情\(self.items1[indexPath.row].id)\(self.items1[indexPath.row].vProductName)")
       /* let newsController = NewsListViewController()
        newsController.id = self.items1[indexPath.row].id
        self.navigationController?.pushViewController(newsController, animated: true)*/
    }
    
    /**
     Description
     - returns: 每个cell的高度
     */
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    /**
     Description:呈现cell的方式,动画效果
     函数名:tableViewwillDisplayCellforRowAtIndexPath
     */
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeTranslation(1, 1, 1)
        })
    }
}
