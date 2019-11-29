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
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    fileprivate var mainStoryboard: UIStoryboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        adjustUIHeight()
    }
    
    func adjustUIHeight() {
        let windowSize = UIScreen.main.bounds
        var topPadding: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            topPadding = window?.safeAreaInsets.top ?? 0
        }
        var height = windowSize.height - topPadding
        if height < 600 {
            height = 600
        }
        heightConstraint.constant = height
    }
    
    @IBAction func onCloseBtnClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onSigninBtnClick(_ sender: Any) {
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: MenuViewController.storyboardId) as! MenuViewController
        
        Global.isLoggedIn = true
        
        let navVC = newVC.getNavigationController()
        navVC.modalPresentationStyle = .overFullScreen
        navVC.modalTransitionStyle = .crossDissolve
        
        self.present(navVC, animated: true)
    }
    
    @IBAction func onForgotPasswordBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onRegisterBtnClick(_ sender: Any) {
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: SignupViewController.storyboardId)
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .flipHorizontal
        weak var pvc = self.presentingViewController
        self.dismiss(animated: true) {
            pvc?.present(newVC, animated: true)
        }
    }
    
}
