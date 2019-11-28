//
//  CustomAnnotationView.swift
//  iPark
//
//  Created by King on 2019/11/29.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotationView: MKAnnotationView {
    init(annotation: CustomAnnotation?) {
        super.init(annotation: annotation, reuseIdentifier: nil)
        
        // Set custom image
        self.image = UIImage(named: "ic_mark")
        
        // Set extra settings
        self.canShowCallout = false
        self.isEnabled = true
        
        // Add label
        let label = UILabel(frame: CGRect(x: 0, y: 7, width: 35, height: 20))
        label.font = LatoFont.bold(with: 14)
        label.textColor = UIColor.iDarkBlue
        label.textAlignment = .center
        label.text = annotation?.price ?? "$0"
        
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        // Set custom image
//        self.image = UIImage(named: "ic_mark")
//
//        // Set extra settings
//        self.canShowCallout = false
//        self.isEnabled = true
//
//        // Add label
//        let label = UILabel(frame: CGRect(x: 10, y: 0, width: 35, height: 20))
//        label.font = LatoFont.bold(with: 15)
//        label.textColor = UIColor.iDarkBlue
//        label.textAlignment = .center
//        label.text = price
//
//        self.addSubview(label)
//    }
}
