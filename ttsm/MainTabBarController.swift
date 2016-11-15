//
//  MainTabBarController.swift
//  ttsm
//
//  Created by kristain on 16/8/14.
//  Copyright © 2016年 kristain. All rights reserved.
//  基类主控制页面

import UIKit

class MainTabBarController: UITabBarController {

    var mainNav: UINavigationController?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpAllChildViewController()
        
        self.setValue(MainTabBar(), forKey: "tabBar")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /// 初始化所有子控制器
    private func setUpAllChildViewController() {
        // 拿奖励
        tabBaraAddChildViewController(vc: AppListViewController(), title: "去拿奖励", imageName: "qfl", selectedImageName: "qfl")
        
        //tabBaraAddChildViewController(vc: RebateListViewController(), title: "去拿奖励", imageName: "recommendation_1", selectedImageName: "recommendation_2")
    }
    
    //通过MainNavgationController来控制所有的标签页面
    private func tabBaraAddChildViewController(vc vc: UIViewController, title: String, imageName: String, selectedImageName: String) {
        vc.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, -50, -6,50)
        
        vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(10, -12);
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor(),NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 16.0)!], forState:UIControlState.Selected)
         vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor(),NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 16.0)!], forState:UIControlState.Normal)
        vc.view.backgroundColor = theme.SDBackgroundColor
        mainNav = MainNavigationController(rootViewController: vc)
        addChildViewController(mainNav!)
    }
    

    
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: (UITabBarItem!)) {
        switch item.tag{
        case 0:
            //跳转到返利页面
           let cityVC = RebateListViewController()
           let nav = MainNavigationController(rootViewController: cityVC)
           presentViewController(nav, animated: true, completion: nil)
        default:
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
}

class MainTabBar: UITabBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translucent = false
        self.tintColor = UIColor.whiteColor()
        self.barTintColor = UIColor(red: 0.996, green: 0.502, blue: 0.290, alpha: 1)
        //可修改图片
        self.backgroundImage = UIImage(named: "tabbar")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}

