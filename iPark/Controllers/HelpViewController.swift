//
//  HelpViewController.swift
//  iPark
//
//  Created by King on 2019/11/19.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material
import MessageUI

class HelpViewController: UIViewController {
    
    static let storyboardId = "\(HelpViewController.self)"
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var websiteImageView: UIImageView!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var rateImageView: UIImageView!
    @IBOutlet weak var faqImageView: UIImageView!
    @IBOutlet weak var termsBtn: FlatButton!
    @IBOutlet weak var privacyBtn: FlatButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    fileprivate var mainStoryboard: UIStoryboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        adjustUIHeight()
        
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
    
    func adjustUIHeight() {
        let windowSize = UIScreen.main.bounds
        var padding: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top ?? 0
            let bottomPadding = window?.safeAreaInsets.bottom ?? 0
            padding = topPadding + bottomPadding
        }
        var height = windowSize.height - padding
        if height < 650 {
            height = 650
        }
        heightConstraint.constant = height
    }
    
    @objc func onBackClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onWebsiteBtnClick(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://ipark.com/")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func onEmailBtnClick(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    @IBAction func onRateUsBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onFaqBtnClick(_ sender: Any) {
        let newVC: UIViewController!
        if #available(iOS 13.0, *) {
            newVC = mainStoryboard.instantiateViewController(identifier: FAQViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            newVC = mainStoryboard.instantiateViewController(withIdentifier: FAQViewController.storyboardId)
        }
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onPhoneBtnClick(_ sender: Any) {
        guard let url = URL(string: "tel://8554727569"),
            UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func onTermsBtnClick(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://ipark.com/terms-and-conditions/")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func onPrivacyBtnClick(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://ipark.com/privacy-policy/")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func onFacebookBtnClick(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.facebook.com/pages/IPark/606293799431302")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func onTwitterBtnClick(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://twitter.com/imperialparking")!, options: [:], completionHandler: nil)
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property

        mailComposerVC.setToRecipients(["info@ipark.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)

        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let alertController = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
}

extension HelpViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
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
