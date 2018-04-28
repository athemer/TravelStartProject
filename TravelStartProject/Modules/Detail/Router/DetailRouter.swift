//
//  DetailRouter.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/28.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation
import UIKit

var detailStoryBoard: UIStoryboard {
    return UIStoryboard.init(name: .detailStoryboard, bundle: nil)
}

class DetailRouter: DetailWireframe {
    
    var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        guard
            let view: DetailViewController = detailStoryBoard.instantiateViewController(withIdentifier: .detailViewController) as? DetailViewController
            else {
                fatalError(" cannnot cast DetailViewController ")
        }
        
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
    
}
