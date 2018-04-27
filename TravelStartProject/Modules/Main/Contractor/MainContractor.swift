//
//  MainContractor.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/26.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation
import UIKit

protocol MainView: IndicatableView {
    
    var presenter: MainPresentation! { get set }
    
    func showNoContentScreen()
    
    func showMainData(_ models: [TouristSpotModel])

}

protocol MainPresentation: class {
    
    weak var view: MainView? { get set }
    
    var interactor: MainUseCase! { get set }
    
    var router: MainWireframe! { get set }
    
    func viewDidLoad()
    
    func itemDidSelect(_ model: TouristSpotModel)
    
    func loadData(withOffset offset: Int)
    
}


protocol MainUseCase: class {
    
    var output: MainInteractorOutput! { get set }
    
//    var offset: Int! { get set }
    
    func fetchData()
    
}

protocol MainInteractorOutput: class {
    
    func dataFetchedSuccessfully(_ models: [TouristSpotModel])
    
    func dataFetchedFailed()
    
}

protocol MainWireframe: class {
    
    weak var viewController: UIViewController? { get set }
    
    func presentNextView(with model: TouristSpotModel)
    
    static func assembleModule() -> UIViewController
}
