//
//  ImageCacheTests.swift
//  TravelStartProjectTests
//
//  Created by kuanhuachen on 2018/4/29.
//  Copyright © 2018年 athemer. All rights reserved.
//

import XCTest
@testable import TravelStartProject


let fakeimageCache = NSCache<AnyObject, AnyObject>()

class ImageCacheTests: XCTestCase {
    
    var fakeImageLoader: FakeImageLoader? = FakeImageLoader()

    class FakeImageLoader: UIImageView {
        
        func loadImageWithUrl(_ url: URL?) -> String
        {
            
            guard url != nil else { return "url does not exist"}
            
            image = nil

            
            if let imageFromCache = fakeimageCache.object(forKey: url as AnyObject) as? UIImage
            {
                self.image = imageFromCache
                return "image exist in cache"
                
            } else {
                
                URLSession.shared.dataTask(with: url!, completionHandler: { [unowned self] (data, response, error) in
                    
                    if error != nil
                    {
                        return
                    }
                    
                    DispatchQueue.main.async(execute: {
                        
                        if let unwrappedData = data,
                            let imageToCache = UIImage(data: unwrappedData)
                        {
                        
                            self.image = imageToCache
                            
                            
                            fakeimageCache.setObject(imageToCache, forKey: url as AnyObject)
                            
                        }
                    })
                }).resume()
                
                return "cached downloaded image"
            }
        }
    }
    
    override func setUp()
    {
        super.setUp()

    }
    
    override func tearDown()
    {
        
        super.tearDown()
        
    }
    
    
    func testImageCache()
    {
        
        let url = URL(string: "http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11001481.jpg")
        
        if fakeImageLoader!.loadImageWithUrl(url) == "cached downloaded image"
        {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5 , execute: {
                
                let isSuccess = self.fakeImageLoader!.loadImageWithUrl(url) == "cached downloaded image"
                
                XCTAssertTrue(isSuccess, "cache image successfully")
                
            })
            
        } else {
            
            XCTFail("cache image fail")
            
        }
        
    }
    
    
    
}
