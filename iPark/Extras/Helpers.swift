//
//  Helpers.swift
//  iPark
//
//  Created by King on 2019/11/13.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func showFlip() {
        if self.isHidden {
            UIView.transition(with: self, duration: 1, options: [.transitionFlipFromRight,.allowUserInteraction], animations: {
                self.isHidden = false
            })
        }
    }
    
    func hideFlip() {
        if !self.isHidden {
            UIView.transition(with: self, duration: 1, options: [.transitionFlipFromRight,.allowUserInteraction], animations: nil, completion: { _ in
                self.isHidden = true
            })
            
        }
    }
    
    func showFade() {
        if self.isHidden {
            UIView.transition(with: self, duration: 2, options: [.curveEaseIn, .allowUserInteraction], animations: nil, completion: nil)
            self.isHidden = false
        }
    }
    
    func hideFade() {
        if !self.isHidden {
            UIView.transition(with: self, duration: 1, options: [.curveEaseIn, .allowUserInteraction], animations: nil, completion: nil)
            self.isHidden = true
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    open class var iDarkBlue: UIColor {
        return UIColor(rgb: 0x0A009C)
    }
    
    open class var iYellow: UIColor {
        return UIColor(rgb: 0xFCBA35)
    }
    
    open class var iBlack100: UIColor {
        return UIColor(rgb: 0x000203)
    }
    
    open class var iBlack95: UIColor {
        return UIColor(rgb: 0x343F4B)
    }
    
    open class var iBlack90: UIColor {
        return UIColor(rgb: 0x47525E)
    }
    
    open class var iBlack80: UIColor {
        return UIColor(rgb: 0x8190A5)
    }
    
    open class var iBlack70: UIColor {
        return UIColor(rgb: 0x8492A6)
    }
    
    open class var iBlack60: UIColor {
        return UIColor(rgb: 0x838997)
    }
    
    open class var iBlack50: UIColor {
        return UIColor(rgb: 0x969FAA)
    }
    
    open class var iBlack40: UIColor {
        return UIColor(rgb: 0xE6E5F5)
    }
    
    open class var iGray: UIColor {
        return UIColor(rgb: 0x6A6A6A)
    }
}

extension CALayer {

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

        let border = CALayer()

        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: UIScreen.main.bounds.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }

        border.backgroundColor = color.cgColor;

        self.addSublayer(border)
    }

}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}

extension UINavigationItem {
    @objc func setTwoLineTitle(lineOne: String, lineTwo: String) {
        let titleParameters = [NSAttributedString.Key.foregroundColor : UIColor.white,
                               NSAttributedString.Key.font : LatoFont.regular(with: 13)] as [NSAttributedString.Key : Any]
        let subtitleParameters = [NSAttributedString.Key.foregroundColor : UIColor.white,
                                  NSAttributedString.Key.font : LatoFont.bold(with: 17)] as [NSAttributedString.Key : Any]

        let title:NSMutableAttributedString = NSMutableAttributedString(string: lineOne, attributes: titleParameters)
        let subtitle:NSAttributedString = NSAttributedString(string: lineTwo, attributes: subtitleParameters)

        title.append(NSAttributedString(string: "\n"))
        title.append(subtitle)

        let size = title.size()

        let width = size.width
        let height = CGFloat(44)

        let titleLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: width, height: height))
        titleLabel.attributedText = title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left

        titleView = titleLabel
    }
}

extension UIViewController {
    func getNavigationController() -> UINavigationController {
        let navVC = UINavigationController(rootViewController: self)
        
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.barTintColor = UIColor.iDarkBlue
        navVC.navigationBar.tintColor = UIColor.white
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: LatoFont.bold(with: 20)]
        navVC.navigationBar.barStyle = .black
        
        return navVC
    }
    
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}

extension UIButton {
    /// Set background image from selected color
    func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let colorImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.setBackgroundImage(colorImage, for: forState)
    }
}

extension Date {

    /// Returns a Date with the specified amount of components added to the one it is called with
    func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        let components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        return Calendar.current.date(byAdding: components, to: self)
    }

    /// Returns a Date with the specified amount of components subtracted from the one it is called with
    func subtract(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        return add(years: -years, months: -months, days: -days, hours: -hours, minutes: -minutes, seconds: -seconds)
    }
    
    /// Returns a formatted date string
    func dateString(_ format: String = "EEE, MMM dd, h:mm a") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }

}

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

        if enterdYr > currentYear {
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

        if str.count < 3 {
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
        
        if cleanCVV.count == 3 {
            return true
        } else {
            return false
        }
    }
    
    func formattedCVV() -> String {
        let cleanCVV = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "###"
        
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

extension UIImageView {
  func rotate(withAngle angle: CGFloat, animated: Bool) {
    UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
       self.transform = CGAffineTransform(rotationAngle: angle)
    })
  }
}

extension UITextField {
    func showDoneButtonOnKeyboard() {
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(resignFirstResponder))
        
        var toolBarItems = [UIBarButtonItem]()
        toolBarItems.append(flexSpace)
        toolBarItems.append(doneButton)
        
        let doneToolbar = UIToolbar()
        doneToolbar.items = toolBarItems
        doneToolbar.sizeToFit()
        
        inputAccessoryView = doneToolbar
    }
    
    func setLeftPaddingPoints(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
