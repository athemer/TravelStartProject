//
//  ImageLoader.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/27.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: UIImageView {
    
    var imageURL: URL?
    
    let activityIndicator: UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView()
        indicator.color = .gray
        return indicator
    }()
    
    func loadImageWithUrl(_ url: URL?)
    {

        guard url != nil else { return }
        
        addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
        
        imageURL = url
        
        image = #imageLiteral(resourceName: "Placeholder")
        
        activityIndicator.startAnimating()
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage
        {
            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
            
        } else {
            
            URLSession.shared.dataTask(with: url!, completionHandler: { [unowned self] (data, response, error) in
                
                if error != nil
                {
                    print(" error when downloading image ", error.debugDescription)
                    self.activityIndicator.stopAnimating()
                    return
                }
                
                DispatchQueue.main.async(execute: {
                    
                    if let unwrappedData = data,
                       let imageToCache = UIImage(data: unwrappedData)
                    {
                        if self.imageURL == url
                        {
                            self.image = imageToCache
                        }
                        
                        imageCache.setObject(imageToCache, forKey: url as AnyObject)
                        
                    }
                    
                    self.activityIndicator.stopAnimating()
                    
                })
            }).resume()
        }
    }
}
