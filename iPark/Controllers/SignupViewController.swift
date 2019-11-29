//
//  SignupViewController.swift
//  iPark
//
//  Created by King on 2019/11/18.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class SignupViewController: UIViewController {
    
    static let storyboardId = "\(SignupViewController.self)"
    
    @IBOutlet weak var nameField: TextField!
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var passwordField: TextField!
    @IBOutlet weak var termsBtn: FlatButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    fileprivate var mainStoryboard: UIStoryboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        adjustUIHeight()
        
        prepareTermsButton()
        prepareNameField()
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
        if height < 650 {
            height = 650
        }
        heightConstraint.constant = height
    }
    
    @IBAction func onCloseBtnClick(_ sender: Any) {
        self.view.endEditing(true)
        self.dismiss(animated: true)
    }
    
    @IBAction func onCreateAccountBtnClick(_ sender: Any) {
        self.view.endEditing(true)
        var valid = true
        
        if nameField.isEmpty {
            nameField.detail = "Full name is required."
            valid = false
        }
        
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

extension SignupViewController: TextFieldDelegate {
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
        if let textField = textField as? TextField {
            textField.detail = ""
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 51:
            if nameField.isEmpty {
                nameField.detail = "Full name is required."
            }
            break
        case 52:
            if emailField.isEmpty {
                emailField.detail = "Email is required."
            } else if !emailField.text!.isValidEmail() {
                emailField.detail = "Email is invalid."
            }
            break
        case 53:
            if passwordField.isEmpty {
                passwordField.detail = "Password is required."
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
        nameField.placeholderLabel.font = LatoFont.regular(with: 17)
        nameField.placeholderNormalColor = .iBlack50
        nameField.placeholderActiveColor = .iDarkBlue
        
        nameField.font = LatoFont.regular(with: 17)
        nameField.textColor = .black
        nameField.detailColor = .red
        
        nameField.dividerNormalHeight = 1
        nameField.dividerActiveHeight = 2
        nameField.dividerNormalColor = .iBlack50
        nameField.dividerActiveColor = .iDarkBlue
    }
    
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
