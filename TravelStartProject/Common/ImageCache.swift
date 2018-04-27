//
//  ImageCache.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/27.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation

class ImageCache: NSCache<AnyObject, AnyObject> {
    
    
//    static let sharedCache: NSCache = { () -> NSCache<AnyObject, AnyObject> in
//        let cache = NSCache<AnyObject, AnyObject>()
//        cache.name = "MyImageCache"
//        cache.countLimit = 20
//        cache.totalCostLimit = 10*1024*1024
//        return cache
//    }()
    
    
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
