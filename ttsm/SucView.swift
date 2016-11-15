//
//  SucView.swift
//  ttsm
//
//  Created by kristain on 16/8/20.
//  Copyright © 2016年 kristain. All rights reserved.
//

import UIKit

class SucView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var time_text: UILabel!
    
    @IBOutlet weak var Label5: UILabel!
    @IBOutlet weak var Label4: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var customer_name: UILabel!
    @IBOutlet weak var order: UILabel!
    
    @IBOutlet weak var select_type: UILabel!
    @IBOutlet weak var fanli_text: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
