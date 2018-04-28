//
//  DetailContractor.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/28.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation
import UIKit

protocol DetailView: IndicatableView {
    
    var presenter: DetailPresentation! { get set }
    
    func showDetailView(_ model: TouristSpotModel, photoIndex: Int)
    
    func showNoContentScreen()
    
}

protocol DetailPresentation: class {
    
    weak var view: DetailView? { get set }
    
    var interactor: DetailUseCase! { get set }
    
    var router: DetailWireframe! { get set }
    
    func viewDidLoad()
    
}

protocol DetailUseCase: class {
    
    var output: DetailInteractorOutput! { get set }
    
    func fetchData()
    
}

protocol DetailInteractorOutput: class {
    
    func detailDataGetSuccessfully(_ model: TouristSpotModel)
    
    func detailDataFetchFailed()
    
}

protocol DetailWireframe: class {
    
    weak var viewController: UIViewController? { get set }
    
    static func assembleModule() -> UIViewController
    
}
