//
//  MainTableViewCellViewModel.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/5/4.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation

struct MainTableViewCellViewModel {
    
    let stitle: String
    let content: String
    let location: String
    let information: String?
    let photoURL: [URL]?
    
    init(model: TouristSpotModel)
    {
        stitle = model.stitle
        content = model.content
        location = model.location
        information = model.information
        photoURL = model.photos?.convertToURL()
    }
    
}
