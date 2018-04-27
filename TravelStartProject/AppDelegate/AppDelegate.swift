//
//  AppDelegate.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/25.
//  Copyright © 2018年 athemer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        RootRouter().presentMainPage(in: window!)

        return true
    }

    func applicationWillResignActive(_ application: UIApplication)
    {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication)
    {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication)
    {
    
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
    
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
    
    }


}

