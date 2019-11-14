//
//  SearchViewController.swift
//  iPark
//
//  Created by King on 2019/11/14.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tabBar: TabBar!
    fileprivate var buttons = [TabItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation()
        prepareButtons()
        prepareTabBar()
    }
    
    @objc fileprivate func onBackClick() {
        self.dismiss(animated: true)
    }
    
}

fileprivate extension SearchViewController {
    func prepareNavigation() {
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(onBackClick))
        leftButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func prepareButtons() {
        let btn1 = TabItem(title: "Daily", titleColor: Color.white)
        btn1.pulseAnimation = .centerRadialBeyondBounds
        btn1.setTabItemColor(UIColor.iYellow, for: .selected)
        btn1.setTabItemColor(UIColor.white, for: .normal)
        buttons.append(btn1)
       
        let btn2 = TabItem(title: "Monthly", titleColor: Color.white)
        btn2.pulseAnimation = .centerRadialBeyondBounds
        btn2.setTabItemColor(UIColor.iYellow, for: .selected)
        btn2.setTabItemColor(UIColor.white, for: .normal)
        buttons.append(btn2)
    }
    
    func prepareTabBar() {
        tabBar.delegate = self
        
        tabBar.dividerColor = UIColor.iBlack80
        tabBar.dividerAlignment = .top
        tabBar.dividerThickness = 0.3
        
        tabBar.lineColor = UIColor.iYellow
        tabBar.lineAlignment = .bottom
        tabBar.lineHeight = 4
        
        tabBar.tabItems = buttons
    }
}

extension SearchViewController: TabBarDelegate {
    @objc
    func tabBar(tabBar: TabBar, willSelect tabItem: TabItem) {
        print("will select")
    }
    
    @objc
    func tabBar(tabBar: TabBar, didSelect tabItem: TabItem) {
        print("did select")
    }
}
