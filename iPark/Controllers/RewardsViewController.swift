//
//  RewardsViewController.swift
//  iPark
//
//  Created by King on 2019/11/13.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

class RewardsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation()
    }
    
    @objc func onBackClick() {
        self.dismiss(animated: true)
    }
}

fileprivate extension RewardsViewController {
    func prepareNavigation() {
        self.navigationItem.title = "Reward Points"
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
    }
}
