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
        
        func loadImageWithUrl(_ url: URL?, completion: @escaping (_ result: String) -> Void)
        {
            
            guard url != nil else { return }
            
            image = nil

            
            if let imageFromCache = fakeimageCache.object(forKey: url as AnyObject) as? UIImage
            {
                self.image = imageFromCache
                completion("Image exsit in cache")
                
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
                            
                            completion( "cached downloaded image")
                        }
                    })
                }).resume()
                
                
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
        
        let expectation = self.expectation(description: " image cached succussfully ")
        
        let url = URL(string: "http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11001481.jpg")
        
        
        fakeImageLoader?.loadImageWithUrl(url, completion: { [unowned self] (string) in
            
            if string == "cached downloaded image"
            {
                
                self.fakeImageLoader?.loadImageWithUrl(url, completion: { (str) in
                    
                    if str == "Image exsit in cache" {
                        expectation.fulfill()
                    }
                    
                })
                
            }
            
        })
        
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    
    
}
