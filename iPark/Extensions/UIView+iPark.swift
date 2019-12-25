//
//  UIView+iPark.swift
//  iPark
//
//  Created by King on 2019/12/25.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func showFlip() {
        if self.isHidden {
            UIView.transition(with: self, duration: 1, options: [.transitionFlipFromRight,.allowUserInteraction], animations: {
                self.isHidden = false
            })
        }
    }
    
    func hideFlip() {
        if !self.isHidden {
            UIView.transition(with: self, duration: 1, options: [.transitionFlipFromRight,.allowUserInteraction], animations: nil, completion: { _ in
                self.isHidden = true
            })
            
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

extension CALayer {

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

        let border = CALayer()

        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: UIScreen.main.bounds.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }

        border.backgroundColor = color.cgColor;

        self.addSublayer(border)
    }

}
