//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by 曾超 on 15/12/3.
//  Copyright © 2015年 zengchao. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImage: UIImageView!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var productDescLabel: UILabel!
    
    
    @IBOutlet weak var demoButton: UIButton!

    @IBOutlet weak var inventCodeButton: UIButton!
    
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var downButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
