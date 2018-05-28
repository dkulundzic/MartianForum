//
//  UIColor-Martian.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Float, green: Float, blue: Float, alpha: Float = 1.0) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}

extension UIColor {
    static var martianRed: UIColor {
        return UIColor(red: 239, green: 64, blue: 89)
    }
    
    static var martianDark: UIColor {
        return UIColor(red: 61, green: 61, blue: 61)
    }
    
    static var martianDarkGray: UIColor {
        return UIColor(red: 142, green: 142, blue: 142)
    }
    
    static var martianGray: UIColor {
        return UIColor(red: 199, green: 199, blue: 199)
    }
    
    static var martianLightGray: UIColor {
        return UIColor(red: 245, green: 245, blue: 245)
    }
}
