//
//  theme.swift
//  ttsm
//
//  Created by kristain on 16/8/16.
//  Copyright © 2016年 kristain. All rights reserved.
//  全局公用属性

import UIKit

public let NavigationH: CGFloat = 90
public let WebViewH: CGFloat = 65
public let AppWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
public let AppHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
public let MainBounds: CGRect = UIScreen.mainScreen().bounds


struct theme {
    ///  APP导航条barButtonItem文字大小
    static let SDNavItemFont: UIFont = UIFont.systemFontOfSize(16)
    ///  APP导航条titleFont文字大小
    static let SDNavTitleFont: UIFont = UIFont.systemFontOfSize(18)
    /// ViewController的背景颜色
    static let SDBackgroundColor: UIColor = UIColor.whiteColor()
    /// webView的背景颜色
    static let SDWebViewBacagroundColor: UIColor = UIColor.greenColor()
    /// 友盟分享的APP key
    static let UMSharedAPPKey: String = "55e2f45b67e58ed4460012db"
    /// 自定义分享view的高度
    static let ShareViewHeight: CGFloat = 215
    /// cache文件路径
    static let cachesPath: String = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last!
    /// UIApplication.sharedApplication()
    static let appShare = UIApplication.sharedApplication()
    
    static let GitHubURL: String = "https://github.com/ZhongTaoTian"
    static let ShareURL: String = "http://www.qdwang.cn/lyhpfb/installapp/install.php?channel_id=11&scene_id=1&user_key="
    static let ShareTitle: String = "哇喔，我刚用“天天扫码”,是试用软件立即得红包的,第一时间和你分享"
    static let ShareDetail: String = "天天扫码,简单好玩，下载注册软件就能得红包,或爱奇异VIP。靠谱，安全"
    static let sinaURL = "http://weibo.com/u/5622363113/home?topnav=1&wvr=6"
    // APP列表请求地址
    static let appListURL = "http://www.qdwang.cn/lyhpfb/index.php?route=app/popularize/queryPopularizingProducts"
    // 返利列表请求地址
    static let rebateListURL = "http://www.qdwang.cn/lyhpfb/index.php?route=app/popularize/queryPopularizingProductsForRebate"
    // 返利提交请求地址
    static let doRebateURL = "http://www.qdwang.cn/lyhpfb/index.php?route=app/popularize/doRebate"
    // 登录请求地址
    static let doLoginURL = "http://www.qdwang.cn/lyhpfb/index.php?route=app/popularize/commitAuthCode"
    
    // 下载统计请求地址
    static let doDownCountURL = "http://www.qdwang.cn/lyhpfb/index.php?route=app/popularize/updateDownloadCount"
    
    //城市列表
    static let getAreaURL = "http://www.qdwang.cn/lyhpfb/index.php?route=app/popularize/queryInuseArea"
    
    //分享回调
    static let doShareURL = "http://www.qdwang.cn/lyhpfb/index.php?route=app/popularize/doShareTaskRebate"
    
}
