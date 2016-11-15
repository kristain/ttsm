//
//  DataRequest.swift
//  ttsm
//
//  Created by kristain on 16/8/15.
//  Copyright © 2016年 kristain. All rights reserved.
//  字典转模型

import Foundation
import Alamofire

class DataRequest: NSObject{
    var appItem: [AppsCellModel] = []
    var rebateItem: [AppsCellModel] = []
    var areaItem: [AreaModel] = []
    var rebateTypeItem: [RebateModel] = []
    var delegate:DataRequestDelegate?
    
    
    
    //获取APP列表
    func appListRequest(customer_id: String, scene_id: String, auth_code: String, vproduct_type: String, area_num: String, sort: String){
        let user_key = UIDevice.currentDevice().identifierForVendor?.UUIDString
        print("获取APP列表请求参数: user_key: \(user_key!) customer_id: \(customer_id) scene_id: \(scene_id) auth_code: \(auth_code) vproduct_type: \(vproduct_type) area_num: \(area_num) sort: \(sort)")

        var model: AppsCellModel?
        Alamofire.request(.POST, theme.appListURL, parameters: ["user_key": user_key!, "customer_id": customer_id, "open_id": "", "scene_id": scene_id, "auth_code": auth_code, "vproduct_type": vproduct_type, "area_num": area_num, "sort": sort, "platform": "ios"])
            .responseJSON { response in
                switch response.result {
                case .Success:
                if let JSON = response.result.value {
                    if let json = JSON.objectForKey("vproducts"){
                        print(json)
                        for var i = 0; i<json.count; i = i + 1{
                            var imageURI = ""
                            var vproductName = ""
                            var size = ""
                            var rebatePeriod = ""
                            var vproductDesc = ""
                            var productPrice = 0.0
                            var demoURI = ""
                            var invite_code = ""
                            var vproductType = ""
                            var attention_status = 0
                            var sign_status = 0
                            var weixinImageUrl = ""
                            var weixinTitle = ""
                            var weixinDesc = ""
                            var downURI = ""
                            var downloadIosURI = ""
                            var vProduct_key = ""
                            var timecost = ""
                            if !(json[i].objectForKey("imageURI") is NSNull){
                                imageURI = json[i].objectForKey("imageURI")as! String
                            }
                            if !(json[i].objectForKey("vproduct_name") is NSNull){
                                vproductName = json[i].objectForKey("vproduct_name")as! String
                            }
                            if !(json[i].objectForKey("size") is NSNull){
                                size = json[i].objectForKey("size")as! String
                            }
                            if !(json[i].objectForKey("rebatePeriod") is NSNull){
                                rebatePeriod = json[i].objectForKey("rebatePeriod")as! String
                            }
                            if !(json[i].objectForKey("vproduct_desc") is NSNull){
                                vproductDesc = json[i].objectForKey("vproduct_desc")as! String
                            }
                            if !(json[i].objectForKey("productPrice") is NSNull){
                                productPrice =  Double(json[i].objectForKey("productPrice")as! String)!
                            }
                            if !(json[i].objectForKey("invite_code") is NSNull){
                                invite_code = json[i].objectForKey("invite_code")as! String
                            }
                            if !(json[i].objectForKey("vproduct_type") is NSNull){
                                vproductType = json[i].objectForKey("vproduct_type")as! String
                            }
                            if !(json[i].objectForKey("attention_status") is NSNull){
                                attention_status = (json[i].objectForKey("attention_status")as! NSString).integerValue
                            }
                            if !(json[i].objectForKey("sign_status") is NSNull){
                                sign_status = (json[i].objectForKey("sign_status")as! NSString).integerValue
                            }
                            if !(json[i].objectForKey("weixinImageUrl") is NSNull){
                                weixinImageUrl = json[i].objectForKey("weixinImageUrl")as! String
                            }
                            if !(json[i].objectForKey("weixinTitle") is NSNull){
                                weixinTitle = json[i].objectForKey("weixinTitle")as! String
                            }
                            if !(json[i].objectForKey("weixinDesc") is NSNull){
                                weixinDesc = json[i].objectForKey("weixinDesc")as! String
                            }
                            if !(json[i].objectForKey("demoURI") is NSNull){
                                demoURI = json[i].objectForKey("demoURI")as! String
                            }
                            if !(json[i].objectForKey("downloadURI") is NSNull){
                                downURI = json[i].objectForKey("downloadURI")as! String
                            }
                            if !(json[i].objectForKey("downloadIosURI") is NSNull){
                                downloadIosURI = json[i].objectForKey("downloadIosURI")as! String
                            }
                            if !(json[i].objectForKey("vProduct_key") is NSNull){
                                vProduct_key = json[i].objectForKey("vproduct_key")as! String
                            }
                            if !(json[i].objectForKey("timeCost") is NSNull){
                                timecost =  json[i].objectForKey("timeCost")as! String
                            }
                            
                            model = AppsCellModel(id: i,devId: "", userKey: user_key!, customerId: customer_id, vProductType: vproductType, openId: "", sceneId: scene_id, channelId: "", authCode: auth_code, vProductName: vproductName, rebatePeriod: rebatePeriod, productPrice: productPrice, size: size, vProductDesc: vproductDesc, imageUri: imageURI,demoURI: demoURI,inviteCode: invite_code,attentionStatus: attention_status,signStatus: sign_status, weixinImageUrl: weixinImageUrl, weixinTitle: weixinTitle, weixinDesc: weixinDesc, downURI: downURI, downloadIosURI: downloadIosURI, vProduct_key: vProduct_key, timecost: timecost)
                            self.appItem.append(model!)
                        }
                    }
                    //调用代理方法
                    self.delegate?.transforValue(self.appItem)
                }
                case .Failure(let error):
                    print("返回报文 : \(error)")
                    self.delegate?.transforSuccess(self.appItem)
            }
        }
    
    }
    
