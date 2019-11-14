//
//  ReservationsViewController.swift
//  iPark
//
//  Created by King on 2019/11/13.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class ReservationsViewController: UIViewController {
    
    @IBOutlet weak var tabBar: TabBar!
    fileprivate var buttons = [TabItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation()
        prepareButtons()
        prepareTabBar()
    }
    
    @objc func onBackClick() {
        self.dismiss(animated: true)
    }
}

fileprivate extension ReservationsViewController {
    func prepareNavigation() {
        self.navigationItem.title = "My Reservations"
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func prepareButtons() {
        let btn1 = TabItem(title: "Upcoming", titleColor: Color.white)
        btn1.pulseAnimation = .centerRadialBeyondBounds
        btn1.setTabItemColor(UIColor.iYellow, for: .selected)
        btn1.setTabItemColor(UIColor.white, for: .normal)
        btn1.titleLabel?.font = LatoFont.bold(with: 15)
        buttons.append(btn1)
       
        let btn2 = TabItem(title: "Past", titleColor: Color.white)
        btn2.pulseAnimation = .centerRadialBeyondBounds
        btn2.setTabItemColor(UIColor.iYellow, for: .selected)
        btn2.setTabItemColor(UIColor.white, for: .normal)
        btn2.titleLabel?.font = LatoFont.bold(with: 15)
        buttons.append(btn2)
        
        let btn3 = TabItem(title: "Canceled", titleColor: Color.white)
        btn3.pulseAnimation = .centerRadialBeyondBounds
        btn3.setTabItemColor(UIColor.iYellow, for: .selected)
        btn3.setTabItemColor(UIColor.white, for: .normal)
        btn3.titleLabel?.font = LatoFont.bold(with: 15)
        buttons.append(btn3)
    }
    
    func prepareTabBar() {
        tabBar.delegate = self
        
        tabBar.backgroundColor = UIColor.iDarkBlue
        
        tabBar.dividerColor = UIColor.iBlack80
        tabBar.dividerAlignment = .top
        tabBar.dividerThickness = 0.3
        
        tabBar.lineColor = UIColor.iYellow
        tabBar.lineAlignment = .bottom
        tabBar.lineHeight = 4
        
        tabBar.tabItems = buttons
    }
}

extension ReservationsViewController: TabBarDelegate {
    @objc
    func tabBar(tabBar: TabBar, willSelect tabItem: TabItem) {
        print("will select")
    }
    
    @objc
    func tabBar(tabBar: TabBar, didSelect tabItem: TabItem) {
        print("did select")
    }
}
