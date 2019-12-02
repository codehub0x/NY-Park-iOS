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
    let cpvInternal = CountryPickerView()
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareCardViews()
        prepareCPVInternal()
        prepareTextFields()
    }
    
    func initialize() {
        cardNumberTextField.text = "378282246310005"
        updateLabel(cardNumberTextField.text!.isValidCardNumber(), textField: cardNumberTextField)
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
    func prepareCardViews() {
        cardInfoView.layer.cornerRadius = 8.0
        cardInfoView.layer.borderColor = UIColor.iBlack50.cgColor
        cardInfoView.layer.borderWidth = 0.5
        cardInfoView.layer.masksToBounds = true
    }
    
    func prepareCPVInternal() {
        cpvInternal.dataSource = self
        cpvInternal.delegate = self
        cpvInternal.font = LatoFont.regular(with: 17)
        cpvInternal.showPhoneCodeInView = false
        cpvInternal.showCountryCodeInView = false
    }
    
    func prepareTextFields() {
        cardNumberTextField.showDoneButtonOnKeyboard()
        expDateTextField.showDoneButtonOnKeyboard()
        cvvTextField.showDoneButtonOnKeyboard()
        zipCodeTextField.showDoneButtonOnKeyboard()
    }
    
    func updateLabel(_ isValid: Bool, textField: UITextField) {
        if isValid {
            textField.textColor = UIColor.iBlack90
        } else {
            textField.textColor = UIColor.red
        }
    }
}
