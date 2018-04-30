//
//  DataLoaderTests.swift
//  TravelStartProjectTests
//
//  Created by kuanhuachen on 2018/4/29.
//  Copyright © 2018年 athemer. All rights reserved.
//

import XCTest
@testable import TravelStartProject


class DataLoaderTests: XCTestCase {
    
    var serverData: [[String: String?]]?
    
    override func setUp()
    {
        super.setUp()
        
    }
    
    override func tearDown()
    {
        serverData = nil
        super.tearDown()
    }
    
    func testMapping(){
        
        let decoder = JSONDecoder()
        
        serverData = [
            [
                "stitle": "新北投溫泉區",
                "xbody": "北投溫泉從日據時代便有盛名",
                "address": "臺北市  北投區中山路、光明路沿線",
                "file": "http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11000848.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11002891.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D315/E70/F65/1e0951fb-069f-4b13-b5ca-2d09df1d3d90.JPGhttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D260/E538/F274/e7d482ba-e3c0-40c3-87ef-3f2a1c93edfa.JPGhttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D919/E767/F581/9ddde70e-55c2-4cf0-bd3d-7a8450582e55.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C1/D28/E891/F188/77a58890-7711-4ca2-aebe-4aa379726575.JPG",
                "info": "新北投站下車，沿中山路直走即可到達公車：216、218、223、230、266、602、小6、小7、小9、、小22、小25、小26至新北投站下車",
                ],
            
            [
                "stitle": "新北投溫泉區",
                "xbody": "北投溫泉從日據時代便有盛名",
                "address": "臺北市  北投區中山路、光明路沿線",
                "file": nil,
                "info": "新北投站下車，沿中山路直走即可到達公車：216、218、223、230、266、602、小6、小7、小9、、小22、小25、小26至新北投站下車",
                ],
            [
                "stitle": "新北投溫泉區",
                "xbody": "北投溫泉從日據時代便有盛名",
                "address": "臺北市  北投區中山路、光明路沿線",
                "file": "http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11000848.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11002891.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D315/E70/F65/1e0951fb-069f-4b13-b5ca-2d09df1d3d90.JPGhttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D260/E538/F274/e7d482ba-e3c0-40c3-87ef-3f2a1c93edfa.JPGhttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D919/E767/F581/9ddde70e-55c2-4cf0-bd3d-7a8450582e55.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C1/D28/E891/F188/77a58890-7711-4ca2-aebe-4aa379726575.JPG",
                "info": nil
            ]
        ]
        
        do {
            
            let sitesArrayData = try JSONSerialization.data(withJSONObject: serverData!, options: .prettyPrinted)
            
            let touristModels = try decoder.decode([TouristSpotModel].self, from: sitesArrayData)
            
            XCTAssertTrue(touristModels.count > 0, "mapping successed")
            
        } catch {
            
            
        }

        
        
    }
    
    
    
    
}



