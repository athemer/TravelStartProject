//
//  ApiCallTests.swift
//  TravelStartProjectTests
//
//  Created by kuanhuachen on 2018/4/29.
//  Copyright © 2018年 athemer. All rights reserved.
//

import XCTest
@testable import TravelStartProject


class ApiCallTests: XCTestCase {
    
    class FakeGetTouristSpotApi: BaseApi {
        
        var result: [TouristSpotModel]?
        var error: NetworkError?
        
        func execute(success: Bool,
                     preSendHandler: @escaping (_ isReachable: Bool) -> Void,
                     successHandler: @escaping ([TouristSpotModel]?) -> Void,
                     errorHandler: @escaping  (Error?) -> Void,
                     finalHandler: @escaping (_ isReachable: Bool) -> Void)
        {

            if success
            {
                successHandler(result)
                
            } else {
                
                errorHandler(error)
                
            }
        
        }
        
    }
    
    var fakeGetTouristSpotApi: FakeGetTouristSpotApi?

    override func setUp()
    {
        super.setUp()
        
        fakeGetTouristSpotApi = FakeGetTouristSpotApi()
    }
    
    override func tearDown()
    {
        fakeGetTouristSpotApi = nil
        
        super.tearDown()
    }
    
    func testSuccess()
    {
        fakeGetTouristSpotApi?.result = [TouristSpotModel(stitle: "title", content: "content", location: "location", information: "info", photos: "photo")]
        
        let promise = self.expectation(description: "Did get data")
        
        fakeGetTouristSpotApi?.execute(success: true, preSendHandler: { (Bool) in
            
        }, successHandler: { (result) in
            
            result != nil ? promise.fulfill() : XCTFail(" have data but return nil ")
            
        }, errorHandler: { (error) in
            
        }, finalHandler: { (Bool) in
            
        })
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFailure()
    {
        fakeGetTouristSpotApi?.result = nil
        
        let promise = self.expectation(description: "Result is nil and return nil")
        
        fakeGetTouristSpotApi?.execute(success: false, preSendHandler: { (Bool) in
            
        }, successHandler: { (result) in
            
            result == nil ? promise.fulfill() : XCTFail(" Result is nil and return data ")
            
        }, errorHandler: { (error) in
            
        }, finalHandler: { (Bool) in
            
        })
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    
}
