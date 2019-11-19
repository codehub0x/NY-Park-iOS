//
//  BookViewController.swift
//  iPark
//
//  Created by King on 2019/11/19.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class BookViewController: UIViewController {
    
    static let storyboardId = "\(BookViewController.self)"
    
    @IBOutlet weak var labelDays: UILabel!
    @IBOutlet weak var labelHours: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelVehicle: UILabel!
    @IBOutlet weak var labelPayment: UILabel!
    @IBOutlet weak var switchMultipleDays: UISwitch!
    @IBOutlet weak var labelTotalName: UILabel!
    @IBOutlet weak var labelTotalPrice: UILabel!
    @IBOutlet weak var btnAddpayment: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation(title: "West 90TH Garage Corp.", subTitle: "7 East 14th Street, New York, NY...")
        prepareAddPaymentButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func onBackClick() {
        if let count = self.navigationController?.viewControllers.count, count > 1 {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func onVehicleBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onPaymentBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onPromoCodeBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onAddPaymentBtnClick(_ sender: Any) {
        
    }
}

fileprivate extension BookViewController {
    func prepareNavigation(title: String, subTitle: String) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.setTwoLineTitle(lineOne: title, lineTwo: subTitle)
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func prepareAddPaymentButton() {
        let textString = NSMutableAttributedString(
            string: btnAddpayment.title(for: .normal)!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.black(with: 18),
                NSAttributedString.Key.foregroundColor: btnAddpayment.titleColor(for: .normal)!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 1, range: textRange)
        btnAddpayment.setAttributedTitle(textString, for: .normal)
    }
}
