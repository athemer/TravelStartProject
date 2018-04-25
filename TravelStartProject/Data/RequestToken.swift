//
//  RequestToken.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/25.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation

class RequestToken {
    
    private weak var task: URLSessionTask?
    
    init(task: URLSessionTask? = nil)
    {
        self.task = task
    }
    
    func cancel()
    {
        task?.cancel()
    }
    
}
