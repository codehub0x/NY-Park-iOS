//
//  SigninViewController.swift
//  iPark
//
//  Created by King on 2019/11/18.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialButtons

class SigninViewController: UIViewController {
    
    static let storyboardId = "\(SigninViewController.self)"
    
    @IBOutlet weak var emailField: MDCTextField!
    @IBOutlet weak var passwordField: MDCTextField!
    @IBOutlet weak var btnSignin: MDCButton!
    @IBOutlet weak var btnRegister: MDCButton!
    @IBOutlet weak var btnForgotPassword: MDCButton!
    @IBOutlet weak var btnClose: MDCButton!
    
    var emailFieldController: MDCTextInputControllerOutlined!
    var passwordFieldController: MDCTextInputControllerOutlined!
    
    fileprivate var mainStoryboard: UIStoryboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        prepareEmailFieldController()
        preparePasswordFieldController()
        prepareButtons()
    }
    
    @IBAction func onCloseBtnClick(_ sender: Any) {
        self.view.endEditing(true)
        self.dismiss(animated: true)
    }
    
    @IBAction func onSigninBtnClick(_ sender: Any) {
        self.view.endEditing(true)
        var valid = true
        
        let email = emailField.text?.trimmed ?? ""
        let password = passwordField.text ?? ""
        
        if email.isEmpty {
            emailFieldController.setErrorText("Email is required.", errorAccessibilityValue: "Email is required.")
            let _ = emailField.becomeFirstResponder()
            valid = false
        } else if !email.isValidEmail() {
            emailFieldController.setErrorText("Email is invalid.", errorAccessibilityValue: "Email is invalid.")
            let _ = emailField.becomeFirstResponder()
            valid = false
        }
        
        if password.isEmpty {
            passwordFieldController.setErrorText("Password is required.", errorAccessibilityValue: "Password is required.")
            if valid {
                let _ = passwordField.becomeFirstResponder()
            }
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

extension SigninViewController: UITextFieldDelegate {
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
        if textField.tag == 51 {
            emailFieldController.setErrorText(nil, errorAccessibilityValue: nil)
        } else if textField.tag == 52 {
            passwordFieldController.setErrorText(nil, errorAccessibilityValue: nil)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 51:
            let email = emailField.text?.trimmed ?? ""
            if email.isEmpty {
                emailFieldController.setErrorText("Email is required.", errorAccessibilityValue: "Email is required.")
            } else if !email.isValidEmail() {
                emailFieldController.setErrorText("Email is invalid.", errorAccessibilityValue: "Email is invalid.")
            }
            break
        case 52:
            if passwordField.text!.isEmpty {
                passwordFieldController.setErrorText("Password is required.", errorAccessibilityValue: "Password is required.")
            }
            break
        default:
            break
        }
    }
}

fileprivate extension SigninViewController {
    func prepareEmailFieldController() {
        emailField.font = LatoFont.regular(with: 17)
        emailField.textColor = .iBlack95
        
        emailFieldController = MDCTextInputControllerOutlined(textInput: emailField)
        emailFieldController.placeholderText = "Email"
        emailFieldController.inlinePlaceholderFont = LatoFont.regular(with: 17)
        emailFieldController.inlinePlaceholderColor = .iBlack70
        emailFieldController.floatingPlaceholderNormalColor = .iBlack70
        emailFieldController.floatingPlaceholderActiveColor = .iDarkBlue
        emailFieldController.floatingPlaceholderErrorActiveColor = .red
        emailFieldController.errorColor = .red
        emailFieldController.activeColor = .iDarkBlue
        emailFieldController.normalColor = .iBlack70
    }
    
    func preparePasswordFieldController() {
        passwordField.font = LatoFont.regular(with: 17)
        passwordField.textColor = .iBlack95
        
        passwordFieldController = MDCTextInputControllerOutlined(textInput: passwordField)
        passwordFieldController.placeholderText = "Password"
        passwordFieldController.inlinePlaceholderFont = LatoFont.regular(with: 17)
        passwordFieldController.inlinePlaceholderColor = .iBlack70
        passwordFieldController.floatingPlaceholderNormalColor = .iBlack70
        passwordFieldController.floatingPlaceholderActiveColor = .iDarkBlue
        passwordFieldController.floatingPlaceholderErrorActiveColor = .red
        passwordFieldController.errorColor = .red
        passwordFieldController.normalColor = .iBlack70
        passwordFieldController.activeColor = .iDarkBlue
    }
    
    func prepareButtons() {
        btnSignin.applyContainedTheme(withScheme: Global.secondaryButtonScheme())
        btnSignin.isUppercaseTitle = false
        btnRegister.applyContainedTheme(withScheme: Global.mediumButtonScheme())
        btnRegister.isUppercaseTitle = false
        let textScheme = Global.textButtonScheme()
        btnClose.applyTextTheme(withScheme: textScheme)
        btnClose.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        textScheme.typographyScheme.button = LatoFont.regular(with: 11)
        btnForgotPassword.applyTextTheme(withScheme: textScheme)
        btnForgotPassword.isUppercaseTitle = false
    }
}
