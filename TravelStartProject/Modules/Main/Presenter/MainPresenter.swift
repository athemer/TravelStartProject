//
//  MainPresenter.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/26.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation

class MainPresenter: MainPresentation {
    
    var view: MainView?
    
    var interactor: MainUseCase!
    
    var router: MainWireframe!
    
    var models: [TouristSpotModel] = [] {
        
        didSet {

            if models.count > 0 {
                
                view?.showMainData(models)
                
            } else {
                
                view?.showNoContentScreen()
                
            }
            
        }
        
    }
    
    func viewDidLoad()
    {
        view?.showActivityIndicator()
        interactor.fetchData()
    }
    
    func itemDidSelect(_ model: TouristSpotModel)
    {
        router.presentNextView(with: model)
    }
    

}

extension MainPresenter: MainInteractorOutput {
    
    func dataFetchedSuccessfully(_ models: [TouristSpotModel])
    {
        self.models = models
    }
    
    func dataFetchedFailed()
    {
        view?.showNoContentScreen()
        view?.hideActivityIndicator()
    }
    
}
