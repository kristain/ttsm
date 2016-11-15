//
//  RebateModel.swift
//  ttsm
//
//  Created by kristain on 16/8/24.
//  Copyright © 2016年 kristain. All rights reserved.
//

import Foundation

class RebateModel: NSObject {
    
    var amount: String!
    var rebate_desc: String!
    var rebate_desc_result: String!
    var rebate_desc_list: String!
    var rebate_name: String!
    init(amount: String, rebate_desc: String, rebate_desc_result: String, rebate_desc_list: String, rebate_name: String) {
        self.amount = amount
        self.rebate_desc = rebate_desc
        self.rebate_desc_result = rebate_desc_result
        self.rebate_name = rebate_name
        self.rebate_desc_list = rebate_desc_list
    }
}
