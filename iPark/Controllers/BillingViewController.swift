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
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expDateTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var billingInfoView: UIView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
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
                let cardType = cardNumber.cardType()?.stringValue() ?? ""
                print(cardType)
                expDateTextField.becomeFirstResponder()
            }
            return false
        } else if textField == expDateTextField {
            let expDate = updatedString.formattedExpDate()
            let isValid = expDate.isValidExpDate()
            updateLabel(isValid, textField: textField)
            textField.text = expDate
            if isValid {
                cvvTextField.becomeFirstResponder()
            }
            return false
        } else if textField == cvvTextField {
            let cvv = updatedString.formattedCVV()
            let isValid = cvv.isValidCVV()
            updateLabel(isValid, textField: textField)
            textField.text = cvv
            if isValid {
                cityTextField.becomeFirstResponder()
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
                
            }
            return false
        }
        
        return true
    }
}

extension BillingViewController: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        countryTextField.text = country.name
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
        fullNameTextField.setRightPaddingPoints(16)
        
        cardNumberTextField.setLeftPaddingPoints(16)
        cardNumberTextField.setRightPaddingPoints(16)
        
        expDateTextField.setLeftPaddingPoints(16)
        expDateTextField.setRightPaddingPoints(16)
        
        cvvTextField.setLeftPaddingPoints(16)
        cvvTextField.setRightPaddingPoints(16)
        
        cityTextField.setLeftPaddingPoints(16)
        cityTextField.setRightPaddingPoints(16)
        
        stateTextField.setLeftPaddingPoints(16)
        stateTextField.setRightPaddingPoints(16)
        
        zipCodeTextField.setLeftPaddingPoints(16)
        zipCodeTextField.setRightPaddingPoints(16)
        
        countryTextField.setLeftPaddingPoints(16)
        countryTextField.setRightPaddingPoints(16)
        
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
    }
    
    func updateLabel(_ isValid: Bool, textField: UITextField) {
        if isValid {
            textField.textColor = UIColor.iBlack90
        } else {
            textField.textColor = UIColor.red
        }
    }
}
