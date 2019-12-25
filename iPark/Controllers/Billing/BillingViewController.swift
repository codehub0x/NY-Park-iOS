//
//  BillingViewController.swift
//  iPark
//
//  Created by King on 2019/12/2.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import UIKit
import CountryPickerView
import PhoneNumberKit
import MaterialComponents.MaterialButtons

class BillingViewController: UIViewController {
    
    static let storyboardId = "\(BillingViewController.self)"
    
    @IBOutlet weak var cardInfoView: UIView!
    @IBOutlet weak var fullNameTextField: ErrorTextField!
    @IBOutlet weak var cardNumberTextField: ErrorTextField!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var expDateTextField: ErrorTextField!
    @IBOutlet weak var cvvTextField: ErrorTextField!
    @IBOutlet weak var billingInfoView: ErrorTextField!
    @IBOutlet weak var cityTextField: ErrorTextField!
    @IBOutlet weak var stateTextField: ErrorTextField!
    @IBOutlet weak var zipCodeTextField: ErrorTextField!
    @IBOutlet weak var countryTextField: ErrorTextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTextField: PhoneNumberTextField!
    @IBOutlet weak var btnSave: MDCButton!
    
    let cpvInternal = CountryPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CardIOUtilities.preload()
        
        prepareNavigation()
        prepareCardViews()
        prepareCPVInternal()
        prepareTextFields()
        preparePhoneTextField()
        prepareButton()
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        var valid = true
        let fullName = fullNameTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        if fullName.isEmpty {
            fullNameTextField.rightView?.isHidden = false
            fullNameTextField.becomeFirstResponder()
            valid = false
        } else {
            fullNameTextField.rightView?.isHidden = true
        }
        
        let cardNumber = cardNumberTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        if cardNumber.isValidCardNumber() {
            cardNumberTextField.rightView?.isHidden = true
        } else {
            cardNumberTextField.rightView?.isHidden = false
            if valid {
                cardNumberTextField.becomeFirstResponder()
            }
            valid = false
        }
        
        let expDate = expDateTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        if expDate.isValidExpDate() {
            expDateTextField.rightView?.isHidden = true
        } else {
            expDateTextField.rightView?.isHidden = false
            if valid {
                expDateTextField.becomeFirstResponder()
            }
            valid = false
        }
        
        let cvv = cvvTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        if cvv.isValidCVV() {
            cvvTextField.rightView?.isHidden = true
        } else {
            cvvTextField.rightView?.isHidden = false
            if valid {
                cvvTextField.becomeFirstResponder()
            }
            valid = false
        }
        
        let city = cityTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        if city.isEmpty {
            cityTextField.rightView?.isHidden = false
            if valid {
                cityTextField.becomeFirstResponder()
            }
            valid = false
        } else {
            cityTextField.rightView?.isHidden = true
        }
        
        let state = stateTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        if state.isEmpty {
            stateTextField.rightView?.isHidden = false
            if valid {
                stateTextField.becomeFirstResponder()
            }
            valid = false
        } else {
            stateTextField.rightView?.isHidden = true
        }
        
        let zipCode = zipCodeTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        if zipCode.count != 5 {
            zipCodeTextField.rightView?.isHidden = false
            if valid {
                zipCodeTextField.becomeFirstResponder()
            }
            valid = false
        } else {
            zipCodeTextField.rightView?.isHidden = true
        }
        
        let country = countryTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        if country.isEmpty {
            countryTextField.rightView?.isHidden = false
            if valid {
                countryTextField.becomeFirstResponder()
            }
            valid = false
        } else {
            countryTextField.rightView?.isHidden = true
        }
        
        let phoneNumber = phoneTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        if !phoneNumber.isValidPhone() {
            phoneTextField.rightView?.isHidden = false
            if valid {
                phoneTextField.becomeFirstResponder()
            }
            valid = false
        } else {
            phoneTextField.rightView?.isHidden = true
        }
        
        if valid {
            // TODO: Save billing settings
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func onBackClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onScanClick() {
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)!
        cardIOVC.modalPresentationStyle = .currentContext
        self.present(cardIOVC, animated: true, completion: nil)
    }
    
    func updateLabel(_ isValid: Bool, textField: UITextField) {
        if isValid {
            textField.textColor = UIColor.iBlack90
        } else {
            textField.textColor = UIColor.red
        }
    }
    
    func getCardImage(_ cardNumber: String) -> UIImage {
        do {
            let cardType = try CreditCard.cardType(for: cardNumber, suggest: true)
            return cardType.image()
        } catch {
            return UIImage(named: "credit-card")!
        }
    }
    
}

// MARK: - private functions
fileprivate extension BillingViewController {
    func prepareNavigation() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "Billing Settings"
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
        
        let rightButton = UIBarButtonItem(image: UIImage(named: "icon-scan"), style: .plain, target: self, action: #selector(onScanClick))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func prepareCardViews() {
        cardInfoView.layer.cornerRadius = 8.0
        cardInfoView.layer.borderColor = UIColor.iBlack70.cgColor
        cardInfoView.layer.borderWidth = 0.5
        cardInfoView.layer.masksToBounds = true
        
        billingInfoView.layer.cornerRadius = 8.0
        billingInfoView.layer.borderColor = UIColor.iBlack70.cgColor
        billingInfoView.layer.borderWidth = 0.5
        billingInfoView.layer.masksToBounds = true
        
        phoneView.layer.cornerRadius = 8.0
        phoneView.layer.borderColor = UIColor.iBlack70.cgColor
        phoneView.layer.borderWidth = 0.5
        phoneView.layer.masksToBounds = true
    }
    
    func prepareCPVInternal() {
        cpvInternal.dataSource = self
        cpvInternal.delegate = self
        cpvInternal.font = LatoFont.regular(with: 17)
        cpvInternal.showPhoneCodeInView = false
        cpvInternal.showCountryCodeInView = false
    }
    
    func prepareTextFields() {
        fullNameTextField.setLeftPaddingPoints(16)
        cardNumberTextField.setLeftPaddingPoints(16)
        expDateTextField.setLeftPaddingPoints(16)
        cvvTextField.setLeftPaddingPoints(16)
        cityTextField.setLeftPaddingPoints(16)
        stateTextField.setLeftPaddingPoints(16)
        zipCodeTextField.setLeftPaddingPoints(16)
        
        cardNumberTextField.showDoneButtonOnKeyboard()
        expDateTextField.showDoneButtonOnKeyboard()
        cvvTextField.showDoneButtonOnKeyboard()
        zipCodeTextField.showDoneButtonOnKeyboard()
    }
    
    func preparePhoneTextField() {
        phoneTextField.withFlag = true
        phoneTextField.withPrefix = true
        phoneTextField.withExamplePlaceholder = true
        phoneTextField.placeholder = "Enter phone number"
        phoneTextField.showDoneButtonOnKeyboard()
        phoneTextField.isPartialFormatterEnabled = true
        
        // set right view
        let errorImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        errorImageView.image = UIImage(named: "icon-error")
        errorImageView.contentMode = .center
        
        phoneTextField.rightView = errorImageView
        phoneTextField.rightViewMode = .always
        phoneTextField.rightView?.isHidden = true
    }
    
    func prepareButton() {
        btnSave.applyContainedTheme(withScheme: Global.defaultButtonScheme())
    }
}
