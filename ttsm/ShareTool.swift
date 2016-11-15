//
//  ShareTool.swift
//  ttsm
//
//  Created by kristain on 16/8/15.
//  Copyright © 2016年 kristain. All rights reserved.
//

import Foundation
import SVProgressHUD
import Alamofire

class ShareTool: NSObject {
    
    class func shareToSina(model: ShareModel, viewController: UIViewController?)  {
        let image: UIImage = UIImage(named: "author")!
        // 新浪的连接直接写入到分享文字中就行
        UMSocialControllerService.defaultControllerService().setShareText(model.shareDetail! + theme.ShareURL, shareImage: image, socialUIDelegate: nil)
        UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToSina).snsClickHandler(viewController, UMSocialControllerService.defaultControllerService(), true)
    }
    
    class func shareToWeChat(model: ShareModel) {
        
        UMSocialData.defaultData().extConfig.wechatSessionData.url = model.shareURL
        UMSocialData.defaultData().extConfig.wechatSessionData.title = model.shareTitle
        
        let image: UIImage = UIImage(named: "author")!
        let shareURL = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: model.shareURL)
        UMSocialDataService.defaultDataService()
        
        UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatSession], content: model.shareDetail, image: image, location: nil, urlResource: shareURL, presentedController: nil) { (response) -> Void in
            if response.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                print("微信分享成功")
                SVProgressHUD.showSuccessWithStatus("分享成功")
                let user_key = UIDevice.currentDevice().identifierForVendor?.UUIDString
                Alamofire.request(.POST, theme.doShareURL, parameters: ["user_key": user_key!])
                    .responseJSON { response in
                        switch response.result {
                        case .Success:
                            if let JSON = response.result.value {
                                //调用代理方法
                                print("返回报文 \(JSON)")
                            }
                        case .Failure(let error):
                            print("返回报文 : \(error)")
                        }
                }

            }
        }
    }
    
    class func shareToWeChatFriends(model: ShareModel) {
        
        UMSocialData.defaultData().extConfig.wechatSessionData.url = model.shareURL
        UMSocialData.defaultData().extConfig.wechatSessionData.title = model.shareTitle
        
        let image: UIImage = UIImage(named: "author")!
        let shareURL = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: model.shareURL)
        
        UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatTimeline], content: model.shareTitle, image: image, location: nil, urlResource: shareURL, presentedController: nil) { (response) -> Void in
            if response.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                print("微信朋友圈分享成功")
                SVProgressHUD.showSuccessWithStatus("分享成功")
                let user_key = UIDevice.currentDevice().identifierForVendor?.UUIDString
                Alamofire.request(.POST, theme.doShareURL, parameters: ["user_key": user_key!])
                    .responseJSON { response in
                        switch response.result {
                        case .Success:
                            if let JSON = response.result.value {
                                //调用代理方法
                                print("返回报文 \(JSON)")
                            }
                        case .Failure(let error):
                            print("返回报文 : \(error)")
                        }
                }
            }
        }
    }
  
    
}
