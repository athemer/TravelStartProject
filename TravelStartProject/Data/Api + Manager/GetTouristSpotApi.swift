//
//  GetTouristSpotApi.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/25.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation

class GetTouristSpotApi: BaseApi {
    
    func execute(inBackground: Bool = false,
                 offset: Int,
                 preSendHandler: @escaping (_ isReachable: Bool) -> Void,
                 successHandler: @escaping (_ response: Data?) -> Void,
                 errorHandler: @escaping (_ error: NetworkError) -> Void,
                 finalHandler: @escaping (_ hasCache: Bool) -> Void)
    {
            exchange(inBackground: inBackground, requestBlock: { (request: BaseAlamofireRequest) in
            request.method = .get
            request.url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=36847f3f-deff-4183-a5bb-800737591de5&offset=\(offset)&limit=10"
            request.requestTimeout = 10
            request.resourceTimeout = 10
        }, preSendHandler: preSendHandler, successHandler: successHandler, errorHandler: errorHandler, finalHandler: finalHandler)
    }
    
}
