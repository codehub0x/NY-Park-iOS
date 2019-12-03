//
//  SignupViewController.swift
//  iPark
//
//  Created by King on 2019/11/18.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material
import MaterialComponents.MaterialTextFields

class SignupViewController: UIViewController {
    
    static let storyboardId = "\(SignupViewController.self)"
    
    @IBOutlet weak var nameField: MDCTextField!
    @IBOutlet weak var emailField: MDCTextField!
    @IBOutlet weak var passwordField: MDCTextField!
    @IBOutlet weak var termsBtn: FlatButton!
    
    var nameFieldController: MDCTextInputControllerOutlined!
    var emailFieldController: MDCTextInputControllerOutlined!
    var passwordFieldController: MDCTextInputControllerOutlined!
    
    fileprivate var mainStoryboard: UIStoryboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        prepareTermsButton()
        prepareNameField()
        prepareEmailField()
        preparePasswordField()
    }
    
    @IBAction func onCloseBtnClick(_ sender: Any) {
        self.view.endEditing(true)
        self.dismiss(animated: true)
    }
    
    @IBAction func onCreateAccountBtnClick(_ sender: Any) {
        self.view.endEditing(true)
        var valid = true
        
        let fullName = nameField.text?.trimmed ?? ""
        let email = emailField.text?.trimmed ?? ""
        let password = passwordField.text ?? ""
        if fullName.isEmpty {
            nameFieldController.setErrorText("Full Name is required.", errorAccessibilityValue: "Full Name is required.")
            let _ = nameField.becomeFirstResponder()
            valid = false
        }
        
        if email.isEmpty {
            emailFieldController.setErrorText("Email is required.", errorAccessibilityValue: "Email is required.")
            if valid {
                let _ = emailField.becomeFirstResponder()
            }
            valid = false
        } else if !emailField.text!.isValidEmail() {
            emailFieldController.setErrorText("Email is invalid.", errorAccessibilityValue: "Email is invalid.")
            if valid {
                let _ = emailField.becomeFirstResponder()
            }
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
    
    @IBAction func onTermsBtnClick(_ sender: Any) {
        self.view.endEditing(true)
        guard let url = URL(string: "https://ipark.com/terms-and-conditions/"),
            UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func onSigninBtnClick(_ sender: Any) {
        self.view.endEditing(true)
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: SigninViewController.storyboardId)
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .flipHorizontal
        weak var pvc = self.presentingViewController
        self.dismiss(animated: true) {
            pvc?.present(newVC, animated: true)
        }
    }
    
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 51:
            let _ = emailField.becomeFirstResponder()
            break
        case 52:
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
            nameFieldController.setErrorText(nil, errorAccessibilityValue: nil)
        } else if textField.tag == 52 {
            emailFieldController.setErrorText(nil, errorAccessibilityValue: nil)
        } else if textField.tag == 53 {
            passwordFieldController.setErrorText(nil, errorAccessibilityValue: nil)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 51:
            if nameField.text!.isEmpty {
                nameFieldController.setErrorText("Full Name is required.", errorAccessibilityValue: "Full Name is required.")
            }
            break
        case 52:
            let email = emailField.text?.trimmed ?? ""
            if email.isEmpty {
                emailFieldController.setErrorText("Email is required.", errorAccessibilityValue: "Email is required.")
            } else if !email.isValidEmail() {
                emailFieldController.setErrorText("Email is invalid.", errorAccessibilityValue: "Email is invalid.")
            }
            break
        case 53:
            if passwordField.text!.isEmpty {
                passwordFieldController.setErrorText("Password is required.", errorAccessibilityValue: "Password is required.")
            }
            break
        default:
            break
        }
    }
}

fileprivate extension SignupViewController {
    func prepareTermsButton() {
        let attrs = [
            NSAttributedString.Key.font: LatoFont.regular(with: 11),
            NSAttributedString.Key.foregroundColor: UIColor.iBlack50,
            NSAttributedString.Key.underlineStyle: 1
            ] as [NSAttributedString.Key : Any]
        
        let btnTitleStr = NSMutableAttributedString(string: "Terms", attributes: attrs)
        termsBtn.setAttributedTitle(btnTitleStr, for: .normal)
    }
    
    func prepareNameField() {
        nameField.font = LatoFont.regular(with: 17)
        nameField.textColor = .iBlack95
        
        nameFieldController = MDCTextInputControllerOutlined(textInput: nameField)
        nameFieldController.placeholderText = "Full Name"
        nameFieldController.inlinePlaceholderFont = LatoFont.regular(with: 17)
        nameFieldController.inlinePlaceholderColor = .iBlack70
        nameFieldController.floatingPlaceholderNormalColor = .iBlack70
        nameFieldController.floatingPlaceholderActiveColor = .iDarkBlue
        nameFieldController.floatingPlaceholderErrorActiveColor = .red
        nameFieldController.errorColor = .red
        nameFieldController.normalColor = .iBlack70
        nameFieldController.activeColor = .iDarkBlue
    }
    
    func prepareEmailField() {
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
    
    func preparePasswordField() {
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
}
