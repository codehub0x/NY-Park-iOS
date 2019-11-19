//
//  SigninViewController.swift
//  iPark
//
//  Created by King on 2019/11/18.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class SigninViewController: UIViewController {
    
    static let storyboardId = "\(SigninViewController.self)"
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var closeBtn: FlatButton!
    
    fileprivate var mainStoryboard: UIStoryboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        prepareCloseButton()
    }
    
    @IBAction func onCloseBtnClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onSigninBtnClick(_ sender: Any) {
        let newVC: MenuViewController!
        if #available(iOS 13.0, *) {
            newVC = mainStoryboard.instantiateViewController(identifier: MenuViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            newVC = mainStoryboard.instantiateViewController(withIdentifier: MenuViewController.storyboardId) as? MenuViewController
        }
        
        Global.isLoggedIn = true
        
        let navVC = newVC.getNavigationController()
        navVC.modalPresentationStyle = .overFullScreen
        navVC.modalTransitionStyle = .crossDissolve
        
        self.present(navVC, animated: true)
    }
    
    @IBAction func onForgotPasswordBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onRegisterBtnClick(_ sender: Any) {
        let newVC: UIViewController!
        if #available(iOS 13.0, *) {
            newVC = mainStoryboard.instantiateViewController(identifier: SignupViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            newVC = mainStoryboard.instantiateViewController(withIdentifier: SignupViewController.storyboardId)
        }
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .flipHorizontal
        weak var pvc = self.presentingViewController
        self.dismiss(animated: true) {
            pvc?.present(newVC, animated: true)
        }
    }
    
}


fileprivate extension SigninViewController {
    func prepareCloseButton() {
        closeBtn.setImage(UIImage(named: "icon-close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeBtn.tintColor = UIColor.iBlack90
    }
}
