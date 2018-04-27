//
//  RootRouter.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/27.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation
import UIKit

class RootRouter: RootWireframe {
    
    func presentMainPage(in window: UIWindow)
    {
        window.makeKeyAndVisible()
        window.rootViewController = MainRouter.assembleModule()
    }
    
}
