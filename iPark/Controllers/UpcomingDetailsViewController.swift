//
//  UpcomingDetailsViewController.swift
//  iPark
//
//  Created by King on 2019/11/18.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class UpcomingDetailsViewController: UIViewController {
    
    static let storyboardId = "\(UpcomingDetailsViewController.self)"
    
    @IBOutlet weak var labelStartTime: UILabel!
    @IBOutlet weak var labelEndTime: UILabel!
    @IBOutlet weak var labelPrice1: UILabel!
    @IBOutlet weak var hoursImageView: UIImageView!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var labelStayPayload: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var labelVehicle: UILabel!
    @IBOutlet weak var labelHoursOfOperation: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelTax: UILabel!
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var qrcodeImageView: UIImageView!
    @IBOutlet weak var barcodeImageView: UIImageView!
    
    @IBOutlet weak var labelVehicleTitle: UILabel!
    @IBOutlet weak var labelAmenitiesTitle: UILabel!
    @IBOutlet weak var labelHoursOfOperationTitle: UILabel!
    @IBOutlet weak var labelAddressTitle: UILabel!
    @IBOutlet weak var labelPhoneTitle: UILabel!
    
    @IBOutlet weak var btnCancelReservation: FlatButton!
    @IBOutlet weak var btnPaid: FlatButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation(title: "West 90TH Garage Corp.", subTitle: "7 East 14th Street, New York, NY...")
        prepareHoursImageView()
        prepareLocationImageView()
        prepareCancelReservationButton()
        preparePaidButton()
        prepareVehicleTitle()
        prepareAmenitiesTitle()
        prepareAddressTitle()
        prepareHoursOfOperationTitle()
        preparePhoneTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func onBackClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onAddToCalendarBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onGetDirectionsBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onCancelReservationBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onPaidBtnClick(_ sender: Any) {
        
    }
}

fileprivate extension UpcomingDetailsViewController {
    func prepareNavigation(title: String, subTitle: String) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.setTwoLineTitle(lineOne: title, lineTwo: subTitle)
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func prepareHoursImageView() {
        hoursImageView.image = hoursImageView.image?.withRenderingMode(.alwaysTemplate)
        hoursImageView.tintColor = UIColor.white
    }
    
    func prepareLocationImageView() {
        locationImageView.image = locationImageView.image?.withRenderingMode(.alwaysTemplate)
        locationImageView.tintColor = UIColor.iGray
    }
    
    func prepareCancelReservationButton() {
        let textString = NSMutableAttributedString(
            string: btnCancelReservation.title(for: .normal)!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.bold(with: 12),
                NSAttributedString.Key.foregroundColor: btnCancelReservation.titleColor(for: .normal)!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 1, range: textRange)
        btnCancelReservation.setAttributedTitle(textString, for: .normal)
        btnCancelReservation.layer.borderWidth = 1
        btnCancelReservation.layer.cornerRadius = 2
        btnCancelReservation.layer.borderColor = UIColor.iBlack70.cgColor
    }
    
    func preparePaidButton() {
        let textString = NSMutableAttributedString(
            string: btnPaid.title(for: .normal)!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.regular(with: 17),
                NSAttributedString.Key.foregroundColor: btnPaid.titleColor(for: .normal)!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 1, range: textRange)
        btnPaid.setAttributedTitle(textString, for: .normal)
        btnPaid.layer.borderWidth = 1
        btnPaid.layer.cornerRadius = 2
        btnPaid.layer.borderColor = UIColor.iBlack70.cgColor
    }
    
    func prepareVehicleTitle() {
        let textString = NSMutableAttributedString(
            string: labelVehicleTitle.text!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.black(with: 13.33),
                NSAttributedString.Key.foregroundColor: labelVehicleTitle.textColor!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 2, range: textRange)
        labelVehicleTitle.attributedText = textString
    }
    
    func prepareAmenitiesTitle() {
        let textString = NSMutableAttributedString(
            string: labelAmenitiesTitle.text!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.black(with: 13.33),
                NSAttributedString.Key.foregroundColor: labelAmenitiesTitle.textColor!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 2, range: textRange)
        labelAmenitiesTitle.attributedText = textString
    }
    
    func prepareHoursOfOperationTitle() {
        let textString = NSMutableAttributedString(
            string: labelHoursOfOperationTitle.text!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.black(with: 13.33),
                NSAttributedString.Key.foregroundColor: labelHoursOfOperationTitle.textColor!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 2, range: textRange)
        labelHoursOfOperationTitle.attributedText = textString
    }
    
    func prepareAddressTitle() {
        let textString = NSMutableAttributedString(
            string: labelAddressTitle.text!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.black(with: 13.33),
                NSAttributedString.Key.foregroundColor: labelAddressTitle.textColor!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 2, range: textRange)
        labelAddressTitle.attributedText = textString
    }
    
    func preparePhoneTitle() {
        let textString = NSMutableAttributedString(
            string: labelPhoneTitle.text!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.black(with: 13.33),
                NSAttributedString.Key.foregroundColor: labelPhoneTitle.textColor!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 2, range: textRange)
        labelPhoneTitle.attributedText = textString
    }
}
