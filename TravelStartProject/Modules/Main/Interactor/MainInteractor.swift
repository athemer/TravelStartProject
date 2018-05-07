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
    
    func fetchData(with offset: Int)
    {
        
        let manager = TouristSpotManager()
        
        manager.sendRequest(offset: offset,
                            preSendHandler: { (isReachable) in
                                
                                
                                if !isReachable
                                {
                                    self.output.noInternetConnect()
                                }
                                
            
        }, successHandler: { [unowned self] (models) in
            
            print (" @@@@@ fetch data successHandler : Offset = \(offset)")
            
            self.output.dataFetchedSuccessfully(models)
            
        }, errorHandler: { [unowned self] (error) in
            
            print (" @@@@@ fetch data errorHandler : Offset = \(offset) ")
            
            self.output.dataFetchedFailed()

            
        }) { [unowned self] (hasCache) in
            
            print (" @@@@@ use Cached Response : Offset = \(offset) ")
            
            if hasCache
            {
                self.output.useCachedResponse()
            }
    
        }
        
    }
    
    
}
