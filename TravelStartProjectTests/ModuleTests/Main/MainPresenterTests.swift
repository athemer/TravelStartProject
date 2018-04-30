//
//  MainPresenterTests.swift
//  TravelStartProjectTests
//
//  Created by kuanhuachen on 2018/4/30.
//  Copyright © 2018年 athemer. All rights reserved.
//


import XCTest
@testable import TravelStartProject

class MainPresenterTests: XCTestCase {
    
    var presenter = MockPresenter()
    
    var interactor = MockMainInteractor()
    
    var view = MockMainView()
    
    var router = MockMainRouter()
    
    override func setUp()
    {
        super.setUp()
        presenter.fakeInteractor = interactor
        presenter.fakeRouter = router
        presenter.fakeView = view
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchDataFailed()
    {
        
        presenter.dataFetchedFailed()
        
        XCTAssertTrue(view.noContentScreenShowed, "SUCCESSFULY SHOW NO DATA SCREEN")
        
    }
    
    
}
