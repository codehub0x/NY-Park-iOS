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
                vc = tabBarController.storyboard?.instantiateViewController(identifier: ReservationsViewController.storyboardId)
            } else {
                // Fallback on earlier versions
                vc = tabBarController.storyboard?.instantiateViewController(withIdentifier: ReservationsViewController.storyboardId)
            }
            if let newVC = vc {
                let navVC = newVC.getNavigationController()
                navVC.modalPresentationStyle = .overFullScreen
                tabBarController.present(navVC, animated: true)
                return false
            }
            break;
        case 3:
            var vc: UIViewController!
            if #available(iOS 13.0, *) {
                vc = tabBarController.storyboard?.instantiateViewController(identifier: RewardsViewController.storyboardId)
            } else {
                // Fallback on earlier versions
                vc = tabBarController.storyboard?.instantiateViewController(withIdentifier: RewardsViewController.storyboardId)
            }
            if let newVC = vc {
                let navVC = newVC.getNavigationController()
                navVC.modalPresentationStyle = .overFullScreen
                tabBarController.present(navVC, animated: true)
                return false
            }
            break;
        case 4:
            var vc: UIViewController!
            if #available(iOS 13.0, *) {
                vc = tabBarController.storyboard?.instantiateViewController(identifier: MenuViewController.storyboardId)
            } else {
                // Fallback on earlier versions
                vc = tabBarController.storyboard?.instantiateViewController(withIdentifier: MenuViewController.storyboardId)
            }
            if let newVC = vc {
                let navVC = newVC.getNavigationController()
                navVC.modalPresentationStyle = .overFullScreen
                navVC.modalTransitionStyle = .crossDissolve
                tabBarController.present(navVC, animated: true)
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
    func prepareTabBar() {
        let tabItems = self.tabBar.items
        tabItems?.forEach({ (item) in
            item.setTitleTextAttributes([NSAttributedString.Key.font: LatoFont.bold(with: 10)], for: .normal)
            item.setTitleTextAttributes([NSAttributedString.Key.font: LatoFont.bold(with: 10)], for: .selected)
        })
        
    }
}

