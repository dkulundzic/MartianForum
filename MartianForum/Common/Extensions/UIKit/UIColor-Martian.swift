//
//  UIColor-Martian.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(redComponent: CGFloat, greenComponent: CGFloat, blueComponent: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: redComponent / 255.0, green: greenComponent / 255.0, blue: blueComponent / 255.0, alpha: alpha)
    }
}

extension UIColor {
    static var martianRed: UIColor {
        return UIColor(redComponent: 239, greenComponent: 64, blueComponent: 89)
    }
    
    static var martianDark: UIColor {
        return UIColor(redComponent: 61, greenComponent: 61, blueComponent: 61)
    }
    
    static var martianDarkGray: UIColor {
        return UIColor(redComponent: 142, greenComponent: 142, blueComponent: 142)
    }
    
    static var martianGray: UIColor {
        return UIColor(redComponent: 199, greenComponent: 199, blueComponent: 199)
    }
    
    static var martianLightGray: UIColor {
        return UIColor(redComponent: 245, greenComponent: 245, blueComponent: 245)
    }
}
