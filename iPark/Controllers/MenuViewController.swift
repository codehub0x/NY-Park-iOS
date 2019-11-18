//
//  MenuViewController.swift
//  iPark
//
//  Created by King on 2019/11/14.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class MenuViewController: UIViewController {
    
    @IBOutlet weak var overlapView: UIView!
    @IBOutlet weak var closeBtn: FlatButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareCloseButton()
        
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

fileprivate extension MenuViewController {
    func prepareCloseButton() {
        closeBtn.setImage(UIImage(named: "icon-close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeBtn.tintColor = UIColor.white
    }
}
