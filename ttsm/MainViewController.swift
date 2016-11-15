//
//  MainViewController.swift
//  ttsm
//
//  Created by kristain on 16/8/14.
//  Copyright © 2016年 kristain. All rights reserved.
//  基类控制器, 带有选择城市的ViewController

import UIKit

class MainViewController: UIViewController {

    //城市选择按钮
    var cityRightBtn: TextImageButton!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppListViewController.cityChange(_:)), name: SD_CurrentCityChange_Notification, object: nil)
        
        cityRightBtn = TextImageButton(frame: CGRectMake(0, 20, 80, 44))
       
        let user = NSUserDefaults.standardUserDefaults()
        if let currentCity = user.objectForKey(SD_Current_SelectedCity) as? String {
            cityRightBtn.setTitle(currentCity, forState: .Normal)
        } else {
            cityRightBtn.setTitle("北京", forState: .Normal)
        }
        
        cityRightBtn.titleLabel?.font = theme.SDNavItemFont
        cityRightBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cityRightBtn.setImage(UIImage(named: "home_down"), forState: .Normal)
        cityRightBtn.addTarget(self, action: #selector(MainViewController.pushcityView), forControlEvents: .TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cityRightBtn)
        
        UINavigationBar.appearance().barTintColor =  UIColor(red: 1, green: 0.655, blue: 0.274, alpha: 1)
    }
    
    override func prefersStatusBarHidden()-> Bool{
        return true;
    }
    
    
    
    func pushcityView () {
        let cityVC = CityViewController()
        cityVC.cityName = self.cityRightBtn.titleForState(.Normal)
        let nav = MainNavigationController(rootViewController: cityVC)
        presentViewController(nav, animated: true, completion: nil)
    }
    
   
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}

// MARK: 自定义选择城市button,文字在左边 图片在右边
class TextImageButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = theme.SDNavItemFont
        titleLabel?.contentMode = UIViewContentMode.Center
        imageView?.contentMode = UIViewContentMode.Left
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRectMake(-5, 0, titleLabel!.width, height)
        imageView?.frame = CGRectMake(titleLabel!.width + 3 - 5, 0, width - titleLabel!.width - 3, height)
    }
}
