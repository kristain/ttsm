//
//  DataRequestDelegate.swift
//  ttsm
//
//  Created by kristain on 16/8/15.
//  Copyright © 2016年 kristain. All rights reserved.
//  字典转模型

import Foundation

protocol DataRequestDelegate{
    func transforValue(item1:AnyObject)
    func transforValue(item1:AnyObject, item2:AnyObject,countMoney: Double, countMoneyRate: Double)
    func transforSuccess(item1:AnyObject)
}