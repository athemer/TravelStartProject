//
//  ImageCache.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/27.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation

class ImageCache: NSCache<AnyObject, AnyObject> {
    
    var url: String
    
    init(url: String)
    {
        self.url = url
        super.init()
        self.name = url
        self.countLimit = 20
        self.totalCostLimit = 10 * 1024 * 1024
    }
    
}
