//
//  MockRouter.swift
//  TravelStartProjectTests
//
//  Created by kuanhuachen on 2018/4/30.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation
import UIKit
@testable import TravelStartProject

class MockMainRouter: MainWireframe
{
    
    
    var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController
    {
        
        guard
            let view: MainViewController = mainStoryBoard.instantiateViewController(withIdentifier: .mainViewController) as? MainViewController
            else {
                fatalError(" cannnot cast MainViewController ")
        }
        
        let presenter = MockPresenter()
        let interactor = MockMainInteractor()
        let router = MockMainRouter()
        
        let navigationController = UINavigationController.init(rootViewController: view)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return navigationController
    }
    
    func presentNextView(with model: TouristSpotModel, index: Int)
    {
        
        let detailRouteControl = DetailRouter.assembleModule(with: model, index: index)
        viewController?.navigationController?.pushViewController(detailRouteControl, animated: true)
        
    }
    
}
