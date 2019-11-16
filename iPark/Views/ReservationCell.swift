//
//  ItemView.swift
//  iPark
//
//  Created by King on 2019/11/14.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

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
    @IBOutlet weak var btnDirections: UIButton!
    @IBOutlet weak var btnDetails: UIButton!
    @IBOutlet weak var labelDistance: UILabel!
    
    var reservationType: ReservationType = .upcoming {
        didSet {
            switch reservationType {
            case .upcoming:
                btnDirections.setTitle("DIRECTIONS", for: .normal)
                btnDirections.setImage(nil, for: .normal)
                btnDirections.backgroundColor = UIColor.iDarkBlue
                btnDirections.tintColor = UIColor.white
                btnDirections.setTitleColor(UIColor.white, for: .normal)
                
                priceView.backgroundColor = UIColor.iYellow
                labelPrice.textColor = UIColor.iDarkBlue
                labelFlag.isHidden = true
                break
            case .past:
                btnDirections.setTitle("REBOOK", for: .normal)
                btnDirections.setImage(UIImage(systemName: "arrow.2.circlepath"), for: .normal)
                btnDirections.backgroundColor = UIColor.iYellow
                btnDirections.tintColor = UIColor.iDarkBlue
                btnDirections.setTitleColor(UIColor.iDarkBlue, for: .normal)
                
                priceView.backgroundColor = UIColor.iDarkBlue
                labelPrice.textColor = UIColor.white
                labelFlag.isHidden = false
                break
            case .cancelled:
                btnDirections.setTitle("DIRECTIONS", for: .normal)
                btnDirections.setImage(nil, for: .normal)
                btnDirections.backgroundColor = UIColor.iDarkBlue
                btnDirections.tintColor = UIColor.white
                btnDirections.setTitleColor(UIColor.white, for: .normal)
                
                priceView.backgroundColor = UIColor.iYellow
                labelPrice.textColor = UIColor.iDarkBlue
                labelFlag.isHidden = true
                break
            }

            prepareDirectionsButtons()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareCardView()
        prepareImageView()
        preparePriceView()
        prepareDetailsButton()
    }
    
    @IBAction func onDirectionsClick(_ sender: Any) {
        
    }
    
    @IBAction func onDetailsClick(_ sender: Any) {
        
    }
}

fileprivate extension ReservationCell {
    
    func prepareCardView() {
        cardView.layer.cornerRadius = 8
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.6
        cardView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cardView.layer.shadowRadius = 2
    }
    
    func prepareImageView() {
        imageViewItem.clipsToBounds = true
        imageViewItem.roundCorners(corners: [.allCorners], radius: 4)
    }
    
    func preparePriceView() {
        priceView.roundCorners(corners: [.allCorners], radius: 4)
        priceView.backgroundColor = UIColor.iYellow
    }
    
    func prepareDirectionsButtons() {
        let textString = NSMutableAttributedString(
            string: btnDirections.title(for: .normal)!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.black(with: 9),
                NSAttributedString.Key.foregroundColor: btnDirections.titleColor(for: .normal)!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.28
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 0, range: textRange)
        btnDirections.setAttributedTitle(textString, for: .normal)
        btnDirections.layer.cornerRadius = 2
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
        paragraphStyle.lineSpacing = 1.28
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 0, range: textRange)
        btnDetails.setAttributedTitle(textString, for: .normal)
        btnDetails.layer.borderWidth = 1
        btnDetails.layer.cornerRadius = 2
        btnDetails.layer.borderColor = UIColor.iBlack70.cgColor
    }
}
