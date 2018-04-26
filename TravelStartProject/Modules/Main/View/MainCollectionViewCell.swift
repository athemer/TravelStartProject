//
//  MainCollectionViewCell.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/26.
//  Copyright © 2018年 athemer. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var img_ImageView: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    public func setUpCell(_ image: UIImage)
    {
        img_ImageView.image = image
    }

}
