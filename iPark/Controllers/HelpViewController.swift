//
//  HelpViewController.swift
//  iPark
//
//  Created by King on 2019/11/19.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import MessageUI

class HelpViewController: UIViewController {
    
    static let storyboardId = "\(HelpViewController.self)"
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var websiteImageView: UIImageView!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var rateImageView: UIImageView!
    @IBOutlet weak var faqImageView: UIImageView!
    @IBOutlet weak var btnWebsite: MDCButton!
    @IBOutlet weak var btnEmailUs: MDCButton!
    @IBOutlet weak var btnRateUs: MDCButton!
    @IBOutlet weak var btnFAQ: MDCButton!
    @IBOutlet weak var btnCall: MDCButton!
    @IBOutlet weak var btnTerms: MDCButton!
    @IBOutlet weak var btnPrivacy: MDCButton!
    @IBOutlet weak var btnFacebook: MDCButton!
    @IBOutlet weak var btnTwitter: MDCButton!
    @IBOutlet weak var imgTermsArrow: UIImageView!
    @IBOutlet weak var imgPrivacyArrow: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    fileprivate var mainStoryboard: UIStoryboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        adjustUIHeight()
        
        prepareNavigation()
        prepareMainView()
        prepareImageViews()
        prepareButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func adjustUIHeight() {
        let windowSize = UIScreen.main.bounds
        var padding: CGFloat = topbarHeight
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let bottomPadding = window?.safeAreaInsets.bottom ?? 0
            padding = padding + bottomPadding
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
        openURL(url: URL(string: "https://ipark.com/"))
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
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: FAQViewController.storyboardId)
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onPhoneBtnClick(_ sender: Any) {
        openURL(url: URL(string: "tel://8554727569"))
    }
    
    @IBAction func onTermsBtnClick(_ sender: Any) {
        openURL(url: URL(string: "https://ipark.com/terms-and-conditions/"))
    }
    
    @IBAction func onPrivacyBtnClick(_ sender: Any) {
        openURL(url: URL(string: "https://ipark.com/privacy-policy/"))
    }
    
    @IBAction func onFacebookBtnClick(_ sender: Any) {
        openURL(url: URL(string: "https://www.facebook.com/pages/IPark/606293799431302"))
    }
    
    @IBAction func onTwitterBtnClick(_ sender: Any) {
        openURL(url: URL(string: "https://twitter.com/imperialparking"))
    }
    
    func openURL(url: URL?) {
        guard let url = url,
            UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
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
    
    func prepareButtons() {
        let topEdgeInsets = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        let leftEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        let textScheme = Global.textButtonScheme()
        textScheme.colorScheme.primaryColor = .iBlackBlue
        textScheme.typographyScheme.button = LatoFont.regular(with: 17)
        
        btnWebsite.applyTextTheme(withScheme: textScheme)
        btnWebsite.isUppercaseTitle = false
        btnWebsite.contentEdgeInsets = topEdgeInsets
        
        btnEmailUs.applyTextTheme(withScheme: textScheme)
        btnEmailUs.isUppercaseTitle = false
        btnEmailUs.contentEdgeInsets = topEdgeInsets
        
        btnRateUs.applyTextTheme(withScheme: textScheme)
        btnRateUs.isUppercaseTitle = false
        btnRateUs.contentEdgeInsets = topEdgeInsets
        
        btnFAQ.applyTextTheme(withScheme: textScheme)
        btnFAQ.isUppercaseTitle = false
        btnFAQ.contentEdgeInsets = topEdgeInsets
        
        btnCall.applyContainedTheme(withScheme: Global.defaultButtonScheme())
        
        let outlinedScheme = Global.outlinedButtonScheme()
        outlinedScheme.colorScheme.primaryColor = .iDarkBlue
        outlinedScheme.colorScheme.backgroundColor = .white
        outlinedScheme.typographyScheme.button = LatoFont.regular(with: 19)
        
        btnTerms.applyOutlinedTheme(withScheme: outlinedScheme)
        btnTerms.isUppercaseTitle = false
        btnTerms.contentEdgeInsets = leftEdgeInsets
        
        btnPrivacy.applyOutlinedTheme(withScheme: outlinedScheme)
        btnPrivacy.isUppercaseTitle = false
        btnPrivacy.contentEdgeInsets = leftEdgeInsets
        
        btnFacebook.applyTextTheme(withScheme: Global.textButtonScheme())
        btnFacebook.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        btnTwitter.applyTextTheme(withScheme: Global.textButtonScheme())
        btnTwitter.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func prepareImageViews() {
        websiteImageView.image = websiteImageView.image?.withRenderingMode(.alwaysTemplate)
        websiteImageView.tintColor = .iYellow
        
        emailImageView.image = emailImageView.image?.withRenderingMode(.alwaysTemplate)
        emailImageView.tintColor = .iYellow
        
        rateImageView.image = rateImageView.image?.withRenderingMode(.alwaysTemplate)
        rateImageView.tintColor = .iYellow
        
        faqImageView.image = faqImageView.image?.withRenderingMode(.alwaysTemplate)
        faqImageView.tintColor = .iYellow
        
        imgTermsArrow.image = imgTermsArrow.image?.withRenderingMode(.alwaysTemplate)
        imgTermsArrow.tintColor = .iDarkBlue
        
        imgPrivacyArrow.image = imgPrivacyArrow.image?.withRenderingMode(.alwaysTemplate)
        imgPrivacyArrow.tintColor = .iDarkBlue
    }
}
