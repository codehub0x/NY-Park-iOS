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
        prepareTabBar()
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
            var vc: UIViewController!
            if #available(iOS 13.0, *) {
                vc = tabBarController.storyboard?.instantiateViewController(identifier: "ReservationsViewController")
            } else {
                // Fallback on earlier versions
                vc = tabBarController.storyboard?.instantiateViewController(withIdentifier: "ReservationsViewController")
            }
            if let newVC = vc {
                let navVC = prepareNavigationController(newVC)
                navVC.modalPresentationStyle = .overFullScreen
                tabBarController.present(navVC, animated: true)
                return false
            }
            break;
        case 3:
            var vc: UIViewController!
            if #available(iOS 13.0, *) {
                vc = tabBarController.storyboard?.instantiateViewController(identifier: "RewardsViewController")
            } else {
                // Fallback on earlier versions
                vc = tabBarController.storyboard?.instantiateViewController(withIdentifier: "RewardsViewController")
            }
            if let newVC = vc {
                let navVC = prepareNavigationController(newVC)
                navVC.modalPresentationStyle = .overFullScreen
                tabBarController.present(navVC, animated: true)
                return false
            }
            break;
        case 4:
            var vc: UIViewController!
            if #available(iOS 13.0, *) {
                vc = tabBarController.storyboard?.instantiateViewController(identifier: "MenuViewController")
            } else {
                // Fallback on earlier versions
                vc = tabBarController.storyboard?.instantiateViewController(withIdentifier: "MenuViewController")
            }
            if let newVC = vc {
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
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: LatoFont.bold(with: 20)]
        navVC.navigationBar.barStyle = .black
        
        return navVC
    }
    
    func prepareTabBar() {
        let tabItems = self.tabBar.items
        tabItems?.forEach({ (item) in
            item.setTitleTextAttributes([NSAttributedString.Key.font: LatoFont.bold(with: 10)], for: .normal)
            item.setTitleTextAttributes([NSAttributedString.Key.font: LatoFont.bold(with: 10)], for: .selected)
        })
        
    }
}

