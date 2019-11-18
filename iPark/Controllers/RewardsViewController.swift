//
//  RewardsViewController.swift
//  iPark
//
//  Created by King on 2019/11/13.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class RewardsViewController: UIViewController {
    
    @IBOutlet weak var btnCreateAccount: FlatButton!
    @IBOutlet weak var btnLogin: FlatButton!
    @IBOutlet weak var earnView: UIView!
    @IBOutlet weak var parkView: UIView!
    @IBOutlet weak var saveTimeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation()
        prepareCreateAccountButton()
        prepareLoginButton()
        prepareEarnView()
        prepareParkView()
        prepareSaveTimeView()
    }
    
    @objc func onBackClick() {
        self.dismiss(animated: true)
    }
}

fileprivate extension RewardsViewController {
    func prepareNavigation() {
        self.navigationItem.title = "Reward Points"
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left"), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationController?.navigationBar.tintColor = UIColor.white
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
    
    func prepareEarnView() {
        earnView.layer.cornerRadius = 8
        earnView.layer.shadowColor = UIColor.black.cgColor
        earnView.layer.shadowOpacity = 0.6
        earnView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        earnView.layer.shadowRadius = 1
    }
    
    func prepareParkView() {
        parkView.layer.cornerRadius = 8
        parkView.layer.shadowColor = UIColor.black.cgColor
        parkView.layer.shadowOpacity = 0.6
        parkView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        parkView.layer.shadowRadius = 1
    }
    
    func prepareSaveTimeView() {
        saveTimeView.layer.cornerRadius = 8
        saveTimeView.layer.shadowColor = UIColor.black.cgColor
        saveTimeView.layer.shadowOpacity = 0.6
        saveTimeView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        saveTimeView.layer.shadowRadius = 1
    }
    
}
