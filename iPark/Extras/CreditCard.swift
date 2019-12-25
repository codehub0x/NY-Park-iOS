//
//  CreditCard.swift
//  iPark
//
//  Created by King on 2019/12/2.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation

class CreditCard {
    public enum CardType: Int {
        case amex = 0
        case visa
        case mastercard
        case discover
        case dinersClub
        case jcb
        case maestro
    }
    
    public enum CardError: Error {
        case unsupported
        case invalid
    }
    
    fileprivate class func regularExpression(for cardType: CardType) -> String {
        switch cardType {
        case .amex:
            return "^3[47][0-9]{5,}$"
        case .visa:
            return "^4[0-9]{6,}$"
        case .mastercard:
            return "^5[1-5][0-9]{5,}|222[1-9][0-9]{3,}|22[3-9][0-9]{4,}|2[3-6][0-9]{5,}|27[01][0-9]{4,}|2720[0-9]{3,}$"
        case .discover:
            return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
        case .dinersClub:
            return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
        case .jcb:
            return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
        case .maestro:
            return "^(50[0-9]{4,}|5[6-8][0-9]{4,}|6[0-9]{5,})$"
//            return "^(5018|5020|5038|5893|6304|6759|6761|6762|6763)[0-9]{8,15}$"
        }
    }
    
    fileprivate class func suggestionRegularExpression(for cardType: CardType) -> String {
        switch cardType {
        case .amex:
            return "^3[47][0-9]+$"
        case .visa:
            return "^4[0-9]+$"
        case .mastercard:
            return "^5[1-5][0-9]{5,}|222[1-9][0-9]{3,}|22[3-9][0-9]{4,}|2[3-6][0-9]{5,}|27[01][0-9]{4,}|2720[0-9]{3,}$"
        case .discover:
            return "^6(?:011|5[0-9]{2})[0-9]+$"
        case .dinersClub:
            return "^3(?:0[0-5]|[68][0-9])[0-9]+$"
        case .jcb:
            return "^(?:2131|1800|35[0-9]{3})[0-9]+$"
        case .maestro:
            return "^(50[0-9]{4,}|5[6-8][0-9]{4,}|6[0-9]{5,})$"
//            return "^(5018|5020|5038|5893|6304|6759|6761|6762|6763)[0-9]+$"
        }
    }
    
    class func isValidEditable(with cardNumber: String) -> Bool {
        let cleanCardNumber = cardNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let count = cleanCardNumber.count
        do {
            let type = try cardType(for: cleanCardNumber)
            
            switch type {
            case .amex:
                return count <= 15
            case .visa:
                return count <= 19
            case .mastercard:
                return count <= 16
            case .discover:
                return count <= 16
            case .dinersClub:
                return count <= 16
            case .jcb:
                return count <= 19
            case .maestro:
                return count <= 19
            }
        }
        catch {
            return count < 20
        }
    }
    
    class func formattedNumber(with cardNumber: String) -> String {
        let cleanCardNumber = cardNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let count = cleanCardNumber.count
        
        var pattern = ""
        do {
            let type = try cardType(for: cleanCardNumber)
            switch type {
            case .amex:
                pattern = "#### ###### #####"
                break
            case .visa:
                if count <= 16 {
                    pattern = "#### #### #### ####"
                } else if count <= 19 {
                    pattern = "#### #### #### #### ###"
                }
                break
            case .mastercard:
                pattern = "#### #### #### ####"
                break
            case .discover:
                pattern = "#### #### #### ####"
                break
            case .dinersClub:
                if count <= 14 {
                    pattern = "#### ###### ####"
                } else if count <= 16 {
                    pattern = "#### #### #### ####"
                }
                break
            case .jcb:
                pattern = "#### #### #### ####"
                break
            case .maestro:
                if count <= 13 {
                    pattern = "#### #### #####"
                } else if count <= 15 {
                    pattern = "#### ###### #####"
                } else if count == 16 {
                    pattern = "#### #### #### ####"
                } else if count <= 19 {
                    pattern = "#### #### #### #### ###"
                }
                break
            }
        } catch {
            
        }
        
