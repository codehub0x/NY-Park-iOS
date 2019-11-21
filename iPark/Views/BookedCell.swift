//
//  BookedCell.swift
//  iPark
//
//  Created by King on 2019/11/22.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

class BookedCell: UICollectionViewCell {
    
    static let reuseIdentifier = "\(BookedCell.self)"
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
