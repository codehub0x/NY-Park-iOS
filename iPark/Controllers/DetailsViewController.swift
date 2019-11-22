//
//  DetailsViewController.swift
//  iPark
//
//  Created by King on 2019/11/16.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material
import FSPagerView

class DetailsViewController: UIViewController {
    
    static let storyboardId = "\(DetailsViewController.self)"
    
    @IBOutlet weak var labelStartTime: UILabel!
    @IBOutlet weak var labelEndTime: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelStayPayload: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var btnHelp: FlatButton!
    @IBOutlet weak var labelSuv: UILabel!
    @IBOutlet weak var labelTax: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var hoursImageView: UIImageView!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.isInfinite = true
        }
    }
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.images.count
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pageControl.hidesForSinglePage = true
            self.pageControl.setStrokeColor(.white, for: .normal)
            self.pageControl.setStrokeColor(.white, for: .selected)
            self.pageControl.setFillColor(.white, for: .selected)
        }
    }
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var labelHours: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var btnDirections: FlatButton!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelHoursTitle: UILabel!
    @IBOutlet weak var labelAddressTitle: UILabel!
    @IBOutlet weak var labelPhoneTitle: UILabel!
    
    @IBOutlet weak var ratesView: UIView!
    
    @IBOutlet weak var specialsView: UIView!
    
    @IBOutlet weak var scrollHeight: NSLayoutConstraint!
    
    var images = [
        UIImage(named: "image1"),
        UIImage(named: "image2")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation(title: "West 90TH Garage Corp.", subTitle: "7 East 14th Street, New York, NY...")
        prepareHoursImageView()
        prepareLocationImageView()
        prepareTypeSegmentedControl()
        prepareSegmentedControl()
        prepareHelpButton()
        prepareGetDirectionsButton()
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
    
    @IBAction func onHelpClick(_ sender: Any) {
        
    }
    
    @IBAction func onBookClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var newVC: UIViewController!
        if #available(iOS 13.0, *) {
            newVC = storyboard.instantiateViewController(identifier: BookViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            newVC = storyboard.instantiateViewController(withIdentifier: BookViewController.storyboardId)
        }
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onDirectionsClick(_ sender: Any) {
        
    }
    
    @IBAction func onViewIndexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            infoView.isHidden = false
            ratesView.isHidden = true
            specialsView.isHidden = true
            scrollHeight.constant = 1160
            break
        case 1:
            infoView.isHidden = true
            ratesView.isHidden = false
            specialsView.isHidden = true
            scrollHeight.constant = 900
            break
        case 2:
            infoView.isHidden = true
            ratesView.isHidden = true
            specialsView.isHidden = false
            scrollHeight.constant = 700
            break
        default:
            break
        }
    }
}

// MARK: - FSPagerView data source
extension DetailsViewController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return images.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = images[index]
        cell.imageView?.contentMode = .scaleAspectFill
        return cell
    }
}

// MARK: - FSPagerView delegate
extension DetailsViewController: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
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
    
    func prepareHelpButton() {
        btnHelp.layer.cornerRadius = 4
        btnHelp.layer.borderWidth = 1
        btnHelp.layer.borderColor = UIColor.iBlack70.cgColor
        
        btnHelp.setImage(UIImage(named: "icon-questionmark")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnHelp.tintColor = UIColor.iBlack90
    }
    
    func prepareGetDirectionsButton() {
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
        btnDirections.layer.borderWidth = 1
        btnDirections.layer.cornerRadius = 4
        btnDirections.layer.borderColor = UIColor.iBlack70.cgColor
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
