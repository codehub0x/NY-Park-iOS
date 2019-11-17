//
//  SavedCell.swift
//  iPark
//
//  Created by King on 2019/11/16.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

class SavedCell: UITableViewCell {
    
    static let reuseIdentifier = "\(ReservationCell.self)"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var labelLicense: UIView!
    @IBOutlet weak var labelAddress: UIView!
    @IBOutlet weak var labelTitle: UIView!
    @IBOutlet weak var imageViewItem: UIImageView!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var btnBook: UIButton!
    @IBOutlet weak var btnDetails: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareCardView()
        prepareImageView()
        prepareBookButton()
        prepareDetailsButton()
    }
    
    @IBAction func onStarBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onBookBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onDetailsBtnClick(_ sender: Any) {
        
    }
}

fileprivate extension SavedCell {
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
    
    func prepareBookButton() {
        let textString = NSMutableAttributedString(
            string: btnBook.title(for: .normal)!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.black(with: 9),
                NSAttributedString.Key.foregroundColor: btnBook.titleColor(for: .normal)!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.28
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 0, range: textRange)
        btnBook.setAttributedTitle(textString, for: .normal)
        btnBook.layer.cornerRadius = 2
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
