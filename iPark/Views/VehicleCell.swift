//
//  VehicleCell.swift
//  iPark
//
//  Created by King on 2019/11/20.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

protocol VehicleCellDelegate {
    func onEdit(_ item: [String: String])
}

class VehicleCell: UITableViewCell {
    
    static let reuseIdentifier = "\(VehicleCell.self)"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var labelMake: UILabel!
    @IBOutlet weak var labelModel: UILabel!
    @IBOutlet weak var labelDetails: UILabel!
    
    var delegate: VehicleCellDelegate!
    var item: [String: String]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareCardView()
    }
    
    func configure(_ item: [String: String]) {
        self.item = item
        
        labelMake.text = item["make"]
        labelModel.text = item["model"]
        labelDetails.text = "Color: \(item["color"] ?? "---"), Plate: \(item["plate"] ?? "---")"
    }
    
    @IBAction func onEditBtnClick(_ sender: Any) {
        delegate.onEdit(item)
    }
}

fileprivate extension VehicleCell {
    func prepareCardView() {
        cardView.layer.cornerRadius = 6
        cardView.layer.borderColor = UIColor.iBlack70.cgColor
        cardView.layer.borderWidth = 0.5
        cardView.layer.masksToBounds = true
    }
}
