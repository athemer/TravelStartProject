//
//  MainInteractor.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/26.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation

class MainInteractor: MainUseCase {
    
    var output: MainInteractorOutput!
    var offset: Int = 0
    
    func fetchData()
    {
        
        let manager = TouristSpotManager()
        
        manager.sendRequest(offset: offset,
                            preSendHandler: { (isReachable) in
                                
                                
            
        }, successHandler: { [unowned self] (models) in
            
            print (" @@@@@ fetch data successHandler : Offset = \(self.offset)")
            
            self.output.dataFetchedSuccessfully(models)
            
        }, errorHandler: { [unowned self] (error) in
            
            print (" @@@@@ fetch data errorHandler : Offset = \(self.offset) ")
            
            self.output.dataFetchedFailed()
            
        }) { (isReachable) in
            
            
        }
        
    }
    
    
}
