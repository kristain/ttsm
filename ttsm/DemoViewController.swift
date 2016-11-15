//
//  DemoViewController.swift
//  ttsm
//
//  Created by kristain on 16/8/18.
//  Copyright © 2016年 kristain. All rights reserved.
//  示例页面

import UIKit

class DemoViewController: UIViewController, UIActionSheetDelegate{

    var webView = UIWebView(frame: CGRectMake(0,0,AppWidth,AppHeight-WebViewH))
    var listUrl: String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化导航条上的内容
        setNavigationItem()
        loadRequest(listUrl)
        self.view.addSubview(webView)
        // Do any additional setup after loading the view.
    }
    
  

    func loadRequest(url: String){
        self.webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func setNavigationItem() {
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),
                                                            NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 16.0)!]
        navigationItem.title = "示例页面"
        // 添加返回按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .Done, target: self, action: #selector(RebateListViewController.backButtonClick))
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = theme.SDBackgroundColor
        
    }

}

extension DemoViewController {
    
    /// 返回
    func backButtonClick() {
         dismissViewControllerAnimated(true, completion: nil)
    }
    
}
