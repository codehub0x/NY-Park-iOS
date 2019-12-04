//
//  ItemView.swift
//  iPark
//
//  Created by King on 2019/11/14.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

protocol ReservationCellDelegate {
    func onDetails()
    func onDirections()
    func onRebook()
}

class ReservationCell: UITableViewCell {
    
    static let reuseIdentifier = "\(ReservationCell.self)"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageViewItem: UIImageView!
    @IBOutlet weak var labelLicense: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelStartTime: UILabel!
    @IBOutlet weak var labelEndTime: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelFlag: UILabel!
    @IBOutlet weak var btnDirections: MDCButton!
    @IBOutlet weak var btnDetails: MDCButton!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var hoursImageView: UIImageView!
    @IBOutlet weak var locationImageView: UIImageView!
    
    var delegate: ReservationCellDelegate!
    
    var reservationType: ReservationType = .upcoming {
        didSet {
            switch reservationType {
            case .upcoming:
                btnDirections.setTitle("DIRECTIONS", for: .normal)
                btnDirections.setImage(nil, for: .normal)
                btnDirections.applyContainedTheme(withScheme: Global.tinySecondaryButtonScheme())
                btnDirections.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
                priceView.backgroundColor = UIColor.iYellow
                labelPrice.textColor = UIColor.iDarkBlue
                labelFlag.isHidden = true
                break
            case .past:
                btnDirections.setTitle("REBOOK", for: .normal)
                btnDirections.setImage(UIImage(named: "icon-rebook")?.withRenderingMode(.alwaysTemplate), for: .normal)
                btnDirections.applyContainedTheme(withScheme: Global.tinyButtonScheme())
                btnDirections.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
                
                priceView.backgroundColor = UIColor.iDarkBlue
                labelPrice.textColor = UIColor.white
                labelFlag.isHidden = false
                break
            case .cancelled:
                btnDirections.setTitle("DIRECTIONS", for: .normal)
                btnDirections.setImage(nil, for: .normal)
                btnDirections.applyContainedTheme(withScheme: Global.tinySecondaryButtonScheme())
                btnDirections.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
                priceView.backgroundColor = UIColor.iYellow
                labelPrice.textColor = UIColor.iDarkBlue
                labelFlag.isHidden = true
                break
            }

            prepareDirectionsButton()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareCardView()
        prepareImageView()
        prepareHoursImageView()
        prepareLocationImageView()
        preparePriceView()
        prepareDetailsButton()
    }
    
    @IBAction func onDirectionsClick(_ sender: Any) {
        if delegate != nil {
            if reservationType == .past {
                delegate.onRebook()
            } else {
                delegate.onDirections()
            }
        }
    }
    
    @IBAction func onDetailsClick(_ sender: Any) {
        if delegate != nil {
            delegate.onDetails()
        }
    }
}

fileprivate extension ReservationCell {
    
    func prepareCardView() {
        cardView.layer.cornerRadius = 8
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.6
        cardView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        cardView.layer.shadowRadius = 1
    }
    
    func prepareImageView() {
        imageViewItem.clipsToBounds = true
        imageViewItem.roundCorners(corners: [.allCorners], radius: 4)
    }
    
    func preparePriceView() {
        priceView.roundCorners(corners: [.allCorners], radius: 4)
        priceView.backgroundColor = UIColor.iYellow
    }
    
    func prepareDirectionsButton() {
        let textString = NSMutableAttributedString(
            string: btnDirections.title(for: .normal)!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.black(with: 9),
                NSAttributedString.Key.foregroundColor: btnDirections.titleColor(for: .normal)!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 1.2, range: textRange)
        btnDirections.setAttributedTitle(textString, for: .normal)
        btnDirections.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func prepareDetailsButton() {
        let textString = NSMutableAttributedString(
            string: btnDetails.title(for: .normal)!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.black(with: 9),
                NSAttributedString.Key.foregroundColor: btnDetails.titleColor(for: .normal)!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 1.2, range: textRange)
        btnDetails.setAttributedTitle(textString, for: .normal)
        btnDetails.setImage(UIImage(named: "icon-details")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnDetails.tintColor = UIColor.iBlack90
        
        btnDetails.applyOutlinedTheme(withScheme: Global.tinyOutlinedButtonScheme())
        btnDetails.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        btnDetails.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
    }
    
    func prepareHoursImageView() {
        hoursImageView.image = hoursImageView.image?.withRenderingMode(.alwaysTemplate)
        hoursImageView.tintColor = UIColor.iBlack50
    }
    
    func prepareLocationImageView() {
        locationImageView.image = locationImageView.image?.withRenderingMode(.alwaysTemplate)
        locationImageView.tintColor = UIColor.iGray
    }
}
