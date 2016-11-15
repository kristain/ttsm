//
//  AreaModel.swift
//  ttsm
//
//  Created by kristain on 16/8/23.
//  Copyright © 2016年 kristain. All rights reserved.
//

import Foundation

class AreaModel: NSObject{
    
    var area_id: String!
    
    var area_name: String!
    
    
    init(area_id: String, area_name: String) {
        self.area_id = area_id
        self.area_name = area_name
    }

    
}
