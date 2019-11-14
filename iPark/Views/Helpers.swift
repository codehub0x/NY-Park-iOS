//
//  Helpers.swift
//  iPark
//
//  Created by King on 2019/11/13.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func showFlip(){
        if self.isHidden {
            UIView.transition(with: self, duration: 0.5, options: [.transitionFlipFromRight,.allowUserInteraction], animations: nil, completion: nil)
            self.isHidden = false
        }
    }
    
    func hideFlip(){
        if !self.isHidden {
            UIView.transition(with: self, duration: 0.5, options: [.transitionFlipFromLeft,.allowUserInteraction], animations: nil,  completion: nil)
            self.isHidden = true
        }
    }
    
    func showFade() {
        if self.isHidden {
            UIView.transition(with: self, duration: 2, options: [.curveEaseIn, .allowUserInteraction], animations: nil, completion: nil)
            self.isHidden = false
        }
    }
    
    func hideFade() {
        if !self.isHidden {
            UIView.transition(with: self, duration: 1, options: [.curveEaseIn, .allowUserInteraction], animations: nil, completion: nil)
            self.isHidden = true
        }
    }
}

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
    
    open class var iBlack90: UIColor {
        return UIColor(rgb: 0x47525E)
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
}
