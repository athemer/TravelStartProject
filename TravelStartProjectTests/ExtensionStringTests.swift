//
//  ExtensionStringTests.swift
//  TravelStartProjectTests
//
//  Created by kuanhuachen on 2018/4/29.
//  Copyright © 2018年 athemer. All rights reserved.
//

import XCTest
@testable import TravelStartProject


class ExtensionTests: XCTestCase {
    
    
    var str: String = ""
    
    override func setUp()
    {
        super.setUp()
        
    }
    
    override func tearDown()
    {
        str = ""
        super.tearDown()
    }
    
    func testStringProperty()
    {
        let isEqual = "DetailCollectionViewCell" == String.detailCollectionViewCellId
        
        XCTAssertTrue(isEqual, "static string property work properly")
    }
    
    func testStrIsjpg()
    {
        str =
        """
        http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11001481.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C2/D74/E860/F223/f28f9ff0-a457-4687-8630-bb5bfb793d46.jpg
        """
        
        let isJpgFiles = str.isJpgFiles()
        
        XCTAssertTrue(isJpgFiles, "string is Jpg file with suffix (jpg)")
    }
    
    func testStrIsJPG()
    {
        str =
        """
        http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11001481.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C2/D74/E860/F223/f28f9ff0-a457-4687-8630-bb5bfb793d46.JPG
        """
        let isJpgFiles = str.isJpgFiles()
        
        XCTAssertTrue(isJpgFiles, "string is Jpg file with suffix (JPG)")
    }
    
    func testStrIsOthers()
    {
        str =
        """
        http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11001481.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C2/D74/E860/F223/f28f9ff0-a457-4687-8630-bb5bfb793d46.mp3
        """
        let isJpgFiles = str.isJpgFiles()
        
        XCTAssertFalse(isJpgFiles, "string is Jpg file with suffix (\(str.suffix(4))")
    }
    
    func testStringToURLs()
    {
        
        let URLs = [
            URL(string: "http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11001481.jpg"),
            URL(string: "http://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C2/D74/E860/F223/f28f9ff0-a457-4687-8630-bb5bfb793d46.jpg"),
            URL(string: "http://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C1/D611/E706/F767/6fb1cf1e-2a55-4f91-869f-c8f351eb930e.JPG")
        ]
        
        str =
        """
        http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11001481.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C2/D74/E860/F223/f28f9ff0-a457-4687-8630-bb5bfb793d46.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C1/D611/E706/F767/6fb1cf1e-2a55-4f91-869f-c8f351eb930e.JPGhttp://www.travel.taipei/streams/scenery_file_audio/c24.mp3http://www.travel.taipei/streams/video/DISC1-04.flv
        """
        let urls = str.convertToURL()
        
        XCTAssertEqual(urls?.count, URLs.count, "URL should be the same")
    }
    
    
}

