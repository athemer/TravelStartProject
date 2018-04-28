//
//  DetailTableViewCell.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/28.
//  Copyright © 2018年 athemer. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    // MARK: IBOutlet
    @IBOutlet weak var title_Label: UILabel!
    @IBOutlet weak var content_TextView: UITextView!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(_ title: String, content: String)
    {
        
        title_Label.text = title
        content_TextView.text = content
        
    }

    
}
