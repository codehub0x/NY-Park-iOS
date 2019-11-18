//
//  RewardsViewController.swift
//  iPark
//
//  Created by King on 2019/11/13.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

class RewardsViewController: UIViewController {
    
    @IBOutlet weak var btnCreateAccount: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation()
        prepareCreateAccountButton()
        prepareLoginButton()
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
    
    func prepareCreateAccountButton() {
        btnCreateAccount.layer.cornerRadius = 4
        btnCreateAccount.layer.borderColor = UIColor.iYellow.cgColor
        btnCreateAccount.layer.borderWidth = 1
        btnCreateAccount.layer.masksToBounds = true
    }
    
    func prepareLoginButton() {
        btnLogin.layer.cornerRadius = 4
        btnLogin.layer.borderColor = UIColor.iYellow.cgColor
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.masksToBounds = true
    }
}
