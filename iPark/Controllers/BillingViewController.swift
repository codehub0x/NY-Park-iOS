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

class BillingViewController: UIViewController {
    
    static let storyboardId = "\(BillingViewController.self)"
    
    @IBOutlet weak var cardInfoView: UIView!
    @IBOutlet weak var fullNameTextField: ErrorTextField!
    @IBOutlet weak var cardNumberTextField: ErrorTextField!
    @IBOutlet weak var expDateTextField: ErrorTextField!
    @IBOutlet weak var cvvTextField: ErrorTextField!
    @IBOutlet weak var billingInfoView: ErrorTextField!
    @IBOutlet weak var cityTextField: ErrorTextField!
    @IBOutlet weak var stateTextField: ErrorTextField!
    @IBOutlet weak var zipCodeTextField: ErrorTextField!
    @IBOutlet weak var countryTextField: ErrorTextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTextField: PhoneNumberTextField!
    let cpvInternal = CountryPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation()
        prepareCardViews()
        prepareCPVInternal()
        prepareTextFields()
        preparePhoneTextField()
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        var valid = true
        let fullName = fullNameTextField.text!.trimmed
        if fullName.isEmpty {
            fullNameTextField.rightView?.isHidden = false
            fullNameTextField.becomeFirstResponder()
            valid = false
        } else {
            fullNameTextField.rightView?.isHidden = true
        }
        
        let cardNumber = cardNumberTextField.text!.trimmed
        if cardNumber.isValidCardNumber() {
            cardNumberTextField.rightView?.isHidden = true
        } else {
            cardNumberTextField.rightView?.isHidden = false
            if valid {
                cardNumberTextField.becomeFirstResponder()
            }
            valid = false
        }
        
        let expDate = expDateTextField.text!.trimmed
        if expDate.isValidExpDate() {
            expDateTextField.rightView?.isHidden = true
        } else {
            expDateTextField.rightView?.isHidden = false
            if valid {
                expDateTextField.becomeFirstResponder()
            }
            valid = false
        }
        
        let cvv = cvvTextField.text!.trimmed
        if cvv.isValidCVV() {
            cvvTextField.rightView?.isHidden = true
        } else {
            cvvTextField.rightView?.isHidden = false
            if valid {
                cvvTextField.becomeFirstResponder()
            }
            valid = false
        }
        
        let city = cityTextField.text!.trimmed
        if city.isEmpty {
            cityTextField.rightView?.isHidden = false
            if valid {
                cityTextField.becomeFirstResponder()
            }
            valid = false
        } else {
            cityTextField.rightView?.isHidden = true
        }
        
        let state = stateTextField.text!.trimmed
        if state.isEmpty {
            stateTextField.rightView?.isHidden = false
            if valid {
                stateTextField.becomeFirstResponder()
            }
            valid = false
        } else {
            stateTextField.rightView?.isHidden = true
        }
        
        let zipCode = zipCodeTextField.text!.trimmed
        if zipCode.count != 5 {
            zipCodeTextField.rightView?.isHidden = false
            if valid {
                zipCodeTextField.becomeFirstResponder()
            }
            valid = false
        } else {
            zipCodeTextField.rightView?.isHidden = true
        }
        
        let country = countryTextField.text!.trimmed
        if country.isEmpty {
            countryTextField.rightView?.isHidden = false
            if valid {
                countryTextField.becomeFirstResponder()
            }
            valid = false
        } else {
            countryTextField.rightView?.isHidden = true
        }
        
        let phoneNumber = phoneTextField.text!.trimmed
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
    
}

extension BillingViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == countryTextField {
            cpvInternal.showCountriesList(from: self)
            return false
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") as NSString
        let updatedString = text.replacingCharacters(in: range, with: string)
        
