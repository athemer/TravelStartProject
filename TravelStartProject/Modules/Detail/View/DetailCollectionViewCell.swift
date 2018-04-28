//
//  DetailCollectionViewCell.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/28.
//  Copyright © 2018年 athemer. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageLoader: ImageLoader!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoader.image = nil
    }
    
    public func setUpCell(_ url: URL?)
    {
        
        configureImageLoader()
        
        imageLoader.loadImageWithUrl(url)
        
    }
    
    private func configureImageLoader()
    {
        imageLoader.contentMode = .scaleToFill
        
        imageLoader.clipsToBounds = true
    }
}
