//
//  SigninViewController.swift
//  iPark
//
//  Created by King on 2019/11/18.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class SigninViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var closeBtn: FlatButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareCloseButton()
    }
    
    @IBAction func onCloseBtnClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onSigninBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onForgotPasswordBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onRegisterBtnClick(_ sender: Any) {
        
    }
    
}


fileprivate extension SigninViewController {
    func prepareCloseButton() {
        closeBtn.setImage(UIImage(named: "icon-close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeBtn.tintColor = UIColor.iBlack90
    }
}
