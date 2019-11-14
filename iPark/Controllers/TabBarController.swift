//
//  ViewController.swift
//  iPark
//
//  Created by King on 2019/11/13.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let tag = viewController.tabBarItem.tag
        switch tag {
        case 2:
            if let newVC = tabBarController.storyboard?.instantiateViewController(identifier: "ReservationsViewController") {
                let navVC = prepareNavigationController(newVC)
                navVC.modalPresentationStyle = .overFullScreen
                tabBarController.present(navVC, animated: true)
                return false
            }
            break;
        case 3:
            if let newVC = tabBarController.storyboard?.instantiateViewController(identifier: "RewardsViewController") {
                let navVC = prepareNavigationController(newVC)
                navVC.modalPresentationStyle = .overFullScreen
                tabBarController.present(navVC, animated: true)
                return false
            }
            break;
        case 4:
            if let newVC = tabBarController.storyboard?.instantiateViewController(identifier: "MenuViewController") {
                newVC.modalPresentationStyle = .overFullScreen
                newVC.modalTransitionStyle = .crossDissolve
                tabBarController.present(newVC, animated: true)
                return false
            }
            break;
        default:
            break;
        }
        return true
    }
}

fileprivate extension TabBarController {
    func prepareNavigationController(_ controller: UIViewController) -> UINavigationController {
        let navVC = UINavigationController(rootViewController: controller)
        
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.barTintColor = UIColor.iDarkBlue
        navVC.navigationBar.tintColor = UIColor.white
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium)]
        navVC.navigationBar.barStyle = .black
        
        return navVC
    }
}

