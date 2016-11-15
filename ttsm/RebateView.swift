//
//  RebateView.swift
//  ttsm
//
//  Created by kristain on 16/8/19.
//  Copyright © 2016年 kristain. All rights reserved.
//

import UIKit
import RadioButton
class RebateView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var weixinBtn: RadioButton!
    
    @IBOutlet weak var huafeiBtn: RadioButton!
    
    @IBOutlet weak var hongbaobtn: RadioButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
}

