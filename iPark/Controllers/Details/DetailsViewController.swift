//
//  DetailsViewController.swift
//  iPark
//
//  Created by King on 2019/11/16.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import MapKit
import ImageSlideshow
import MaterialComponents.MaterialButtons

class DetailsViewController: UIViewController {
    
    static let storyboardId = "\(DetailsViewController.self)"
    
    @IBOutlet weak var labelStartTime: UILabel!
    @IBOutlet weak var labelEndTime: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelStayPayload: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var btnHelp: MDCButton!
    @IBOutlet weak var btnBook: MDCButton!
    @IBOutlet weak var labelSuv: UILabel!
    @IBOutlet weak var labelTax: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var hoursImageView: UIImageView!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var labelHours: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var btnDirections: MDCButton!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelHoursTitle: UILabel!
    @IBOutlet weak var labelAddressTitle: UILabel!
    @IBOutlet weak var labelPhoneTitle: UILabel!
    
    @IBOutlet weak var ratesView: UIView!
    
    @IBOutlet weak var specialsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation(title: "West 90TH Garage Corp.", subTitle: "7 East 14th Street, New York, NY...")
        prepareHoursImageView()
        prepareLocationImageView()
        prepareTypeSegmentedControl()
        prepareSegmentedControl()
        prepareSlideshow()
        prepareButtons()
        prepareHoursTitle()
        prepareAddressTitle()
        preparePhoneTitle()
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
    
    @objc func onFavoriteClick() {
        
    }
    
    @objc func didTabSlideshow() {
        let fullScreenController = slideshow.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    @IBAction func onHelpClick(_ sender: Any) {
        
    }
    
    @IBAction func onBookClick(_ sender: Any) {
        let newVC = storyboard!.instantiateViewController(withIdentifier: BookViewController.storyboardId)
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onDirectionsClick(_ sender: Any) {
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
    
    @IBAction func onViewIndexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            infoView.isHidden = false
            ratesView.isHidden = true
            specialsView.isHidden = true
            break
        case 1:
            infoView.isHidden = true
            ratesView.isHidden = false
            specialsView.isHidden = true
            break
        case 2:
            infoView.isHidden = true
            ratesView.isHidden = true
            specialsView.isHidden = false
            break
        default:
            break
        }
    }
}

// MARK: - ImageSlideshow delegate
extension DetailsViewController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
}

fileprivate extension DetailsViewController {
    func prepareNavigation(title: String, subTitle: String) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.setTwoLineTitle(lineOne: title, lineTwo: subTitle)
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
        
        let rightButton = UIBarButtonItem(image: UIImage(named: "icon-favorite"), style: .plain, target: self, action: #selector(onFavoriteClick))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func prepareHoursImageView() {
        hoursImageView.image = hoursImageView.image?.withRenderingMode(.alwaysTemplate)
        hoursImageView.tintColor = UIColor.white
    }
    
    func prepareLocationImageView() {
        locationImageView.image = locationImageView.image?.withRenderingMode(.alwaysTemplate)
        locationImageView.tintColor = UIColor.iGray
    }
    
    func prepareTypeSegmentedControl() {
        if #available(iOS 13.0, *) {
            typeSegmentedControl.selectedSegmentTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.63)
        } else {
            // Fallback on earlier versions
//            typeSegmentedControl.setBackgroundImage(imageWithColor(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.63)), for: .selected, barMetrics: .default)
            typeSegmentedControl.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.63)
            typeSegmentedControl.layer.cornerRadius = 4
        }
        typeSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: LatoFont.bold(with: 15), NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        typeSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: LatoFont.bold(with: 15), NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
    }
    
    func prepareSegmentedControl() {
        if #available(iOS 13.0, *) {
            segmentedControl.selectedSegmentTintColor = UIColor.iDarkBlue
        } else {
            // Fallback on earlier versions
//            segmentedControl.setBackgroundImage(imageWithColor(color: UIColor.iDarkBlue), for: .selected, barMetrics: .default)
            segmentedControl.tintColor = UIColor.iDarkBlue
        }
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: LatoFont.bold(with: 15), NSAttributedString.Key.foregroundColor: UIColor.iBlack90], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: LatoFont.bold(with: 15), NSAttributedString.Key.foregroundColor: UIColor.iYellow], for: .selected)
        
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = UIColor.iBlack90.cgColor
        segmentedControl.layer.cornerRadius = 4
        segmentedControl.layer.masksToBounds = true
    }
    
    func prepareButtons() {
        btnBook.applyContainedTheme(withScheme: Global.defaultButtonScheme())
        
        btnHelp.applyOutlinedTheme(withScheme: Global.outlinedButtonScheme())
        btnHelp.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let textString = NSMutableAttributedString(
            string: btnDirections.title(for: .normal)!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.bold(with: 12),
                NSAttributedString.Key.foregroundColor: btnDirections.titleColor(for: .normal)!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 1, range: textRange)
        
        btnDirections.setAttributedTitle(textString, for: .normal)
        btnDirections.applyOutlinedTheme(withScheme: Global.smallOutlinedButtonScheme())
        btnDirections.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func prepareHoursTitle() {
        let textString = NSMutableAttributedString(
            string: labelHoursTitle.text!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.black(with: 13.33),
                NSAttributedString.Key.foregroundColor: labelHoursTitle.textColor!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 2, range: textRange)
        labelHoursTitle.attributedText = textString
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
    
    func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}
