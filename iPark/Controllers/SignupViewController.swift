//
//  SignupViewController.swift
//  iPark
//
//  Created by King on 2019/11/18.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var termsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTermsButton()
    }
    
    @IBAction func onCloseBtnClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onCreateAccountBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onTermsBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onSigninBtnClick(_ sender: Any) {
        
    }
    
}

fileprivate extension SignupViewController {
    func prepareTermsButton() {
        let attrs = [
            NSAttributedString.Key.font: LatoFont.regular(with: 11),
            NSAttributedString.Key.foregroundColor: UIColor.iBlack50,
            NSAttributedString.Key.underlineStyle: 1
            ] as [NSAttributedString.Key : Any]
        
        let btnTitleStr = NSMutableAttributedString(string: "Terms", attributes: attrs)
        termsBtn.setAttributedTitle(btnTitleStr, for: .normal)
    }
}