        if pattern.isEmpty {
            return cleanCardNumber
        } else {
            var result = ""
            var index = cleanCardNumber.startIndex
            for ch in pattern where index < cleanCardNumber.endIndex {
                if ch == "#" {
                    result.append(cleanCardNumber[index])
                    index = cleanCardNumber.index(after: index)
                } else {
                    result.append(ch)
                }
            }
            return result
        }
    }
    
    class func performAlgorithm(with cardNumber: String) throws {
        let cleanCardNumber = cardNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)

        let count = cleanCardNumber.count
        do {
            let type = try cardType(for: cardNumber)
            switch type {
            case .amex:
                guard count == 15 else {
                    throw CardError.invalid
                }
                break
            case .visa:
                guard count >= 16 && count <= 19 else {
                    throw CardError.invalid
                }
                break
            case .mastercard:
                guard count == 16 else {
                    throw CardError.invalid
                }
                break
            case .discover:
                guard count == 16 else {
                    throw CardError.invalid
                }
                break
            case .dinersClub:
                guard count >= 14 && count <= 16 else {
                    throw CardError.invalid
                }
                break
            case .jcb:
                guard count == 16 else {
                    throw CardError.invalid
                }
                break
            case .maestro:
                guard count >= 12 && count <= 19 else {
                    throw CardError.invalid
                }
                break
            }
        } catch CardError.invalid {
            throw CardError.invalid
        } catch CardError.unsupported {
            guard count >= 12 && count <= 19 else {
                throw CardError.invalid
            }
        }
        
        let originalCheckDigit = cleanCardNumber.last!
        let characters = cleanCardNumber.dropLast().reversed()
        
        var digitSum = 0
        
        for (idx, character) in characters.enumerated() {
            let value = Int(String(character)) ?? 0
            if idx % 2 == 0 {
                var product = value * 2
                
                if product > 9 {
                    product = product - 9
                }
                
                digitSum = digitSum + product
            }
            else {
                digitSum = digitSum + value
            }
        }
        
        digitSum = digitSum * 9
        
        let computedCheckDigit = digitSum % 10
        
        let originalCheckDigitInt = Int(String(originalCheckDigit))
        let valid = originalCheckDigitInt == computedCheckDigit
        
        if valid == false {
            throw CardError.invalid
        }
    }
    
    class func cardType(for cardNumber: String, suggest: Bool = false) throws -> CardType {
        var foundCardType: CardType?
        let cleanCardNumber = cardNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        for i in CardType.amex.rawValue...CardType.maestro.rawValue {
            let cardType = CardType(rawValue: i)!
            let regex = suggest ? suggestionRegularExpression(for: cardType) : regularExpression(for: cardType)
            
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            
            if predicate.evaluate(with: cleanCardNumber) == true {
                foundCardType = cardType
                break
            }
        }
        
        if foundCardType == nil {
            throw CardError.unsupported
        }
        
        return foundCardType!
    }
}

public extension CreditCard.CardType {
    func stringValue() -> String {
        switch self {
        case .amex:
            return "American Express"
        case .visa:
            return "Visa"
        case .mastercard:
            return "Mastercard"
        case .discover:
            return "Discover"
        case .dinersClub:
            return "Diner's Club"
        case .jcb:
            return "JCB"
        case .maestro:
            return "Maestro"
        }
    }
    
    func image() -> UIImage {
        let cardImage = UIImage(named: "credit-card")!
        switch self {
        case .amex:
            return UIImage(named: "amex") ?? cardImage
        case .visa:
            return UIImage(named: "visa") ?? cardImage
        case .mastercard:
            return UIImage(named: "master") ?? cardImage
        case .discover:
            return UIImage(named: "discover") ?? cardImage
        case .dinersClub:
            return UIImage(named: "diners-club") ?? cardImage
        case .jcb:
            return UIImage(named: "jcb") ?? cardImage
        case .maestro:
            return UIImage(named: "maestro") ?? cardImage
        }
    }
    
    init?(string: String) {
        switch string.lowercased() {
        case "american express":
            self.init(rawValue: 0)
        case "visa":
            self.init(rawValue: 1)
        case "mastercard":
            self.init(rawValue: 2)
        case "discover":
            self.init(rawValue: 3)
        case "diner's club":
            self.init(rawValue: 4)
        case "jcb":
            self.init(rawValue: 5)
        case "maestro":
            self.init(rawValue: 6)
        default:
            return nil
        }
    }
}
