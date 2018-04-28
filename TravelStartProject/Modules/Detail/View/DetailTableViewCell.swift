//
//  DetailTableViewCell.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/28.
//  Copyright © 2018年 athemer. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var title_Label: UILabel!
    @IBOutlet weak var content_TextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
