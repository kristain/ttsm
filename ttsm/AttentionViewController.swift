//
//  AttentionViewController.swift
//  ttsm
//
//  Created by kristain on 16/8/18.
//  Copyright © 2016年 kristain. All rights reserved.
//  关注页面

import UIKit

class AttentionViewController: UIViewController,UIActionSheetDelegate {

    private lazy var shareView: ShareView = ShareView.shareViewFromXib()
    private lazy var backBtn: UIButton = UIButton()
    private lazy var sharedBtn: UIButton = UIButton()
    
    private lazy var customNav: UIView = {
        let customNav = UIView(frame: CGRectMake(0, 0, AppWidth, NavigationH))
        customNav.backgroundColor = UIColor.whiteColor()
        customNav.alpha = 0.0
        return customNav
    }()
    
    var webView = UIWebView(frame: CGRectMake(0,0,AppWidth,AppHeight-WebViewH))
    var listUrl: String!
    var vproduct_type: String!
    var weixinImageUrl: String!
    var weixinTitle: String!
    var weixinDesc: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomNavigationItem()
        loadRequest(listUrl)
        self.view.addSubview(webView)
        // Do any additional setup after loading the view.
    }
    
    private func setCustomNavigationItem() {
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),
                                                            NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 16.0)!]
        navigationItem.title = "关注操作"
        // 添加分享按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "share_0", highlImageName: "share_2", targer: self, action: #selector(AttentionViewController.sharedBtnClick))
        // 添加返回按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .Done, target: self, action: #selector(RebateListViewController.backButtonClick))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = theme.SDBackgroundColor
        
    }
    
    func loadRequest(url: String){
        self.webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



extension AttentionViewController {
    
    /// 分享
    func sharedBtnClick() {
        shareView.shareVC = self
        let shareModel = ShareModel(shareTitle: self.weixinTitle, shareURL: self.listUrl, image: UIImage(named: "author"), shareDetail: self.weixinDesc)
        shareView.shareModel = shareModel
        view.addSubview(shareView)
        shareView.showShareView(CGRectMake(0, AppHeight - theme.ShareViewHeight - 60, AppWidth, theme.ShareViewHeight))
        
    }
    
    /// 返回
    func backButtonClick() {
        self.dismissViewControllerAnimated(true, completion: nil)
        //navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
