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
    
    func viewDidLoad() {
        
    }

}

extension DetailPresenter: DetailInteractorOutput {
    
    func detailDataGetSuccessfully(_ model: TouristSpotModel) {
        
    }
    
    func detailDataFetchFailed() {
        
    }
    
}
