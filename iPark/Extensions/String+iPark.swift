//
//  String+iPark.swift
//  iPark
//
//  Created by King on 2019/12/25.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPhone() -> Bool {
        let PHONE_REGEX = "^[(]([2-9][0-8][0-9])[)] ([2-9][0-9]{2})-([0-9]{4})$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
    
    func formattedNumber() -> String {
        let cleanPhoneNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(###) ###-####"

        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "#" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
    
    func isValidCardNumber() -> Bool {
        do {
            try CreditCard.performAlgorithm(with: self)
            return true
        }
        catch {
            return false
        }
    }
    
    func cardType() -> CreditCard.CardType? {
        let cardType = try? CreditCard.cardType(for: self)
        return cardType
    }
    
    func suggestedCardType() -> CreditCard.CardType? {
        let cardType = try? CreditCard.cardType(for: self, suggest: true)
        return cardType
    }
    
    // AMEX card format
    func formattedCardNumber() -> String {
        let cleanCardNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "#### ###### #####"

        var result = ""
        var index = cleanCardNumber.startIndex
        for ch in mask where index < cleanCardNumber.endIndex {
            if ch == "#" {
                result.append(cleanCardNumber[index])
                index = cleanCardNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func isValidExpDate() -> Bool {

        let currentYear = Calendar.current.component(.year, from: Date()) % 100   // This will give you current year (i.e. if 2019 then it will be 19)
        let currentMonth = Calendar.current.component(.month, from: Date()) // This will give you current month (i.e if June then it will be 6)

        let enterdYr = Int(self.suffix(2)) ?? 0   // get last two digit from entered string as year
        let enterdMonth = Int(self.prefix(2)) ?? 0  // get first two digit from entered string as month
        print(self) // This is MM/YY Entered by user

        if enterdYr > currentYear && enterdYr <= currentYear + 15 {
            if (1 ... 12).contains(enterdMonth){
                return true
            } else {
                return false
            }
        } else  if currentYear == enterdYr {
            if enterdMonth >= currentMonth
            {
                if (1 ... 12).contains(enterdMonth) {
                   return true
                }  else {
                   return false
                }
            } else {
                return false
            }
        } else {
           return false
        }
    }
    
    func formattedExpDate() -> String {
        var str = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "##/##"

        if str.count > 0 && str.count < 3 {
            let month = Int(str)!
            if str.count == 1 && month >= 2{
                str = "0" + str
            } else if str.count == 2 && month > 12 {
                str = "0" + str
            }
        }
        
        var result = ""
        var index = str.startIndex
        for ch in mask where index < str.endIndex {
            if ch == "#" {
                result.append(str[index])
                index = str.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func isValidCVV() -> Bool {
        let cleanCVV = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        if cleanCVV.count == 3 || cleanCVV.count == 4 {
            return true
        } else {
            return false
        }
    }
    
    func formattedCVV() -> String {
        let cleanCVV = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "####"
        
        var result = ""
        var index = cleanCVV.startIndex
        for ch in mask where index < cleanCVV.endIndex {
            if ch == "#" {
                result.append(cleanCVV[index])
                index = cleanCVV.index(after: index)
            } else {
                result.append(ch)
            }
        }
        
        return result
    }
    
    func isValidZipCode() -> Bool {
        let clean = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        if clean.count == 5 {
            return true
        } else {
            return false
        }
    }
    
    func formattedZipCode() -> String {
        let clean = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "#####"
        
        var result = ""
        var index = clean.startIndex
        for ch in mask where index < clean.endIndex {
            if ch == "#" {
                result.append(clean[index])
                index = clean.index(after: index)
            } else {
                result.append(ch)
            }
        }
        
        return result
    }
}

extension StringProtocol {
    subscript(_ offset: Int)                     -> Element     { self[index(startIndex, offsetBy: offset)] }
    subscript(_ range: Range<Int>)               -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: ClosedRange<Int>)         -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence { prefix(range.upperBound.advanced(by: 1)) }
    subscript(_ range: PartialRangeUpTo<Int>)    -> SubSequence { prefix(range.upperBound) }
    subscript(_ range: PartialRangeFrom<Int>)    -> SubSequence { suffix(Swift.max(0, count-range.lowerBound)) }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}
