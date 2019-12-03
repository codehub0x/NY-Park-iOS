//
//  ErrorTextField.swift
//  iPark
//
//  Created by King on 2019/12/3.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import UIKit

class ErrorTextField: UITextField {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initialErrorIcon()
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
        initialErrorIcon()
    }
    
    func initialErrorIcon() {
        let errorImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        errorImageView.image = UIImage(named: "icon-error")
        errorImageView.contentMode = .center
        
        self.rightView = errorImageView
        self.rightViewMode = .always
        self.rightView?.isHidden = true
    }
}
