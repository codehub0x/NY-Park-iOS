//
//  HelpViewController.swift
//  iPark
//
//  Created by King on 2019/11/19.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class HelpViewController: UIViewController {
    
    static let storyboardId = "\(HelpViewController.self)"
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var websiteImageView: UIImageView!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var rateImageView: UIImageView!
    @IBOutlet weak var faqImageView: UIImageView!
    @IBOutlet weak var termsBtn: FlatButton!
    @IBOutlet weak var privacyBtn: FlatButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation()
        prepareMainView()
        prepareImageViews()
        prepareTermsBtn()
        preparePrivacyBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func onBackClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onWebsiteBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onEmailBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onRateUsBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onFaqBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onPhoneBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onTermsBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onPrivacyBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onFacebookBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onTwitterBtnClick(_ sender: Any) {
        
    }
}

fileprivate extension HelpViewController {
    func prepareNavigation() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "Help"
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func prepareMainView() {
        mainView.layer.cornerRadius = 6
        mainView.layer.borderColor = UIColor.iBlack70.cgColor
        mainView.layer.borderWidth = 0.5
        mainView.layer.masksToBounds = true
    }
    
    func prepareTermsBtn() {
        termsBtn.layer.cornerRadius = 6
        termsBtn.layer.borderColor = UIColor.iBlack70.cgColor
        termsBtn.layer.borderWidth = 0.5
        termsBtn.layer.masksToBounds = true
    }
    
    func preparePrivacyBtn() {
        privacyBtn.layer.cornerRadius = 6
        privacyBtn.layer.borderColor = UIColor.iBlack70.cgColor
        privacyBtn.layer.borderWidth = 0.5
        privacyBtn.layer.masksToBounds = true
    }
    
    func prepareImageViews() {
        websiteImageView.image = websiteImageView.image?.withRenderingMode(.alwaysTemplate)
        websiteImageView.tintColor = UIColor.iYellow
        
        emailImageView.image = emailImageView.image?.withRenderingMode(.alwaysTemplate)
        emailImageView.tintColor = UIColor.iYellow
        
        rateImageView.image = rateImageView.image?.withRenderingMode(.alwaysTemplate)
        rateImageView.tintColor = UIColor.iYellow
        
        faqImageView.image = faqImageView.image?.withRenderingMode(.alwaysTemplate)
        faqImageView.tintColor = UIColor.iYellow
    }
}
