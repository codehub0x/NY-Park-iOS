//
//  VehiclesViewController.swift
//  iPark
//
//  Created by King on 2019/11/20.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class VehiclesViewController: UIViewController {
    
    static let storyboardId = "\(VehiclesViewController.self)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func onBackClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

fileprivate extension VehiclesViewController {
    func prepareNavigation() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "Vehicles"
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
    }
}
