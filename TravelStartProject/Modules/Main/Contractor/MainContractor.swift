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
    
    func showNoInternetConnect()
    
    func showNoMoreDataToShowAlert()
    
    func showError()
    
    func useCachedResponseAlert()
    
}

protocol MainPresentation: class {
    
    weak var view: MainView? { get set }
    
    var interactor: MainUseCase! { get set }
    
    var router: MainWireframe! { get set }
    
    func viewDidLoad()
    
    func itemDidSelect(_ model: TouristSpotModel, index: Int)
    
    func loadData(withOffset offset: Int)
    
}


protocol MainUseCase: class {
    
    var output: MainInteractorOutput! { get set }
    
    func fetchData(with offset: Int)
    
}

protocol MainInteractorOutput: class {
    
    func dataFetchedSuccessfully(_ models: [TouristSpotModel])
    
    func dataFetchedFailed()
    
    func noInternetConnect()
    
    func useCachedResponse()
    
}

protocol MainWireframe: class {
    
    weak var viewController: UIViewController? { get set }
    
    func presentNextView(with model: TouristSpotModel, index: Int)
    
    static func assembleModule() -> UIViewController
}
