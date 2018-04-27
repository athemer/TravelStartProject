//
//  MainRouter.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/26.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation
import UIKit


var mainStoryBoard: UIStoryboard
{
    return UIStoryboard.init(name: .mainStoryboard, bundle: nil)
}

class MainRouter: MainWireframe
{
    
    
    var viewController: UIViewController?
    
    
    static func assembleModule() -> UIViewController
    {
        
        guard
            let view: MainViewController = mainStoryBoard.instantiateViewController(withIdentifier: .mainViewController) as? MainViewController
            else {
            fatalError(" cannnot cast MainViewController ")
        }
        
        let presenter = MainPresenter()
        let interactor = MainInteractor()
        let router = MainRouter()
        
        let navigationController = UINavigationController.init(rootViewController: view)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return navigationController
    }
    
    func presentNextView(with model: TouristSpotModel)
    {
        
        
        
    }
    
}
