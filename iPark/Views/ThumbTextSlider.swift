//
//  ThumbTextSlider.swift
//  iPark
//
//  Created by King on 2019/11/28.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

class ThumbTextSlider: UISlider {
    var label = UILabel()
    
    private var thumbFrame: CGRect {
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = thumbFrame
        label.text = Int(value).description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(label)
        label.textAlignment = .center
        label.layer.zPosition = layer.zPosition + 1
        label.textColor = .black
        label.font = LatoFont.regular(with: 14)
    }
}
