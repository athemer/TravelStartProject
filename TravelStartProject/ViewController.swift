//
//  ViewController.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/25.
//  Copyright © 2018年 athemer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getdata()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getdata(){
        
        let manager = TouristSpotManager()
        
        manager.sendRequest(offset: 0, preSendHandler: { (isReachable) in
            
        }, successHandler: { (array) in
            
            print (" @@@@@ GOT DATA")
            
        }, errorHandler: { (error) in
            
            print (" @@@@ ERROR")
            
        }) { (isReachable) in
            
        }

    }

}

