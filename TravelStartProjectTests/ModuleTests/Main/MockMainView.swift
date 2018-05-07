//
//  MockMainView.swift
//  TravelStartProjectTests
//
//  Created by kuanhuachen on 2018/4/30.
//  Copyright © 2018年 athemer. All rights reserved.
//


import Foundation
import UIKit
@testable import TravelStartProject


class MockMainView: MainView {
    
    
    var presenter: MainPresentation!
    
    var noContentScreenShowed: Bool = false
    
    var mainDataShowed: Bool = false
    
    var activityIndicatorShowed: Bool = false
    
    var activityIndicatorhided: Bool = false
    
    
    func showNoContentScreen() {
        noContentScreenShowed = true
    }
    
    func showMainData(_ models: [TouristSpotModel]) {
        mainDataShowed = true
    }
    
    func showActivityIndicator() {
        activityIndicatorShowed = true
    }
    
    func hideActivityIndicator() {
        activityIndicatorhided = true
    }
    
    func showNoMoreDataToShowAlert()
    {
        
    }
    
    func showError()
    {
        
    }
    
    func useCachedResponseAlert()
    {
        
    }
    
    func showNoInternetConnect()
    {
        
    }

}
