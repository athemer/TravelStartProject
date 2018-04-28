//
//  DetailViewController.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/28.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController  {
    
    var presenter: DetailPresentation!
    
    
}

extension DetailViewController: DetailView {
    
    func showDetailView(_ model: TouristSpotModel, photoIndex: Int) {
        
    }
    
    func showNoContentScreen() {
        
    }
    
    func showActivityIndicator() {
        
    }
    
    func hideActivityIndicator() {
        
    }
    
}
