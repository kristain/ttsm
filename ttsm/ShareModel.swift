//
//  ShareModel.swift
//  ttsm
//
//  Created by kristain on 16/8/15.
//  Copyright © 2016年 kristain. All rights reserved.
//  分享Model

import Foundation

class ShareModel: NSObject {
    
    var shareTitle: String?
    var shareURL: String?
    var img: UIImage?
    var shareDetail: String?
    init(shareTitle: String?, shareURL: String?, image: UIImage?, shareDetail: String?) {
        super.init()
        if shareDetail != nil {
            if let text: NSString = NSString(CString: shareDetail!.cStringUsingEncoding(NSUTF8StringEncoding)!,encoding: NSUTF8StringEncoding) {
                if text.length > 50 {
                    let aa = text.substringToIndex(50)
                    self.shareDetail = aa as String
                } else {
                    self.shareDetail = shareDetail
                }
            }
        }
        self.shareTitle = shareTitle
        self.img = image
        self.shareURL = shareURL
    }
}
