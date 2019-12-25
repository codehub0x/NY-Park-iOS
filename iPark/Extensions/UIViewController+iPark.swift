//
//  UIViewController+iPark.swift
//  iPark
//
//  Created by King on 2019/12/25.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func getNavigationController() -> UINavigationController {
        let navVC = UINavigationController(rootViewController: self)
        
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.barTintColor = UIColor.iDarkBlue
        navVC.navigationBar.tintColor = UIColor.white
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: LatoFont.bold(with: 20)]
        navVC.navigationBar.barStyle = .black
        
        return navVC
    }
    
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
