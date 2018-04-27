//
//  MainCollectionViewCell.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/26.
//  Copyright © 2018年 athemer. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageLoader: ImageLoader!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    public func setUpCell(_ url: URL?)
    {
        configureImageLoader()
    
        imageLoader.loadImageWithUrl(url)
        
    }
    
    private func configureImageLoader()
    {
        imageLoader.contentMode = .scaleAspectFit
        
        imageLoader.clipsToBounds = true
    }

}
