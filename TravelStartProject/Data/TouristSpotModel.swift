//
//  TouristSpotModel.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/25.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation

struct TouristSpotModel: Codable {
    
    var stitle: String
    var content: String
    var location: String
    var information: String
    var photos: String?
    
    var photoURL: [URL]? {
        return photos?.convertToURL()
    }
    
    enum CodingKeys: String, CodingKey
    {
        
        case stitle
        case content = "xbody"
        case location = "address"
        case information = "info"
        case photos = "file"
        
    }

}
