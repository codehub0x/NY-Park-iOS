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
    
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var passwordField: TextField!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    fileprivate var mainStoryboard: UIStoryboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        adjustUIHeight()
        
        prepareEmailField()
        preparePasswordField()
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
        self.view.endEditing(true)
        self.dismiss(animated: true)
    }
    
    @IBAction func onSigninBtnClick(_ sender: Any) {
        self.view.endEditing(true)
        var valid = true
        
        if emailField.isEmpty {
            emailField.detail = "Email is required."
            valid = false
        } else if !emailField.text!.isValidEmail() {
            emailField.detail = "Email is invalid."
            valid = false
        }
        
        if passwordField.isEmpty {
            passwordField.detail = "Password is required."
            valid = false
        }
        
        if valid {
            let newVC = mainStoryboard.instantiateViewController(withIdentifier: MenuViewController.storyboardId) as! MenuViewController
            Global.isLoggedIn = true
            let navVC = newVC.getNavigationController()
            navVC.modalPresentationStyle = .overFullScreen
            navVC.modalTransitionStyle = .crossDissolve
            
            self.present(navVC, animated: true)
        }
    }
    
    @IBAction func onForgotPasswordBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onRegisterBtnClick(_ sender: Any) {
        self.view.endEditing(true)
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: SignupViewController.storyboardId)
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .flipHorizontal
        weak var pvc = self.presentingViewController
        self.dismiss(animated: true) {
            pvc?.present(newVC, animated: true)
        }
    }
    
}

extension SigninViewController: TextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 51:
            let _ = passwordField.becomeFirstResponder()
            break
        default:
            textField.resignFirstResponder()
            break
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let textField = textField as? TextField {
            textField.detail = ""
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 51:
            if emailField.isEmpty {
                emailField.detail = "Email is required."
            } else if !emailField.text!.isValidEmail() {
                emailField.detail = "Email is invalid."
            }
            break
        case 52:
            if passwordField.isEmpty {
                passwordField.detail = "Password is required."
            }
            break
        default:
            break
        }
    }
}

fileprivate extension SigninViewController {
    func prepareEmailField() {
        emailField.placeholderLabel.font = LatoFont.regular(with: 17)
        emailField.placeholderNormalColor = .iBlack50
        emailField.placeholderActiveColor = .iDarkBlue
        
        emailField.font = LatoFont.regular(with: 17)
        emailField.textColor = .black
        emailField.detailColor = .red
        
        emailField.dividerNormalHeight = 1
        emailField.dividerActiveHeight = 2
        emailField.dividerNormalColor = .iBlack50
        emailField.dividerActiveColor = .iDarkBlue
    }
    
    func preparePasswordField() {
        passwordField.placeholderLabel.font = LatoFont.regular(with: 17)
        passwordField.placeholderNormalColor = .iBlack50
        passwordField.placeholderActiveColor = .iDarkBlue
        
        passwordField.font = LatoFont.regular(with: 17)
        passwordField.textColor = .black
        passwordField.detailColor = .red
        passwordField.isVisibilityIconButtonEnabled = true
        
        passwordField.dividerNormalHeight = 1
        passwordField.dividerActiveHeight = 2
        passwordField.dividerNormalColor = .iBlack50
        passwordField.dividerActiveColor = .iDarkBlue
    }
}
