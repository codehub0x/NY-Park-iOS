//
//  UIColor+iPark.swift
//  iPark
//
//  Created by King on 2019/12/25.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    open class var iDarkBlue: UIColor {
        return UIColor(rgb: 0x0A009C)
    }
    
    open class var iYellow: UIColor {
        return UIColor(rgb: 0xFCBA35)
    }
    
    open class var iBlack100: UIColor {
        return UIColor(rgb: 0x000203)
    }
    
    open class var iBlack95: UIColor {
        return UIColor(rgb: 0x343F4B)
    }
    
    open class var iBlack90: UIColor {
        return UIColor(rgb: 0x47525E)
    }
    
    open class var iBlack85: UIColor {
        return UIColor(rgb: 0x5A6978)
    }
    
    open class var iBlack80: UIColor {
        return UIColor(rgb: 0x8190A5)
    }
    
    open class var iBlack70: UIColor {
        return UIColor(rgb: 0x8492A6)
    }
    
    open class var iBlack60: UIColor {
        return UIColor(rgb: 0x838997)
    }
    
    open class var iBlack50: UIColor {
        return UIColor(rgb: 0x969FAA)
    }
    
    open class var iBlack40: UIColor {
        return UIColor(rgb: 0xE6E5F5)
    }
    
    open class var iGray: UIColor {
        return UIColor(rgb: 0x6A6A6A)
    }
    
    open class var iBlackBlue: UIColor {
        return UIColor(rgb: 0x2B2867)
    }
}
