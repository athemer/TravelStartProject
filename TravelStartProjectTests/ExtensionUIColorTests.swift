//
//  ExtensionUIColorTests.swift
//  TravelStartProjectTests
//
//  Created by kuanhuachen on 2018/4/29.
//  Copyright © 2018年 athemer. All rights reserved.
//

import XCTest
@testable import TravelStartProject


class ExtensionUIColorTests: XCTestCase {
    
    override func setUp()
    {
        super.setUp()
        
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testCcolorRGBtoHEX()
    {
        let color1 = UIColor(hex_String: "3EC1ED")
        
        let color2 = UIColor(red: 62/255, green: 193/255, blue: 237/255, alpha: 1)
        
        XCTAssertEqual(color1, color2, "colorRGBtoHEX works fine")
    }
    
    
}
