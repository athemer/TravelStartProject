//
//  ExtensionString.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/25.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation

extension String {
    
    public static let stopTask = "StopTask"
    public static let taskQueue = "TaskQueue"
    public static let mainTableViewCellId = "MainTableViewCell"
    public static let mainCollectionViewCellId = "MainCollectionViewCell"
    public static let mainStoryboard = "Main"
    public static let mainViewController = "MainViewController"
    
    func convertToURL() -> [URL]?
    {
        return
            self.components(separatedBy: "http://")
                .filter{ $0 != "" && $0.isJpgFiles() }
                .flatMap{ URL(string: "http://\($0)")}
    }
    
    func isJpgFiles() -> Bool
    {
        return self.hasSuffix("jpg".lowercased()) || self.hasSuffix("jpg".uppercased())
    }
    
}