    //获取待返利列表
    func rebateListRequest(vproducts: String, customer_id: String, scene_id: String){
        let user_key = UIDevice.currentDevice().identifierForVendor?.UUIDString
        var model: AppsCellModel?
        var rebate_model: RebateModel?
        Alamofire.request(.POST, theme.rebateListURL, parameters: ["user_key": user_key!, "customer_id": customer_id, "vproducts": vproducts, "scene_id": scene_id])
            .responseJSON { response in
                switch response.result {
                case .Success:
                if let JSON = response.result.value {
                    if let support_type_details = JSON.objectForKey("support_type_details"){
                         print(support_type_details);
                         for var j = 0; j<support_type_details.count; j = j + 1{
                             var amount = ""
                             var rebate_desc = ""
                             var rebate_desc_list = ""
                             var rebate_desc_result = ""
                             var rebate_name = ""
                            if !(support_type_details[j].objectForKey("amount") is NSNull){
                                amount = support_type_details[j].objectForKey("amount")as! String
                            }
                            if !(support_type_details[j].objectForKey("rebate_desc") is NSNull){
                                rebate_desc = support_type_details[j].objectForKey("rebate_desc")as! String
                            }
                            if !(support_type_details[j].objectForKey("rebate_desc_list") is NSNull){
                                rebate_desc_list = support_type_details[j].objectForKey("rebate_desc_list")as! String
                            }
                            if !(support_type_details[j].objectForKey("rebate_desc_result") is NSNull){
                                rebate_desc_result = support_type_details[j].objectForKey("rebate_desc_result")as! String
                            }
                            if !(support_type_details[j].objectForKey("rebate_name") is NSNull){
                                rebate_name = support_type_details[j].objectForKey("rebate_name")as! String
                            }
                            rebate_model = RebateModel(amount: amount, rebate_desc: rebate_desc, rebate_desc_result: rebate_desc_result, rebate_desc_list: rebate_desc_list, rebate_name: rebate_name)
                            self.rebateTypeItem.append(rebate_model!)
                         }
                        
                    }
                    var countMoney = 0.0
                    var countMoneyRate = 0.0
                    if let json = JSON.objectForKey("vproducts"){
                        print(json);
                        for var i = 0; i<json.count; i = i + 1{
                            var begin_date = ""
                            var customer_id = ""
                            var deduction_add_ratio = 1.00
                            var demoURI = ""
                            var downloadType = 0
                            var downloadURI = ""
                            var download_count = 0
                            var end_date = ""
                            var imageURI = ""
                            var invite_code = ""
                            var scene_id = ""
                            var size = ""
                            var sms_regex = ""
                            var status = 0
                            var vproduct_desc = ""
                            var vproduct_key = ""
                            var vproduct_name = ""
                            var vproduct_short_name = ""
                            var vproduct_type = ""
                            var rebatePrices: NSArray = []
                            var temp = 0.0
                            if !(json[i].objectForKey("begin_date") is NSNull){
                                begin_date = json[i].objectForKey("begin_date")as! String
                            }
                            if !(json[i].objectForKey("customer_id") is NSNull){
                                customer_id = json[i].objectForKey("customer_id")as! String
                            }
                            
                            if !(json[i].objectForKey("demoURI") is NSNull){
                                demoURI = json[i].objectForKey("demoURI")as! String
                            }
                            
                            if !(json[i].objectForKey("downloadType") is NSNull){
                                downloadType = (json[i].objectForKey("downloadType")as! NSString).integerValue
                            }
                           
                            if !(json[i].objectForKey("downloadURI") is NSNull){
                                downloadURI = json[i].objectForKey("downloadURI")as! String
                            }
                            
                            if !(json[i].objectForKey("download_count") is NSNull){
                                download_count = (json[i].objectForKey("download_count")as! NSString).integerValue
                            }
                            
                            if !(json[i].objectForKey("end_date") is NSNull){
                                end_date = json[i].objectForKey("end_date")as! String
                            }
                            
                            if !(json[i].objectForKey("imageURI") is NSNull){
                                imageURI = json[i].objectForKey("imageURI")as! String
                            }
                            if !(json[i].objectForKey("invite_code") is NSNull){
                                invite_code = json[i].objectForKey("invite_code")as! String
                            }
                            if !(json[i].objectForKey("rebate_prices") is NSNull){
                               rebatePrices = json[i].objectForKey("rebate_prices")as! NSArray
                                if(rebatePrices.count>0){
                                    for var t = 0; t<rebatePrices.count; t = t + 1{
                                        countMoney += Double(rebatePrices[t].objectForKey("amount")as! String)!
                                        temp += Double(rebatePrices[t].objectForKey("amount")as! String)!
                                    }
                                }
                            }
                           
                            if !(json[i].objectForKey("deduction_add_ratio") is NSNull){
                                deduction_add_ratio = Double(json[i].objectForKey("deduction_add_ratio")as! String)!
                                countMoneyRate += temp * deduction_add_ratio
                            }

                            if !(json[i].objectForKey("scene_id") is NSNull){
                                scene_id = json[i].objectForKey("scene_id")as! String
                            }
                            if !(json[i].objectForKey("size") is NSNull){
                                 size = json[i].objectForKey("size")as! String
                            }
                            if !(json[i].objectForKey("sms_regex") is NSNull){
                                sms_regex = json[i].objectForKey("sms_regex")as! String
                            }
                             if !(json[i].objectForKey("status") is NSNull){
                                status = (json[i].objectForKey("status")as! NSString).integerValue
                            }
                            if !(json[i].objectForKey("vproduct_desc") is NSNull){
                                vproduct_desc = json[i].objectForKey("vproduct_desc")as! String
                            }
                            if !(json[i].objectForKey("vproduct_key") is NSNull){
                                vproduct_key = json[i].objectForKey("vproduct_key")as! String
                            }
                            if !(json[i].objectForKey("vproduct_name") is NSNull){
                                vproduct_name = json[i].objectForKey("vproduct_name")as! String
                            }
                            if !(json[i].objectForKey("vproduct_short_name") is NSNull){
                                vproduct_short_name = json[i].objectForKey("vproduct_short_name")as! String
                            }
                            if !(json[i].objectForKey("vproduct_type") is NSNull){
                                vproduct_type = json[i].objectForKey("vproduct_type")as! String
                            }
                            model = AppsCellModel(id: i, beginDate: begin_date,customerId: customer_id, deductionAddRatio: deduction_add_ratio, demoURI: demoURI, downloadType: downloadType, downloadURI: downloadURI, download_count: download_count, endDate: end_date, imageUri: imageURI, inviteCode: invite_code, sceneId: scene_id,
                                size: size, smsRegex: sms_regex, status: status, vProductDesc: vproduct_desc, vProduct_key: vproduct_key, vProductName: vproduct_name,
                                vProductShortName: vproduct_short_name, vProductType: vproduct_type, rebate_prices: rebatePrices)
                           
                            self.rebateItem.append(model!)
                        }
                        
                    }
                    //调用代理方法
                    self.delegate?.transforValue(self.rebateItem,item2: self.rebateTypeItem,countMoney: countMoney,countMoneyRate: countMoneyRate)
                }
                case .Failure(let error):
                    print("返回报文: \(error)")
                    self.delegate?.transforValue(self.rebateItem)
                }
        }
    }
    
    
    //提交返利
    func doRebateRequest(telephone: String, rebate_type: String, auth_code: String, customer_id: String, scene_id: String){
        let user_key = UIDevice.currentDevice().identifierForVendor?.UUIDString
        var model: AppsCellModel?
        Alamofire.request(.POST, theme.doRebateURL, parameters: ["user_key": user_key!, "customer_id": customer_id, "telephone": telephone, "scene_id": scene_id, "rebate_type": rebate_type, "auth_code": auth_code])
            .responseJSON { response in
                switch response.result {
                case .Success:
                if let JSON = response.result.value {
                    //调用代理方法
                    print("返回报文\(JSON)")
                    var amount = ""
                    var customer_name = ""
                    var errors = ""
                    var messages = ""
                    var num = ""
                    var order_no = ""
                    var rebate_type = ""
                    var rebate_type_desc = ""
                    var time = ""
                    if !(JSON.objectForKey("amount") is NSNull){
                      let a = JSON.objectForKey("amount")as! NSNumber
                       amount = "\(a)"
                    }
                    if !(JSON.objectForKey("customer_name") is NSNull){
                        customer_name = JSON.objectForKey("customer_name")as! String
                    }
                    if !(JSON.objectForKey("errors") is NSNull){
                        errors = JSON.objectForKey("errors")as! String
                    }
                    if !(JSON.objectForKey("messages") is NSNull){
                        messages = JSON.objectForKey("messages")as! String
                    }
                    if !(JSON.objectForKey("num") is NSNull){
                        let b = JSON.objectForKey("num")as! NSNumber
                        num = "\(b)"
                    }
                    if !(JSON.objectForKey("order_no") is NSNull){
                        order_no = JSON.objectForKey("order_no")as! String
                        print("order_no:\(order_no)")
                    }
                    if !(JSON.objectForKey("rebate_type") is NSNull){
                        rebate_type = JSON.objectForKey("rebate_type")as! String
                    }
                    if !(JSON.objectForKey("rebate_type_desc") is NSNull){
                        rebate_type_desc = JSON.objectForKey("rebate_type_desc")as! String
                    }
                    if !(JSON.objectForKey("time") is NSNull){
                        time = JSON.objectForKey("time")as! String
                    }
                    model = AppsCellModel(amount: amount, customer_name: customer_name, errors: errors,messages: messages, num: num, order_no: order_no, rebate_type: rebate_type, rebate_type_desc: rebate_type_desc, time: time)
                    self.delegate?.transforSuccess(model!)
                }
                case .Failure(let error):
                    print("返回报文: \(error)")
                }
        }
        
    }
    
    
    //登录
    func loginRequest(url: String){

        
    }
    
   
    
    
    func doDownCount(vproduct_key: String, auth_code: String, customer_id: String, scene_id: String){
        let user_key = UIDevice.currentDevice().identifierForVendor?.UUIDString
        print("doDownCount 请求参数 vproduct_key: \(vproduct_key) auth_code: \(auth_code) customer_id : \(customer_id) scene_id: \(scene_id) user_key:\(user_key!)")
        var model: AppsCellModel?
        Alamofire.request(.POST, theme.doDownCountURL, parameters: ["user_key": user_key!, "vproduct_key": vproduct_key, "auth_code": auth_code, "scene_id": scene_id, "customer_id": customer_id, "open_id": ""])
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
    
    
    
    
    //获取城市列表
    func getArea(){
        var model: AreaModel?
        Alamofire.request(.GET, theme.getAreaURL, parameters: [:])
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let JSON = response.result.value {
                        if let json = JSON.objectForKey("areas"){
                            for var i = 0; i<json.count; i = i + 1{
                                var AREA_ID = ""
                                var AREA_NAME = ""
                                if !(json[i].objectForKey("AREA_ID") is NSNull){
                                    AREA_ID = json[i].objectForKey("AREA_ID")as! String
                                }
                                if !(json[i].objectForKey("AREA_NAME") is NSNull){
                                    AREA_NAME = json[i].objectForKey("AREA_NAME")as! String
                                }
                                model = AreaModel(area_id: AREA_ID, area_name: AREA_NAME)
                                self.areaItem.append(model!)
                            }
                        }
                        self.delegate?.transforSuccess(self.areaItem)
                    }
                case .Failure(let error):
                    print("返回报文 : \(error)")
                }
        }
    
    }
    
    
    
    
}