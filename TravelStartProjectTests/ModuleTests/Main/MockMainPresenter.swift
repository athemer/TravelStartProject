//
//  MockPresenter.swift
//  TravelStartProjectTests
//
//  Created by kuanhuachen on 2018/4/30.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation
import UIKit
@testable import TravelStartProject


class MockPresenter: MainPresentation {
    
    
    var router: MainWireframe!
    
    var view: MainView?
    
    var interactor: MainUseCase!
    
    
    var fakeView = MockMainView()
    
    var fakeInteractor = MockMainInteractor()
    
    var fakeRouter = MockMainRouter()
    
    var models: [TouristSpotModel] = [] {
        
        didSet {
            
            if models.count > 0 {
                
                fakeView.showMainData(models)
                
            } else {
                
                fakeView.showNoContentScreen()
                
            }
            
        }
        
    }
    
    func viewDidLoad()
    {
        fakeView.showActivityIndicator()
        fakeInteractor.fetchData(with: 0)
    }
    
    func itemDidSelect(_ model: TouristSpotModel, index: Int)
    {
        fakeRouter.presentNextView(with: model, index: index)
    }
    
    func loadData(withOffset offset: Int)
    {
        fakeInteractor.fetchData(with: offset)
    }
    
    
}

extension MockPresenter: MainInteractorOutput {
    
    func noInternetConnect() {
        
    }
    
    
    func dataFetchedSuccessfully(_ models: [TouristSpotModel])
    {
        self.models = models
    }
    
    func dataFetchedFailed()
    {
        fakeView.showNoContentScreen()
        fakeView.hideActivityIndicator()
    }
    
}
