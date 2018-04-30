//
//  MockMainInteractor.swift
//  TravelStartProjectTests
//
//  Created by kuanhuachen on 2018/4/30.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation
import UIKit
@testable import TravelStartProject


class MockMainInteractor: MainUseCase {
    
    var output: MainInteractorOutput!
    
    let models = [TouristSpotModel(stitle: "title", content: "content", location: "location", information: "info", photos: "photos"),
                  TouristSpotModel(stitle: "title", content: "content", location: "location", information: "info", photos: "photos"),
                  TouristSpotModel(stitle: "title", content: "content", location: "location", information: "info", photos: "photos")]
    
    func fetchData(with offset: Int)
    {
        if offset == 0 {
            self.output.dataFetchedFailed()
        } else {
            self.output.dataFetchedSuccessfully(models)
        }
        
    }
    
}
