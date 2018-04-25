//
//  TouristSpotManager.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/25.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation

class TouristSpotManager {
    
    
    func sendRequest(inBackground: Bool = false,
                     offset: Int,
                     preSendHandler: @escaping (_ isReachable: Bool) -> Void,
                     successHandler: @escaping (_ model_Array: [TouristSpotModel]) -> Void,
                     errorHandler: @escaping (_ response: NetworkError) -> Void,
                     finalHandler: @escaping (_ isReachable: Bool) -> Void)
    {
        GetTouristSpotApi().execute(inBackground: inBackground, offset: offset, preSendHandler: preSendHandler, successHandler: { (response) in
            
            guard
                response != nil
                else {
                    errorHandler(.dataTaskError)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let sitesObject = try JSONSerialization.jsonObject(with: response!, options: []) as? [String: AnyObject]
                
                guard
                    let result = sitesObject?["result"] as? [String: AnyObject],
                    let sitesArray = result["results"] as? [AnyObject]
                    else {
                        errorHandler(.parseError)
                        return }
                
                let sitesArrayData = try JSONSerialization.data(withJSONObject: sitesArray, options: .prettyPrinted)
                let touristModels = try decoder.decode([TouristSpotModel].self, from: sitesArrayData)
                
                successHandler(touristModels)
                
            } catch {
                
                errorHandler(.parseError)
                
            }
            
        }, errorHandler: errorHandler, finalHandler: finalHandler)
    }
}
