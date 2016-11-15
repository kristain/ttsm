//
//  LoginViewController.swift
//  ttsm
//  登陆页面
//  Created by kristain on 16/8/13.
//  Copyright © 2016年 kristain. All rights reserved.
//

import UIKit
import JSAnimatedImagesView
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController , RCAnimatedImagesViewDelegate{

    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var submit: UIButton!
    
    @IBOutlet weak var wallpaperImageView: RCAnimatedImagesView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wallpaperImageView.delegate = self
        self.wallpaperImageView.startAnimating()
        // Do any additional setup after loading the view.
        
        self.submit.addTarget(self,action:#selector(LoginViewController.doLogin),forControlEvents:UIControlEvents.TouchUpInside)
    }
    
    // 登录方法
    func doLogin(){
        self.pleaseWait()
        let user_key = UIDevice.currentDevice().identifierForVendor?.UUIDString
        print("登录user_key\(user_key)")
        let regex = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        guard predicate.evaluateWithObject(phone.text) else{
            self.clearAllNotice()
            self.errorNotice("手机号码错误!")
            return
        }
        
        Alamofire.request(.POST, "http://www.qdwang.cn/lyhpfb/index.php?route=app/popularize/commitAuthCode",parameters: ["auth_code": phone.text!, "user_key": user_key!])
            .responseJSON { response in
                print("登录返回：\(response.result)")
                switch response.result {
                    case .Success:
                    let json=JSON(response.result.value!)
                    let result=json["result"].string!
                    if(result == "success"){
                    //设置存储信息
                    NSUserDefaults.standardUserDefaults().setObject(json["scene_id"].string!, forKey: "scene_id")
                    NSUserDefaults.standardUserDefaults().setObject(json["customer_id"].string!, forKey: "customer_id")
                   NSUserDefaults.standardUserDefaults().setObject(json["auth_code"].string!, forKey: "auth_code")
                    //设置同步
                    NSUserDefaults.standardUserDefaults().synchronize()
                    self.clearAllNotice()
                    self.presentViewController(MainTabBarController(), animated: true, completion: nil)
                    }else{
                        self.clearAllNotice()
                        self.errorNotice(json["errors"].string!)
                    }
                    case .Failure(let error):
                        self.clearAllNotice()
                        self.errorNotice("网络超时")
                        print("\(error)")
            }
        
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let auth_code = NSUserDefaults.standardUserDefaults().valueForKey("auth_code");
        if(auth_code != nil){
             self.presentViewController(MainTabBarController(), animated: true, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animatedImagesNumberOfImages(animatedImagesView: RCAnimatedImagesView!) -> UInt {
        return 3
    }
    
    
    func animatedImagesView(animatedImagesView: RCAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        return UIImage(named:"image\(index+1)")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
