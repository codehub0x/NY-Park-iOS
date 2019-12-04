//
//  MenuViewController.swift
//  iPark
//
//  Created by King on 2019/11/14.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

class MenuViewController: UIViewController {
    
    static let storyboardId = "\(MenuViewController.self)"
    
    @IBOutlet weak var overlapView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    /// Before Login
    @IBOutlet weak var infoView1: UIView!
    @IBOutlet weak var iParkView: UIView!
    @IBOutlet weak var rightArrowImageView: UIImageView!
    
    /// After Login
    @IBOutlet weak var infoView2: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var slider: ThumbTextSlider!
    /// Rewards Points
    @IBOutlet weak var rewardsView: UIView!
    @IBOutlet weak var labelRewardsPoint: UILabel!
    @IBOutlet weak var labelRewardsTotal: UILabel!
    /// Upcoming Reservations
    @IBOutlet weak var upcomingView: UIView!
    @IBOutlet weak var labelUpcompings: UILabel!
    /// Saved Locations
    @IBOutlet weak var savedView: UIView!
    @IBOutlet weak var labelSavedLocations: UILabel!
    @IBOutlet weak var labelSavedTotal: UILabel!
    /// My Vehicles
    @IBOutlet weak var vehiclesView: UIView!
    @IBOutlet weak var labelVehicles: UILabel!
    @IBOutlet weak var labelVehiclesTotal: UILabel!
    
    @IBOutlet weak var btnClose: MDCButton!
    @IBOutlet weak var btnMonthlyParking: MDCButton!
    @IBOutlet weak var btnFAQ: MDCButton!
    @IBOutlet weak var btnPromoCodes: MDCButton!
    @IBOutlet weak var btnHelp: MDCButton!
    /// If logged in, "My Account", else "Create Account"
    @IBOutlet weak var button1: MDCButton!
    /// If logged in, "Logout", else "Login"
    @IBOutlet weak var button2: MDCButton!
    /// App version
    @IBOutlet weak var labelVersion: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    fileprivate var mainStoryboard: UIStoryboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        prepareMainView()
        prepareOverlapView()
        
        if Global.isLoggedIn {
            topViewHeight.constant = 360
            infoView1.isHidden = true
            infoView2.isHidden = false
            
            button1.setTitle("My Account", for: .normal)
            button2.setTitle("Logout", for: .normal)
            
            prepareInfoView()
            prepareButtons()
        } else {
            topViewHeight.constant = 190
            infoView1.isHidden = false
            infoView2.isHidden = true
            
            button1.setTitle("Create Account", for: .normal)
            button2.setTitle("Login", for: .normal)
            
            prepareiParkView()
            prepareButtons()
        }
        
        labelVersion.text = "App Version: \(getVersion())"
        adjustUIHeight()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func adjustUIHeight() {
        let windowSize = UIScreen.main.bounds
        var topPadding: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            topPadding = window?.safeAreaInsets.top ?? 0
        }
        var height = windowSize.height - topPadding
        if Global.isLoggedIn {
            if height < 850 {
                height = 850
            }
        } else {
            if height < 680 {
                height = 680
            }
        }
        
        heightConstraint.constant = height
    }
    
    @objc func onClose() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            self.mainView.transform = CGAffineTransform(translationX: 300, y: 0)
        }) { _ in
            self.view.window?.rootViewController?.dismiss(animated: true)
        }
    }
    
    /// IBActions
    @IBAction func onCloseClick(_ sender: Any) {
        onClose()
    }
    
    @IBAction func oniParkBtnClick(_ sender: Any) {
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: RewardsViewController.storyboardId)
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onRewardsBtnClick(_ sender: Any) {
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: RewardsViewController.storyboardId)
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onUpcomingBtnClick(_ sender: Any) {
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: ReservationsViewController.storyboardId)
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onSavedLocationsBtnClick(_ sender: Any) {
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: SavedViewController.storyboardId)
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onVehiclesBtnClick(_ sender: Any) {
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: VehiclesViewController.storyboardId)
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onMonthlyParkingBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onFAQBtnClick(_ sender: Any) {
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: FAQViewController.storyboardId)
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onPromoCodeBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onHelpBtnClick(_ sender: Any) {
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: HelpViewController.storyboardId)
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onBtn1Click(_ sender: Any) {
        if Global.isLoggedIn {
            /// Go to the AccountViewController
            let newVC = mainStoryboard.instantiateViewController(withIdentifier: AccountViewController.storyboardId)
            self.navigationController?.pushViewController(newVC, animated: true)
        } else {
            /// Go to the SignupViewController
            let newVC = mainStoryboard.instantiateViewController(withIdentifier: SignupViewController.storyboardId)
            newVC.modalPresentationStyle = .overFullScreen
            newVC.modalTransitionStyle = .flipHorizontal
            self.present(newVC, animated: true)
        }
    }
    
    @IBAction func onBtn2Click(_ sender: Any) {
        if Global.isLoggedIn {
            /// Call Logout function
            Global.isLoggedIn = false
            self.view.window?.rootViewController?.dismiss(animated: true)
        } else {
            /// Go to the SigninViewController
            let newVC = mainStoryboard.instantiateViewController(withIdentifier: SigninViewController.storyboardId)
            newVC.modalPresentationStyle = .overFullScreen
            newVC.modalTransitionStyle = .flipHorizontal
            self.present(newVC, animated: true)
        }
    }
}

