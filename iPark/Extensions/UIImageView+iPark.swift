//
//  UIImageView+iPark.swift
//  iPark
//
//  Created by King on 2019/12/25.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
  func rotate(withAngle angle: CGFloat, animated: Bool) {
    UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
       self.transform = CGAffineTransform(rotationAngle: angle)
    })
  }
}
