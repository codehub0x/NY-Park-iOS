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
    
    static let storyboardId = "\(RewardsViewController.self)"
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
        if Global.isLoggedIn {
            topViewHeight.constant = 0
            topView.isHidden = true
        } else {
            topViewHeight.constant = 56
            topView.isHidden = false
        }
    }
    
    @objc func onBackClick() {
        if let count = self.navigationController?.viewControllers.count, count > 1 {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
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
        earnView.layer.borderWidth = 0.5
        earnView.layer.borderColor = UIColor.iBlack70.cgColor
        earnView.layer.masksToBounds = true
//        earnView.layer.shadowColor = UIColor.black.cgColor
//        earnView.layer.shadowOpacity = 0.6
//        earnView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
//        earnView.layer.shadowRadius = 1
    }
    
    func prepareParkView() {
        parkView.layer.cornerRadius = 8
        parkView.layer.borderWidth = 0.5
        parkView.layer.borderColor = UIColor.iBlack70.cgColor
        parkView.layer.masksToBounds = true
//        parkView.layer.shadowColor = UIColor.black.cgColor
//        parkView.layer.shadowOpacity = 0.6
//        parkView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
//        parkView.layer.shadowRadius = 1
    }
    
    func prepareSaveTimeView() {
        saveTimeView.layer.cornerRadius = 8
        saveTimeView.layer.borderWidth = 0.5
        saveTimeView.layer.borderColor = UIColor.iBlack70.cgColor
        saveTimeView.layer.masksToBounds = true
//        saveTimeView.layer.shadowColor = UIColor.black.cgColor
//        saveTimeView.layer.shadowOpacity = 0.6
//        saveTimeView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
//        saveTimeView.layer.shadowRadius = 1
    }
    
}
