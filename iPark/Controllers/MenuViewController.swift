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
    
    static let storyboardId = "\(MenuViewController.self)"
    
    @IBOutlet weak var overlapView: UIView!
    @IBOutlet weak var closeBtn: FlatButton!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    /// Before Login
    @IBOutlet weak var infoView1: UIView!
    @IBOutlet weak var iParkView: UIView!
    @IBOutlet weak var rightArrowImageView: UIImageView!
    
    /// After Login
    @IBOutlet weak var infoView2: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
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
    
    /// If logged in, "My Account", else "Create Account"
    @IBOutlet weak var button1: FlatButton!
    /// If logged in, "Logout", else "Login"
    @IBOutlet weak var button2: FlatButton!
    /// App version
    @IBOutlet weak var labelVersion: UILabel!
    
    fileprivate var mainStoryboard: UIStoryboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        prepareCloseButton()
        
        if Global.isLoggedIn {
            topViewHeight.constant = 360
            infoView1.isHidden = true
            infoView2.isHidden = false
            
            button1.setTitle("My Account", for: .normal)
            button2.setTitle("Logout", for: .normal)
            
            prepareInfoView()
            prepareButton1()
            prepareButton2()
        } else {
            topViewHeight.constant = 190
            infoView1.isHidden = false
            infoView2.isHidden = true
            
            button1.setTitle("Create Account", for: .normal)
            button2.setTitle("Login", for: .normal)
            
            prepareiParkView()
            prepareButton1()
            prepareButton2()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    /// IBActions
    @IBAction func onClose(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    @IBAction func oniParkBtnClick(_ sender: Any) {
        let newVC: UIViewController!
        if #available(iOS 13.0, *) {
            newVC = mainStoryboard.instantiateViewController(identifier: RewardsViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            newVC = mainStoryboard.instantiateViewController(withIdentifier: RewardsViewController.storyboardId)
        }
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onRewardsBtnClick(_ sender: Any) {
        let newVC: UIViewController!
        if #available(iOS 13.0, *) {
            newVC = mainStoryboard.instantiateViewController(identifier: RewardsViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            newVC = mainStoryboard.instantiateViewController(withIdentifier: RewardsViewController.storyboardId)
        }
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onUpcomingBtnClick(_ sender: Any) {
        let newVC: UIViewController!
        if #available(iOS 13.0, *) {
            newVC = mainStoryboard.instantiateViewController(identifier: ReservationsViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            newVC = mainStoryboard.instantiateViewController(withIdentifier: ReservationsViewController.storyboardId)
        }
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onSavedLocationsBtnClick(_ sender: Any) {
        let newVC: UIViewController!
        if #available(iOS 13.0, *) {
            newVC = mainStoryboard.instantiateViewController(identifier: SavedViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            newVC = mainStoryboard.instantiateViewController(withIdentifier: SavedViewController.storyboardId)
        }
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onVehiclesBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onMonthlyParkingBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onFAQBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onPromoCodeBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onHelpBtnClick(_ sender: Any) {
        let newVC: UIViewController!
        if #available(iOS 13.0, *) {
            newVC = mainStoryboard.instantiateViewController(identifier: HelpViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            newVC = mainStoryboard.instantiateViewController(withIdentifier: HelpViewController.storyboardId)
        }
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onBtn1Click(_ sender: Any) {
        if Global.isLoggedIn {
            /// Go to the AccountViewController
        } else {
            /// Go to the SignupViewController
            let newVC: UIViewController!
            if #available(iOS 13.0, *) {
                newVC = mainStoryboard.instantiateViewController(identifier: SignupViewController.storyboardId)
            } else {
                // Fallback on earlier versions
                newVC = mainStoryboard.instantiateViewController(withIdentifier: SignupViewController.storyboardId)
            }
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
            let newVC: UIViewController!
            if #available(iOS 13.0, *) {
                newVC = mainStoryboard.instantiateViewController(identifier: SigninViewController.storyboardId)
            } else {
                // Fallback on earlier versions
                newVC = mainStoryboard.instantiateViewController(withIdentifier: SigninViewController.storyboardId)
            }
            newVC.modalPresentationStyle = .overFullScreen
            newVC.modalTransitionStyle = .flipHorizontal
            self.present(newVC, animated: true)
        }
    }
}

fileprivate extension MenuViewController {
    func prepareCloseButton() {
        closeBtn.setImage(UIImage(named: "icon-close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeBtn.tintColor = UIColor.white
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
    
    func prepareButton1() {
        button1.layer.cornerRadius = 6
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.iBlack50.cgColor
        button1.layer.masksToBounds = true
    }
    
    func prepareButton2() {
        button2.layer.cornerRadius = 6
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.iBlack50.cgColor
        button2.layer.masksToBounds = true
    }
    
}
