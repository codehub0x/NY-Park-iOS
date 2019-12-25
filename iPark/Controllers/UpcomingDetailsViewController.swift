//
//  UpcomingDetailsViewController.swift
//  iPark
//
//  Created by King on 2019/11/18.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import MapKit
import ImageSlideshow
import MaterialComponents.MaterialButtons

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
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    @IBOutlet weak var labelVehicleTitle: UILabel!
    @IBOutlet weak var labelAmenitiesTitle: UILabel!
    @IBOutlet weak var labelHoursOfOperationTitle: UILabel!
    @IBOutlet weak var labelAddressTitle: UILabel!
    @IBOutlet weak var labelPhoneTitle: UILabel!
    
    @IBOutlet weak var btnAddCalendar: MDCButton!
    @IBOutlet weak var btnGetDirections: MDCButton!
    @IBOutlet weak var btnCancelReservation: MDCButton!
    @IBOutlet weak var btnPaid: MDCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation(title: "West 90TH Garage Corp.", subTitle: "7 East 14th Street, New York, NY...")
        prepareHoursImageView()
        prepareLocationImageView()
        prepareSlideshow()
        prepareButtons()
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
    
    @objc func didTabSlideshow() {
        let fullScreenController = slideshow.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    @IBAction func onAddToCalendarBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onGetDirectionsBtnClick(_ sender: Any) {
        let destLocation = CLLocationCoordinate2D(latitude: 40.748441, longitude: -73.985564)
        
        let urlStr = "http://maps.apple.com/maps?daddr=" + destLocation.latitude.string + "," + destLocation.longitude.string  + "&dirflg=d&t=m"
        guard let url = URL(string: urlStr),
            UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func onCancelReservationBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onPaidBtnClick(_ sender: Any) {
        
    }
}

// MARK: - ImageSlideshow delegate
extension UpcomingDetailsViewController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
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
    
    func prepareButtons() {
        btnAddCalendar.applyContainedTheme(withScheme: Global.secondaryButtonScheme())
        btnGetDirections.applyContainedTheme(withScheme: Global.defaultButtonScheme())
        
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
        btnCancelReservation.applyOutlinedTheme(withScheme: Global.smallOutlinedButtonScheme())
        
        let textString1 = NSMutableAttributedString(
            string: btnPaid.title(for: .normal)!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.regular(with: 17),
                NSAttributedString.Key.foregroundColor: btnPaid.titleColor(for: .normal)!
            ]
        )
        let textRange1 = NSRange(location: 0, length: textString1.length)
        let paragraphStyle1 = NSMutableParagraphStyle()
        paragraphStyle1.lineSpacing = 0
        textString1.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle1, range: textRange1)
        textString1.addAttribute(NSAttributedString.Key.kern, value: 1, range: textRange1)
        btnPaid.setAttributedTitle(textString1, for: .normal)
        btnPaid.applyOutlinedTheme(withScheme: Global.outlinedButtonScheme())
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
    
    func prepareSlideshow() {
        slideshow.zoomEnabled = true
        
        let pageIndicator = UIPageControl()
        let image = UIImage.outlinedEllipse(size: CGSize(width: 7, height: 7), color: .white)
        pageIndicator.pageIndicatorTintColor = .white
        pageIndicator.currentPageIndicatorTintColor = UIColor(patternImage: image!)
        slideshow.pageIndicator = pageIndicator
        
        slideshow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .customBottom(padding: 0))
        slideshow.contentScaleMode = .scaleAspectFill
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.delegate = self
        
        slideshow.setImageInputs([BundleImageSource(imageString: "image1"), BundleImageSource(imageString: "image2"), BundleImageSource(imageString: "image1"), BundleImageSource(imageString: "image2")])
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTabSlideshow))
        slideshow.addGestureRecognizer(recognizer)
    }
}
