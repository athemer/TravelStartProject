//
//  ExtensionUIColor.swift
//  TravelStartProject
//
//  Created by kuanhuachen on 2018/4/27.
//  Copyright © 2018年 athemer. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    
    public convenience init(red_Int red: Int,
                            green_Int green: Int,
                            blue_Int blue: Int,
                            alpha: CGFloat = 1)
    {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    }
    
    
    public convenience init(hex_String: String)
    {
        let str = hex_String.replacingOccurrences(of: "#", with: "")
        guard str.count == 6 else {
            self.init(red_Int: 0, green_Int: 0, blue_Int: 0)
            return
        }
        let scanner = Scanner(string: str)
        
        var hexNumber: UInt32 = 0
        
        if scanner.scanHexInt32(&hexNumber)
        {
            let red = Int((hexNumber & 0xFF0000) >> 16)
            let green = Int((hexNumber & 0x00ff00) >> 8)
            let blue = Int((hexNumber & 0x0000ff))
            
            self.init(red_Int: red, green_Int: green, blue_Int: blue)
        } else {
            self.init(red_Int: 0, green_Int: 0, blue_Int: 0)
        }
    }
    
}
