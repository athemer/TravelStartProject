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
    

    func exchange(inBackground: Bool = false,
                         requestBlock: @escaping (_ request: BaseAlamofireRequest) -> Void,
                         preSendHandler: @escaping (_ isReachable: Bool) -> Void,
                         successHandler: @escaping (_ response: Data?) -> Void,
                         errorHandler: @escaping (_ error: NetworkError) -> Void,
                         finalHandler: @escaping (_ isReachable: Bool) -> Void)
    {
        
        let request: BaseAlamofireRequest = BaseAlamofireRequest().initWithBlock { (request) in
            requestBlock(request)
        }
        
        let sessionManager: Alamofire.SessionManager = {
            
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = request.requestTimeout
            configuration.timeoutIntervalForResource = request.resourceTimeout
            
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
                finalHandler(self.isReachable())
                
            } else {
                
                let value = response.data
                successHandler(value)
                finalHandler(self.isReachable())
            }
        }
        
    
        self.sessionRequest = sessionManager.request(request.url!,
                                                     method: request.method!,
                                                     parameters: request.parameters,
                                                     encoding: request.encoding,
                                                     headers: request.headers)
        
        let isReachable: Bool = self.isReachable()
        
        preSendHandler(isReachable)
        
        if !isReachable
        {
            sessionRequest.cancel()
            finalHandler(isReachable)
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

