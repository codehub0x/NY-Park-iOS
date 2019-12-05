//
//  AccountViewController.swift
//  iPark
//
//  Created by King on 2019/11/20.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialButtons

class AccountViewController: UIViewController {
    
    static let storyboardId = "\(AccountViewController.self)"
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameField: MDCTextField!
    @IBOutlet weak var emailField: MDCTextField!
    @IBOutlet weak var phoneField: MDCTextField!
    @IBOutlet weak var passwordField: MDCTextField!
    @IBOutlet weak var repeatField: MDCTextField!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var btnSave: MDCButton!
    @IBOutlet weak var btnPaymentMethod: MDCButton!
    
    var nameFieldController: CustomTextInputControllerOutlined!
    var emailFieldController: CustomTextInputControllerOutlined!
    var phoneFieldController: CustomTextInputControllerOutlined!
    var passwordFieldController: CustomTextInputControllerOutlined!
    var repeatFieldController: CustomTextInputControllerOutlined!
    
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        prepareNavigation()
        prepareInfoView()
        prepareButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func onBackClick() {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSaveBtnClick(_ sender: Any) {
        self.view.endEditing(true)
        var valid = true
        
        let fullName = nameField.text?.trimmed ?? ""
        let email = emailField.text?.trimmed ?? ""
        let phone = phoneField.text?.trimmed ?? ""
        let password = passwordField.text ?? ""
        let repeatPassword = repeatField.text ?? ""
        
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
        
        if phone.isEmpty {
            phoneFieldController.setErrorText("Phone number is required.", errorAccessibilityValue: "Phone number is required.")
            if valid {
                let _ = phoneField.becomeFirstResponder()
            }
            valid = false
        } else if !phoneField.text!.isValidPhone() {
            phoneFieldController.setErrorText("Phone number is invalid.", errorAccessibilityValue: "Phone number is invalid.")
            if valid {
                let _ = phoneField.becomeFirstResponder()
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
        
        if repeatPassword.isEmpty {
            repeatFieldController.setErrorText("Repeat password is required.", errorAccessibilityValue: "Repeat password is required.")
            if valid {
                let _ = repeatField.becomeFirstResponder()
            }
            valid = false
        } else if repeatPassword != password {
            repeatFieldController.setErrorText("The specified password do not match.", errorAccessibilityValue: "The specified password do not match.")
            if valid {
                let _ = repeatField.becomeFirstResponder()
            }
            valid = false
        }
        
        if valid {
            // TODO: - save user information
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func onPaymentBtnClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: BillingViewController.storyboardId)
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onValueChanged(_ sender: Any) {
        
    }
    
    @objc func onAvatarClick(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
        self.imagePicker.present(from: avatarImageView)
    }
}

extension AccountViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if let img = image {
            self.avatarImageView.image = img
        }
    }
}

extension AccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 51:
            let _ = emailField.becomeFirstResponder()
            break
        case 52:
            let _ = phoneField.becomeFirstResponder()
            break
        case 53:
            let _ = passwordField.becomeFirstResponder()
            break
        case 54:
            let _ = repeatField.becomeFirstResponder()
            break
        default:
            textField.resignFirstResponder()
            break
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 51 {
            nameFieldController.setErrorText(nil, errorAccessibilityValue: nil)
        } else if textField.tag == 52 {
            emailFieldController.setErrorText(nil, errorAccessibilityValue: nil)
        } else if textField.tag == 54 {
            passwordFieldController.setErrorText(nil, errorAccessibilityValue: nil)
        } else if textField.tag == 55 {
            repeatFieldController.setErrorText(nil, errorAccessibilityValue: nil)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 53 {
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = newString.formattedNumber()
            return false
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
            if phoneField.text!.isEmpty {
                phoneFieldController.setErrorText("Phone number is required.", errorAccessibilityValue: "Phone number is required.")
            } else if !phoneField.text!.isValidPhone() {
                phoneFieldController.setErrorText("Phone number is invalid.", errorAccessibilityValue: "Phone number is invalid.")
            }
            break
        case 54:
            if passwordField.text!.isEmpty {
                passwordFieldController.setErrorText("Password is required.", errorAccessibilityValue: "Password is required.")
            }
            break
        case 55:
            if repeatField.text!.isEmpty {
                repeatFieldController.setErrorText("Repeat password is required.", errorAccessibilityValue: "Repeat password is required.")
            } else if repeatField.text! != passwordField.text! {
                repeatFieldController.setErrorText("The specified password do not match.", errorAccessibilityValue: "The specified password do not match.")
            }
            break
        default:
            break
        }
    }
}

fileprivate extension AccountViewController {
    func prepareNavigation() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "Account"
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func prepareInfoView() {
        infoView.layer.cornerRadius = 8
        infoView.layer.borderColor = UIColor.iBlack70.cgColor
        infoView.layer.borderWidth = 0.5
        infoView.layer.masksToBounds = true
        
        prepareAvatar()
        prepareNameTextField()
        prepareEmailTextField()
        preparePhoneTextField()
        preparePasswordTextField()
        prepareRepeatTextField()
    }
    
    func prepareAvatar() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onAvatarClick(_:)))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGesture)
    }
    
    func prepareNameTextField() {
        nameField.font = LatoFont.regular(with: 17)
        nameField.textColor = .iBlack95
        
        nameFieldController = CustomTextInputControllerOutlined(textInput: nameField)
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
    
    func prepareEmailTextField() {
        emailField.font = LatoFont.regular(with: 17)
        emailField.textColor = .iBlack95
        
        emailFieldController = CustomTextInputControllerOutlined(textInput: emailField)
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
    
    func preparePhoneTextField() {
        phoneField.font = LatoFont.regular(with: 17)
        phoneField.textColor = .iBlack95
        
        phoneFieldController = CustomTextInputControllerOutlined(textInput: phoneField)
        phoneFieldController.placeholderText = "Phone Number"
        phoneFieldController.inlinePlaceholderFont = LatoFont.regular(with: 17)
        phoneFieldController.inlinePlaceholderColor = .iBlack70
        phoneFieldController.floatingPlaceholderNormalColor = .iBlack70
        phoneFieldController.floatingPlaceholderActiveColor = .iDarkBlue
        phoneFieldController.floatingPlaceholderErrorActiveColor = .red
        phoneFieldController.errorColor = .red
        phoneFieldController.normalColor = .iBlack70
        phoneFieldController.activeColor = .iDarkBlue
    }
    
    func preparePasswordTextField() {
        passwordField.font = LatoFont.regular(with: 17)
        passwordField.textColor = .iBlack95
        
        passwordFieldController = CustomTextInputControllerOutlined(textInput: passwordField)
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
    
    func prepareRepeatTextField() {
        repeatField.font = LatoFont.regular(with: 17)
        repeatField.textColor = .iBlack95
        
        repeatFieldController = CustomTextInputControllerOutlined(textInput: repeatField)
        repeatFieldController.placeholderText = "Repeat Password"
        repeatFieldController.inlinePlaceholderFont = LatoFont.regular(with: 17)
        repeatFieldController.inlinePlaceholderColor = .iBlack70
        repeatFieldController.floatingPlaceholderNormalColor = .iBlack70
        repeatFieldController.floatingPlaceholderActiveColor = .iDarkBlue
        repeatFieldController.floatingPlaceholderErrorActiveColor = .red
        repeatFieldController.errorColor = .red
        repeatFieldController.normalColor = .iBlack70
        repeatFieldController.activeColor = .iDarkBlue
    }
    
    func prepareButtons() {
        btnSave.applyContainedTheme(withScheme: Global.defaultButtonScheme())
        btnPaymentMethod.applyTextTheme(withScheme: Global.textButtonScheme())
    }
}

