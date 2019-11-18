//
//  DetailsViewController.swift
//  iPark
//
//  Created by King on 2019/11/16.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class DetailsViewController: UIViewController {
    
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
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var lableHours: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var btnDirections: FlatButton!
    @IBOutlet weak var labelPhone: UILabel!
    
    @IBOutlet weak var ratesView: UIView!
    
    @IBOutlet weak var specialsView: UIView!
    
    @IBOutlet weak var scrollHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation(title: "West 90TH Garage Corp.", subTitle: "7 East 14th Street, New York, NY...")
        prepareHoursImageView()
        prepareLocationImageView()
        prepareTypeSegmentedControl()
        prepareSegmentedControl()
        prepareHelpButton()
        prepareGetDirectionsButton()
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
        
    }
    
    @IBAction func onDirectionsClick(_ sender: Any) {
        
    }
    
    @IBAction func onViewIndexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            infoView.isHidden = false
            ratesView.isHidden = true
            specialsView.isHidden = true
            scrollHeight.constant = 1100
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
        btnHelp.layer.borderWidth = 0.5
        btnHelp.layer.borderColor = UIColor.iBlack70.cgColor
        
        btnHelp.setImage(UIImage(named: "icon-questionmark")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnHelp.tintColor = UIColor.iBlack90
    }
    
    func prepareGetDirectionsButton() {
        btnDirections.layer.cornerRadius = 4
        btnDirections.layer.borderWidth = 0.5
        btnDirections.layer.borderColor = UIColor.iBlack70.cgColor
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
