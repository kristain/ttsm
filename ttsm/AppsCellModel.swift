//
//  AppsCellModel.swift
//  ttsm
//
//  Created by kristain on 16/8/15.
//  Copyright © 2016年 kristain. All rights reserved.
//  

import Foundation

class AppsCellModel: NSObject{
    var id: Int!
    var newsImageName: String!
    var newsTitle: String!
    
    var devId: String!
    var userKey: String!
    var customerId: String!
    var vProductType: String!
    var openId: String!
    var sceneId: String!
    var channelId: String!
    var authCode: String!
    var vProductName: String!
    var rebatePeriod: String!
    var productPrice: Double!
    var size: String!
    var vProductDesc: String!
    var imageUri: String!
    var demoURI: String!
    var inviteCode: String!
    var attentionStatus: Int!
    var signStatus: Int!
    var weixinImageUrl: String!
    var weixinTitle: String!
    var weixinDesc: String!
    var downURI: String!
    var downloadIosURI: String!
    var vProduct_key: String!
    
    var beginDate: String!
    var deductionAddRatio: Double!
    var downloadType: Int!
    var downloadURI: String!
    var download_count: Int!
    var endDate: String!
    var smsRegex: String!
    var status: Int!
    var vProductShortName: String!
    var timecost: String!
    var rebate_prices: NSArray!

    
    
    var amount: String!
    var customer_name: String!
    var errors: String!
    var messages: String!
    var num: String!
    var order_no: String!
    var rebate_type: String!
    var rebate_type_desc: String!
    var time: String!
    
    
    
    init(id: Int, newsTitle: String) {
        self.id = id
        self.newsTitle = newsTitle
    }
    
    init(id: Int,newsImageName: String, newsTitle: String) {
        self.id = id
        self.newsImageName = newsImageName
        self.newsTitle = newsTitle
    }
    
    init(id: Int,devId: String, userKey: String, customerId: String, vProductType: String, openId: String, sceneId: String, channelId: String, authCode: String, vProductName: String, rebatePeriod: String, productPrice: Double, size: String, vProductDesc: String, imageUri: String,demoURI: String,inviteCode: String,attentionStatus: Int,signStatus: Int, weixinImageUrl: String, weixinTitle: String, weixinDesc: String, downURI: String, downloadIosURI: String, vProduct_key: String, timecost: String) {
        self.id = id
        self.devId = devId
        self.userKey = userKey
        self.customerId = customerId
        self.vProductType = vProductType
        self.openId = openId
        self.sceneId = sceneId
        self.channelId = channelId
        self.authCode = authCode
        self.vProductName = vProductName
        self.rebatePeriod = rebatePeriod
        self.productPrice = productPrice
        self.size = size
        self.vProductDesc = vProductDesc
        self.imageUri = imageUri
        self.demoURI = demoURI
        self.inviteCode = inviteCode
        self.attentionStatus = attentionStatus
        self.signStatus = signStatus
        self.weixinImageUrl = weixinImageUrl
        self.weixinTitle = weixinTitle
        self.weixinDesc = weixinDesc
        self.downURI = downURI
        self.downloadIosURI = downloadIosURI
        self.vProduct_key = vProduct_key
        self.timecost = timecost
    }
    
    
    init(id: Int, beginDate: String,customerId: String, deductionAddRatio: Double, demoURI: String, downloadType: Int, downloadURI: String, download_count: Int, endDate: String, imageUri: String, inviteCode: String, sceneId: String,
         size: String, smsRegex: String, status: Int, vProductDesc: String, vProduct_key: String, vProductName: String,
         vProductShortName: String, vProductType: String, rebate_prices: NSArray){
        self.id = id
        self.beginDate = beginDate
        self.customerId = customerId
        self.deductionAddRatio = deductionAddRatio
        self.demoURI = demoURI
        self.downloadType = downloadType
        self.downloadURI = downloadURI
        self.download_count = download_count
        self.endDate = endDate
        self.imageUri = imageUri
        self.inviteCode = inviteCode
        self.sceneId = sceneId
        self.size = size
        self.smsRegex = smsRegex
        self.status = status
        self.vProductDesc = vProductDesc
        self.vProduct_key = vProduct_key
        self.vProductName = vProductName
        self.vProductShortName = vProductShortName
        self.vProductType = vProductType
        self.rebate_prices = rebate_prices
    }
    

    init(amount: String, customer_name: String, errors: String,messages: String, num: String, order_no: String, rebate_type: String, rebate_type_desc: String, time: String){
        self.amount = amount
        self.customer_name = customer_name
        self.errors = errors
        self.messages = messages
        self.num = num
        self.order_no = order_no
        self.rebate_type = rebate_type
        self.rebate_type_desc = rebate_type_desc
        self.time = time
    }
    
    
}