        if textField == cardNumberTextField {
            let cardNumber = updatedString.formattedCardNumber()
            let isValid = cardNumber.isValidCardNumber()
            updateLabel(isValid, textField: textField)
            textField.text = cardNumber
            if isValid {
                cardNumberTextField.textColor = .iBlack95
                let cardType = cardNumber.cardType()?.stringValue() ?? ""
                print(cardType)
                expDateTextField.becomeFirstResponder()
            } else {
                cardNumberTextField.textColor = .red
            }
            return false
        } else if textField == expDateTextField {
            let expDate = updatedString.formattedExpDate()
            let isValid = expDate.isValidExpDate()
            updateLabel(isValid, textField: textField)
            textField.text = expDate
            if isValid {
                expDateTextField.textColor = .iBlack95
                expDateTextField.rightView?.isHidden = true
                cvvTextField.becomeFirstResponder()
            } else {
                expDateTextField.textColor = .red
            }
            return false
        } else if textField == cvvTextField {
            let cvv = updatedString.formattedCVV()
            let isValid = cvv.isValidCVV()
            updateLabel(isValid, textField: textField)
            textField.text = cvv
            if isValid {
                cvvTextField.textColor = .iBlack95
                cityTextField.becomeFirstResponder()
            } else {
                cvvTextField.textColor = .red
            }
        } else if textField == zipCodeTextField {
            let isValid = updatedString.count >= 5
            updateLabel(isValid, textField: textField)
            var zipCode = updatedString
            if zipCode.count > 5 {
                zipCode = String(zipCode.prefix(5))
            }
            textField.text = zipCode
            if isValid {
                zipCodeTextField.textColor = .iBlack95
                countryTextField.becomeFirstResponder()
            } else {
                zipCodeTextField.textColor = .red
            }
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let str = textField.text!.trimmed
        if textField == fullNameTextField {
            textField.rightView?.isHidden = !str.isEmpty
        } else if textField == cardNumberTextField {
            textField.rightView?.isHidden = str.isValidCardNumber()
        } else if textField == expDateTextField {
            textField.rightView?.isHidden = str.isValidExpDate()
        } else if textField == cvvTextField {
            textField.rightView?.isHidden = str.isValidCVV()
        } else if textField == cityTextField {
            textField.rightView?.isHidden = !str.isEmpty
        } else if textField == stateTextField {
            textField.rightView?.isHidden = !str.isEmpty
        } else if textField == zipCodeTextField {
            textField.rightView?.isHidden = str.count == 5
        } else if textField == countryTextField {
            textField.rightView?.isHidden = !str.isEmpty
        } else if textField == phoneTextField {
            textField.rightView?.isHidden = str.isValidPhone()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fullNameTextField {
            cardNumberTextField.becomeFirstResponder()
        } else if textField == cardNumberTextField {
            expDateTextField.becomeFirstResponder()
        } else if textField == expDateTextField {
            cvvTextField.becomeFirstResponder()
        } else if textField == cvvTextField {
            cityTextField.becomeFirstResponder()
        } else if textField == cityTextField {
            stateTextField.becomeFirstResponder()
        } else if textField == stateTextField {
            zipCodeTextField.becomeFirstResponder()
        } else if textField == zipCodeTextField {
            countryTextField.becomeFirstResponder()
        } else if textField == countryTextField {
            phoneTextField.becomeFirstResponder()
        } else if textField == phoneTextField {
            phoneTextField.resignFirstResponder()
        }
        return true
    }
}

extension BillingViewController: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        countryTextField.text = country.name
        let leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 12))
        leftImageView.image = country.flag
        leftImageView.contentMode = .scaleAspectFit
        countryTextField.leftView = leftImageView
        countryTextField.leftViewMode = .always
    }
}

extension BillingViewController: CountryPickerViewDataSource {
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        var countries = [Country]()
        ["US"].forEach { code in
            if let country = countryPickerView.getCountryByCode(code) {
                countries.append(country)
            }
        }
        return countries
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return "Preferred Countries"
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return "Select a Country"
    }
    
    func searchBarPosition(in countryPickerView: CountryPickerView) -> SearchBarPosition {
        return .tableViewHeader
    }
}

fileprivate extension BillingViewController {
    func prepareNavigation() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "Billing Settings"
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
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
        errorImageView.image = UIImage(named: "ic_error")
        errorImageView.contentMode = .center
        
        phoneTextField.rightView = errorImageView
        phoneTextField.rightViewMode = .always
        phoneTextField.rightView?.isHidden = true
    }
    
    func updateLabel(_ isValid: Bool, textField: UITextField) {
        if isValid {
            textField.textColor = UIColor.iBlack90
        } else {
            textField.textColor = UIColor.red
        }
    }
}
