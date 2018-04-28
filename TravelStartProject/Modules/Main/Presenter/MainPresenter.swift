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
        interactor.fetchData(with: 0)
    }
    
    func itemDidSelect(_ model: TouristSpotModel, index: Int)
    {
        router.presentNextView(with: model, index: index)
    }
    
    func loadData(withOffset offset: Int)
    {
        interactor.fetchData(with: offset)
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
