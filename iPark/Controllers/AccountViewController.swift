//
//  AccountViewController.swift
//  iPark
//
//  Created by King on 2019/11/20.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class AccountViewController: UIViewController {
    
    static let storyboardId = "\(AccountViewController.self)"
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameField: TextField!
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var phoneField: TextField!
    @IBOutlet weak var passwordField: TextField!
    @IBOutlet weak var repeatField: TextField!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation()
        prepareInfoView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func onBackClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onAvatarClick(_ sender: Any) {
        
    }
    
    @IBAction func onSaveBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onPaymentBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onValueChanged(_ sender: Any) {
        
    }
}

fileprivate extension AccountViewController {
    func prepareNavigation() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "Account"
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func prepareInfoView() {
        infoView.layer.cornerRadius = 8
        infoView.layer.borderColor = UIColor.iBlack70.cgColor
        infoView.layer.borderWidth = 0.5
        infoView.layer.masksToBounds = true
    }
}

