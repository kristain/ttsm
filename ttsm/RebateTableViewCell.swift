//
//  RebateTableViewCell.swift
//  ttsm
//
//  Created by kristain on 16/8/24.
//  Copyright © 2016年 kristain. All rights reserved.
//

import UIKit

class RebateTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImage: UIImageView!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var downMoney: UILabel!
    @IBOutlet weak var downLabel: UILabel!
    @IBOutlet weak var attentionMoney: UILabel!
    @IBOutlet weak var attentionLabel: UILabel!
    @IBOutlet weak var signMoney: UILabel!
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var productDescLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
