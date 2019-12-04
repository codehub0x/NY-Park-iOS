//
//  SavedCell.swift
//  iPark
//
//  Created by King on 2019/11/16.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

protocol HomeCellDelegate {
    func onDetails()
    func onBook()
}

class HomeCell: UITableViewCell {
    
    static let reuseIdentifier = "\(HomeCell.self)"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var labelAddress: UIView!
    @IBOutlet weak var labelTitle: UIView!
    @IBOutlet weak var imageViewItem: UIImageView!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var btnBook: MDCButton!
    @IBOutlet weak var btnDetails: MDCButton!
    
    var delegate: HomeCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareCardView()
        prepareImageView()
        prepareLocationImageView()
        prepareBookButton()
        prepareDetailsButton()
    }
    
    @IBAction func onBookBtnClick(_ sender: Any) {
        if delegate != nil {
            delegate.onBook()
        }
    }
    
    @IBAction func onDetailsBtnClick(_ sender: Any) {
        if delegate != nil {
            delegate.onDetails()
        }
    }
}

fileprivate extension HomeCell {
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
    
    func prepareLocationImageView() {
        locationImageView.image = locationImageView.image?.withRenderingMode(.alwaysTemplate)
        locationImageView.tintColor = UIColor.iGray
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
        paragraphStyle.lineSpacing = 0
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 1.2, range: textRange)
        btnBook.setAttributedTitle(textString, for: .normal)
        btnBook.applyContainedTheme(withScheme: Global.tinyButtonScheme())
        btnBook.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
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
}
