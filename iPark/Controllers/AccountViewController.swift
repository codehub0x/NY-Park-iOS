//
//  AccountViewController.swift
//  iPark
//
//  Created by King on 2019/11/20.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class AccountViewController: UIViewController {
    
    static let storyboardId = "\(AccountViewController.self)"
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameField: TextField!
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var phoneField: TextField!
    @IBOutlet weak var passwordField: TextField!
    @IBOutlet weak var repeatField: TextField!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        prepareNavigation()
        prepareInfoView()
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
        
        if phoneField.isEmpty {
            phoneField.detail = "Phone number is required."
            valid = false
        } else if !phoneField.text!.isValidPhone() {
            phoneField.detail = "Phone number is invalid."
            valid = false
        }
        
        if passwordField.isEmpty {
            passwordField.detail = "Password is required."
            valid = false
        }
        
        if repeatField.isEmpty {
            repeatField.detail = "Repeat password is required."
            valid = false
        } else if repeatField.text! != passwordField.text! {
            repeatField.detail = "The specified password do not match."
            valid = false
        }
        
        if valid {
            // TODO: - save user information
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func onPaymentBtnClick(_ sender: Any) {
        
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

extension AccountViewController: TextFieldDelegate{
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
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let textField = textField as? TextField {
            textField.detail = ""
        }
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
            if phoneField.isEmpty {
                phoneField.detail = "Phone number is required."
            } else if !phoneField.text!.isValidPhone() {
                phoneField.detail = "Phone number is invalid."
            }
            break
        case 54:
            if passwordField.isEmpty {
                passwordField.detail = "Password is required."
            }
            break
        case 55:
            if repeatField.isEmpty {
                repeatField.detail = "Repeat password is required."
            } else if repeatField.text! != passwordField.text! {
                repeatField.detail = "The specified password do not match."
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
        nameField.placeholderLabel.font = LatoFont.regular(with: 15)
        nameField.placeholderActiveScale = 0.7
        nameField.placeholderNormalColor = .iBlack50
        nameField.placeholderActiveColor = .iDarkBlue
        
        nameField.font = LatoFont.regular(with: 15)
        nameField.textColor = .black
        nameField.detailColor = .red
        
        nameField.dividerNormalHeight = 1
        nameField.dividerActiveHeight = 2
        nameField.dividerNormalColor = .iBlack50
        nameField.dividerActiveColor = .iDarkBlue
    }
    
    func prepareEmailTextField() {
        emailField.placeholderLabel.font = LatoFont.regular(with: 15)
        emailField.placeholderActiveScale = 0.7
        emailField.placeholderNormalColor = .iBlack50
        emailField.placeholderActiveColor = .iDarkBlue
        
        emailField.font = LatoFont.regular(with: 15)
        emailField.textColor = .black
        emailField.detailColor = .red
        
        emailField.dividerNormalHeight = 1
        emailField.dividerActiveHeight = 2
        emailField.dividerNormalColor = .iBlack50
        emailField.dividerActiveColor = .iDarkBlue
    }
    
    func preparePhoneTextField() {
        phoneField.placeholderLabel.font = LatoFont.regular(with: 15)
        phoneField.placeholderActiveScale = 0.7
        phoneField.placeholderNormalColor = .iBlack50
        phoneField.placeholderActiveColor = .iDarkBlue
        
        phoneField.font = LatoFont.regular(with: 15)
        phoneField.textColor = .black
        phoneField.detailColor = .red
        
        phoneField.dividerNormalHeight = 1
        phoneField.dividerActiveHeight = 2
        phoneField.dividerNormalColor = .iBlack50
        phoneField.dividerActiveColor = .iDarkBlue
    }
    
    func preparePasswordTextField() {
        passwordField.placeholderLabel.font = LatoFont.regular(with: 15)
        passwordField.placeholderActiveScale = 0.7
        passwordField.placeholderNormalColor = .iBlack50
        passwordField.placeholderActiveColor = .iDarkBlue
        
        passwordField.font = LatoFont.regular(with: 15)
        passwordField.textColor = .black
        passwordField.detailColor = .red
        passwordField.isVisibilityIconButtonEnabled = true
        
        passwordField.dividerNormalHeight = 1
        passwordField.dividerActiveHeight = 2
        passwordField.dividerNormalColor = .iBlack50
        passwordField.dividerActiveColor = .iDarkBlue
    }
    
    func prepareRepeatTextField() {
        repeatField.placeholderLabel.font = LatoFont.regular(with: 15)
        repeatField.placeholderActiveScale = 0.7
        repeatField.placeholderNormalColor = .iBlack50
        repeatField.placeholderActiveColor = .iDarkBlue
        
        repeatField.font = LatoFont.regular(with: 15)
        repeatField.textColor = .black
        repeatField.detailColor = .red
        repeatField.isVisibilityIconButtonEnabled = true
        
        repeatField.dividerNormalHeight = 1
        repeatField.dividerActiveHeight = 2
        repeatField.dividerNormalColor = .iBlack50
        repeatField.dividerActiveColor = .iDarkBlue
    }
}

