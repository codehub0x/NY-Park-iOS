//
//  BillingViewController+Delegate.swift
//  iPark
//
//  Created by King on 2019/12/23.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import UIKit
import CountryPickerView

// MARK: UITextField delegate
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
            let cardNumber = CreditCard.formattedNumber(with: updatedString)
            if CreditCard.isValidEditable(with: updatedString) {
                cardNumberTextField.text = cardNumber
            }
            cardImageView.image = getCardImage(cardNumber)
            
            let isValid = cardNumber.isValidCardNumber()
            updateLabel(isValid, textField: textField)
            if isValid {
                expDateTextField.becomeFirstResponder()
            }
            return false
        } else if textField == expDateTextField {
            let expDate = updatedString.formattedExpDate()
            let isValid = expDate.isValidExpDate()
            updateLabel(isValid, textField: textField)
            textField.text = expDate
            if isValid {
                expDateTextField.rightView?.isHidden = true
                cvvTextField.becomeFirstResponder()
            }
            return false
        } else if textField == cvvTextField {
            let cvv = updatedString.formattedCVV()
            let isValid = cvv.isValidCVV()
            updateLabel(isValid, textField: textField)
            textField.text = cvv
            if isValid {
//                cityTextField.becomeFirstResponder()
            }
            return false
        } else if textField == zipCodeTextField {
            let zipCode = updatedString.formattedZipCode()
            let isValid = zipCode.isValidZipCode()
            updateLabel(isValid, textField: textField)
            textField.text = zipCode
            if isValid {
                countryTextField.becomeFirstResponder()
            }
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let str = textField.text?.trimmingCharacters(in: .whitespaces) ?? ""
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

// MARK: - CardIO delegate
extension BillingViewController: CardIOPaymentViewControllerDelegate {
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        print("userDidCancel")
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        print("userDidProvide")
        let expiryMonth = cardInfo.expiryMonth > 9 ? "\(cardInfo.expiryMonth)" : "0\(cardInfo.expiryMonth)"
        let expiryYear = cardInfo.expiryYear - 2000
        let expDate = "\(expiryMonth)/\(expiryYear)"
        
        cardNumberTextField.text = CreditCard.formattedNumber(with: cardInfo.cardNumber)
        expDateTextField.text = expDate
        cvvTextField.text = cardInfo.cvv
        paymentViewController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - CountryPickerView delegate
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

// MARK: - CountryPickerView DataSource
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