fileprivate extension MenuViewController {
    func prepareMainView() {
        mainView.transform = CGAffineTransform(translationX: 300, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            self.mainView.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    
    func prepareOverlapView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClose))
        overlapView.isUserInteractionEnabled = true
        overlapView.addGestureRecognizer(tapGesture)
    }
    
    func prepareiParkView() {
        iParkView.layer.cornerRadius = 8
        iParkView.layer.borderWidth = 1
        iParkView.layer.borderColor = UIColor.iYellow.cgColor
        iParkView.layer.masksToBounds = true
        rightArrowImageView.image = rightArrowImageView.image?.withRenderingMode(.alwaysTemplate)
        rightArrowImageView.tintColor = UIColor.iYellow
    }
    
    func prepareAvatarImageView() {
        avatarImageView.layer.cornerRadius = 34
        avatarImageView.layer.masksToBounds = true
    }
    
    func prepareRewardsView() {
        rewardsView.layer.cornerRadius = 6
        rewardsView.layer.borderWidth = 1
        rewardsView.layer.borderColor = UIColor.white.cgColor
        rewardsView.layer.masksToBounds = true
    }
    
    func prepareUpcomingView() {
        upcomingView.layer.cornerRadius = 6
        upcomingView.layer.borderWidth = 1
        upcomingView.layer.borderColor = UIColor.white.cgColor
        upcomingView.layer.masksToBounds = true
    }
    
    func prepareSavedLocationView() {
        savedView.layer.cornerRadius = 6
        savedView.layer.borderWidth = 1
        savedView.layer.borderColor = UIColor.white.cgColor
        savedView.layer.masksToBounds = true
    }
    
    func prepareVehiclesView() {
        vehiclesView.layer.cornerRadius = 6
        vehiclesView.layer.borderWidth = 1
        vehiclesView.layer.borderColor = UIColor.white.cgColor
        vehiclesView.layer.masksToBounds = true
    }
    
    func prepareInfoView() {
        prepareAvatarImageView()
        prepareRewardsView()
        prepareUpcomingView()
        prepareSavedLocationView()
        prepareVehiclesView()
    }
    
    func prepareButtons() {
        let textScheme = Global.textButtonScheme()
        btnClose.applyTextTheme(withScheme: textScheme)
        btnClose.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        textScheme.colorScheme.primaryColor = .iDarkBlue
        textScheme.typographyScheme.button = LatoFont.regular(with: 19)
        
        let edgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        btnMonthlyParking.applyTextTheme(withScheme: textScheme)
        btnMonthlyParking.contentEdgeInsets = edgeInsets
        
        btnFAQ.applyTextTheme(withScheme: textScheme)
        btnFAQ.contentEdgeInsets = edgeInsets
        
        btnPromoCodes.applyTextTheme(withScheme: textScheme)
        btnPromoCodes.contentEdgeInsets = edgeInsets
        
        btnHelp.applyTextTheme(withScheme: textScheme)
        btnHelp.contentEdgeInsets = edgeInsets
        
        button1.applyOutlinedTheme(withScheme: Global.outlinedButtonScheme())
        button1.isUppercaseTitle = false
        
        button2.applyOutlinedTheme(withScheme: Global.outlinedButtonScheme())
        button2.isUppercaseTitle = false
    }
    
    func getVersion() -> String {
        let versionNumber = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        if let versionNumber = versionNumber, let buildNumber = buildNumber {
            return "v\(versionNumber).\(buildNumber)"
        } else if let versionNumber = versionNumber {
          return "v\(versionNumber)"
        } else if let buildNumber = buildNumber {
          return "v1.0.\(buildNumber)"
        } else {
          return "v1.0"
        }
    }
    
}
