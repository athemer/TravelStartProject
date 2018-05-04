//
//  ExtensionURL.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/27.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation
import UIKit


extension URL {
    
    func toCachedImage(url: String) -> UIImage?
    {
        return ImageCache(url: url).object(forKey: absoluteString as AnyObject) as? UIImage
    }
    
    
    
    func downloadImage(of url: String, completion: @escaping (UIImage) -> Void)
    {
        
        let task = URLSession.shared.dataTask(with: self) { (data, _, error) in
            
            guard
                error == nil
                else {
                    print(error?.localizedDescription ?? " could not get error message ")
                return
            }
            
            if let data = data,
               let image = UIImage(data: data) {
                
                ImageCache(url: url).setObject(image,
                                               forKey: self.absoluteString as AnyObject,
                                               cost: data.count)
                
                DispatchQueue.main.async()
                {
                    completion(image)
                }
            }
        }
        
        task.resume()
        
    }
    
    
}
