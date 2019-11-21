//
//  SignupViewController.swift
//  iPark
//
//  Created by King on 2019/11/18.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class SignupViewController: UIViewController {
    
    static let storyboardId = "\(SignupViewController.self)"
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var termsBtn: FlatButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    fileprivate var mainStoryboard: UIStoryboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        adjustUIHeight()
        
        prepareTermsButton()
    }
    
    func adjustUIHeight() {
        let windowSize = UIScreen.main.bounds
        var topPadding: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            topPadding = window?.safeAreaInsets.top ?? 0
        }
        var height = windowSize.height - topPadding
        if height < 650 {
            height = 650
        }
        heightConstraint.constant = height
    }
    
    @IBAction func onCloseBtnClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onCreateAccountBtnClick(_ sender: Any) {
        let newVC: MenuViewController!
        if #available(iOS 13.0, *) {
            newVC = mainStoryboard.instantiateViewController(identifier: MenuViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            newVC = mainStoryboard.instantiateViewController(withIdentifier: MenuViewController.storyboardId) as? MenuViewController
        }
        
        Global.isLoggedIn = true
        
        let navVC = newVC.getNavigationController()
        navVC.modalPresentationStyle = .overFullScreen
        navVC.modalTransitionStyle = .crossDissolve
        
        self.present(navVC, animated: true)
    }
    
    @IBAction func onTermsBtnClick(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://ipark.com/terms-and-conditions/")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func onSigninBtnClick(_ sender: Any) {
        let newVC: UIViewController!
        if #available(iOS 13.0, *) {
            newVC = mainStoryboard.instantiateViewController(identifier: SigninViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            newVC = mainStoryboard.instantiateViewController(withIdentifier: SigninViewController.storyboardId)
        }
        newVC.modalPresentationStyle = .overFullScreen
        newVC.modalTransitionStyle = .flipHorizontal
        weak var pvc = self.presentingViewController
        self.dismiss(animated: true) {
            pvc?.present(newVC, animated: true)
        }
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
