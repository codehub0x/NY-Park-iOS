//
//  BookView.swift
//  iPark
//
//  Created by King on 2019/11/20.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

protocol BookCellDelegate {
    func onItemClick(_ indexPath: IndexPath)
}

class BookCell: UICollectionViewCell {
    
    static let reuseIdentifier = "\(BookCell.self)"
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    open var indexPath: IndexPath!
    open var delegate: BookCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareButton()
    }
    
    @IBAction func onButtonClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate.onItemClick(indexPath)
    }
    
    func configure(_ item: [String: Any], indexPath: IndexPath) {
        self.indexPath = indexPath
        let date = item["date"] as! Date
        let formatter = DateFormatter()
        
        // Get Date value from date object
        formatter.dateFormat = "d"
        dateLabel.text = formatter.string(from: date)
        
        // Get Day value from date object
        formatter.dateFormat = "E"
        let dayString = formatter.string(from: date)
        dayLabel.text = dayString[safe: 0]?.string
        
        button.setTitle(item["value"] as? String, for: .normal)
        button.isEnabled = item["valid"] as! Bool
    }
}

fileprivate extension BookCell {
    func prepareButton() {
        // Set button radius & border
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.iBlack70.cgColor
        button.layer.masksToBounds = true
        
        // Set button background color
        button.setBackgroundColor(.white, forState: .normal)
        button.setBackgroundColor(.iDarkBlue, forState: .selected)
        button.setBackgroundColor(.iBlack40, forState: .disabled)
        
        // Set button title color
        button.setTitleColor(.iDarkBlue, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.setTitleColor(.iBlack80, for: .disabled)
    }
}
