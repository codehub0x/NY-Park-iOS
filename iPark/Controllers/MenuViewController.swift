//
//  MenuViewController.swift
//  iPark
//
//  Created by King on 2019/11/14.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var overlapView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overlapView.isUserInteractionEnabled = true
        overlapView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(onOverlapViewClick)))
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc private func onOverlapViewClick() {
        self.dismiss(animated: true)
    }
}
