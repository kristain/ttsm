//
//  RebateListViewController+TableView.swift
//  ttsm
//
//  Created by kristain on 16/8/18.
//  Copyright © 2016年 kristain. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

// MARK: - UITableViewDelegate, UITableViewDataSource
extension RebateListViewController: UITableViewDelegate, UITableViewDataSource{
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
        let initIdentifier = "RebateCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(initIdentifier) as? RebateTableViewCell
        if cell == nil{
            tableView.registerNib(UINib(nibName: "RebateTableViewCell", bundle: nil), forCellReuseIdentifier: initIdentifier)
            cell = tableView.dequeueReusableCellWithIdentifier(initIdentifier) as? RebateTableViewCell
        }
        //进行cell的绘制
        let model = self.items1[indexPath.row]
        
        
        //let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        //hud.labelText = "正在加载中，请稍候"
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            //异步加载图片
            cell?.headerImage.sd_setImageWithURL(NSURL(string: model.imageUri))
            if( model.rebate_prices.count>0){
                if(model.rebate_prices.count==1){
                    let label = self.getStatusName(model.rebate_prices[0].objectForKey("status_name")as! String )
                    cell?.attentionLabel.text = label!
                    cell?.attentionMoney.text = "+\(model.rebate_prices[0].objectForKey("amount")as! String)"
                }
                if(model.rebate_prices.count==2){
                    cell?.signLabel.text = self.getStatusName(model.rebate_prices[0].objectForKey("status_name")as! String )!
                    cell?.signMoney.text = "+\(model.rebate_prices[0].objectForKey("amount")as! String)"
                    cell?.attentionLabel.text = self.getStatusName(model.rebate_prices[1].objectForKey("status_name")as! String )!
                    cell?.attentionMoney.text = "+\(model.rebate_prices[1].objectForKey("amount")as! String)"
                }
                if(model.rebate_prices.count==3){
                    cell?.signLabel.text = self.getStatusName(model.rebate_prices[0].objectForKey("status_name")as! String )!
                    cell?.signMoney.text = "+\(model.rebate_prices[0].objectForKey("amount")as! String)"
                    cell?.attentionLabel.text = self.getStatusName(model.rebate_prices[1].objectForKey("status_name")as! String )!
                    cell?.attentionMoney.text = "+\(model.rebate_prices[1].objectForKey("amount")as! String)"
                    cell?.downLabel.text = self.getStatusName(model.rebate_prices[2].objectForKey("status_name")as! String )!
                    cell?.downMoney.text = "+\(model.rebate_prices[2].objectForKey("amount")as! String)"
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cell?.headerLabel.text = model.vProductName
                cell?.productDescLabel.text = model.vProductDesc
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
        return 75
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
    
    
    func getStatusName(status_name: String) -> String? {
        if(status_name == "sign_status"){
            return "签到"
        }else if(status_name == "register_status"){
            return "注册"
        }else if(status_name == "trade_status"){
            return "下单"
        }else if(status_name == "attention_status"){
            return "关注"
        }else if(status_name == "install_status"){
            return "安装"
        }else if(status_name == "sms_status"){
            return "短信验证"
        }else if(status_name == "face_status"){
            return "刷脸"
        }else if(status_name == "identity_auth_status"){
            return "身份验证"
        }else if(status_name == "bindcard_status"){
            return "绑卡"
        }else if(status_name == "login_status"){
            return "登录"
        }else{
             return ""
        }
       
    }
}
