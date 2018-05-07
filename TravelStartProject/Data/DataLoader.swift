//
//  DataLoader.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/25.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkError: Error
{
    
    case dataTaskError
    case parseError
    case formURLFail
    
}


public class BaseAlamofireRequest {
    
    public var url: URLConvertible!
    public var method: HTTPMethod!
    public var parameters: Parameters?
    public var encoding: ParameterEncoding = URLEncoding.default
    public var headers: HTTPHeaders?
    public var requestTimeout: TimeInterval = 10
    public var resourceTimeout: TimeInterval = 30
    
    func initWithBlock(requestBlock: (BaseAlamofireRequest) -> Void) -> BaseAlamofireRequest
    {
        let baseAlamofireRequest: BaseAlamofireRequest = BaseAlamofireRequest()
        requestBlock(baseAlamofireRequest)
        return baseAlamofireRequest
    }
    
}


public class BaseApi {

    private var sessionRequest: DataRequest!
    
    public init()
    {
        self.setupNotifications()
    }
    
    private func setupNotifications()
    {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(stopRequest),
                                               name: Notification.Name(rawValue: .stopTask),
                                               object: nil)
    }

    @objc private func stopRequest(_ notification: Notification)
    {
        sessionRequest.cancel()
    }
    
    func isReachable() -> Bool
    {
        return (Alamofire.NetworkReachabilityManager()?.isReachable)!
    }
    
    func hasCache() -> Bool
    {
        return URLCache.shared.cachedResponse(for: sessionRequest.request!) != nil
    }
    

    func exchange(inBackground: Bool = false,
                         requestBlock: @escaping (_ request: BaseAlamofireRequest) -> Void,
                         preSendHandler: @escaping (_ isReachable: Bool) -> Void,
                         successHandler: @escaping (_ response: Data?) -> Void,
                         errorHandler: @escaping (_ error: NetworkError) -> Void,
                         finalHandler: @escaping (_ hasCache: Bool) -> Void)
    {
        
        let request: BaseAlamofireRequest = BaseAlamofireRequest().initWithBlock { (request) in
            requestBlock(request)
        }
        
        let sessionManager: Alamofire.SessionManager = {
            
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = request.requestTimeout
            configuration.timeoutIntervalForResource = request.resourceTimeout
            
            let cache = URLCache(memoryCapacity: 5 * 1024 * 1024, diskCapacity: 5 * 1024 * 1024, diskPath: nil)
            
            configuration.urlCache = cache
            
            let manager = Alamofire.SessionManager(configuration: configuration,
                                                   delegate: SessionDelegate(),
                                                   serverTrustPolicyManager: nil)
            
            return manager
        }()
        
        let completionHandler: (DataResponse<Any>) -> Void = { (response) in
            
            sessionManager.session.invalidateAndCancel()
            
            if let _ = response.result.error
            {
                errorHandler(.dataTaskError)
                
                if self.hasCache() {
                    finalHandler(self.hasCache())
                }
                
                
            } else {
                
                let value = response.data
                
                let cachedResponse = CachedURLResponse(response: response.response!, data: response.data!, userInfo: nil, storagePolicy: .allowed)
            
                URLCache.shared.storeCachedResponse(cachedResponse, for: self.sessionRequest.request!)
                
                successHandler(value)
                
            }
            
        }
        
    
        self.sessionRequest = sessionManager.request(request.url!,
                                                     method: request.method!,
                                                     parameters: request.parameters,
                                                     encoding: request.encoding,
                                                     headers: request.headers)
        
        
        
        
        let isReachable: Bool = self.isReachable()
        
        
        
        if !isReachable
        {
            
            
            if let cachedResponse = URLCache.shared.cachedResponse(for: sessionRequest.request!)
            {
                let response = cachedResponse.data
                
                sessionManager.session.invalidateAndCancel()
                
                successHandler(response)
                finalHandler(self.hasCache())
                
            }
            else {

                preSendHandler(isReachable)

            }
            
            sessionRequest.cancel()
            
        }

        if inBackground
        {
            let queue = DispatchQueue(label: .taskQueue, qos: .utility, attributes: [.concurrent])
            self.sessionRequest.responseJSON(queue: queue, options: JSONSerialization.ReadingOptions.allowFragments, completionHandler: { (response: DataResponse<Any>) in
                completionHandler(response)
            })
        } else {
            self.sessionRequest.responseJSON(completionHandler: { (response: DataResponse<Any>) in
                completionHandler(response)
            })
        }

    }
}

