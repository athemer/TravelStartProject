//
//  DetailPresenter.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/28.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation

class DetailPresenter: DetailPresentation {
    
    var view: DetailView?
    
    var interactor: DetailUseCase!
    
    var router: DetailWireframe!
    
    var index: Int!
    
    var model: TouristSpotModel! {
        
        didSet
        {
            view?.showDetailView(model, photoIndex: index)
        }
        
    }
    
    func viewDidLoad()
    {
        view?.showActivityIndicator()
    }

}

extension DetailPresenter: DetailInteractorOutput {
    
    func detailDataGetSuccessfully(_ model: TouristSpotModel)
    {
        view?.hideActivityIndicator()
    }
    
    func detailDataFetchFailed()
    {
        view?.hideActivityIndicator()
    }
    
}
