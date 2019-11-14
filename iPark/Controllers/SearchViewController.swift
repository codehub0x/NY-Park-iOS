//
//  SearchViewController.swift
//  iPark
//
//  Created by King on 2019/11/14.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class SearchViewController: UIViewController {
    
    fileprivate var buttons = [TabItem]()
    fileprivate var selectedTag = 1
    
    @IBOutlet weak var tabBar: TabBar!
    @IBOutlet weak var dailyView: UIView!
    @IBOutlet weak var monthlyView: UIView!
    @IBOutlet weak var addressField: TextField!
    @IBOutlet weak var startTimeField: TextField!
    @IBOutlet weak var endTimeField: TextField!
    @IBOutlet weak var mAddressField: TextField!
    @IBOutlet weak var mStartTimeField: TextField!
    @IBOutlet weak var dailySearchButton: FlatButton!
    @IBOutlet weak var monthlySearchButton: FlatButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation()
        prepareButtons()
        prepareTabBar()
        
        prepareAddressField()
        prepareStartTimeField()
        prepareEndTimeField()
        
        prepareMAddressField()
        prepareMStartTimeField()
        
        prepareSearchButton()
        
    }
    
    @objc fileprivate func onBackClick() {
        self.dismiss(animated: true)
    }
    
    @IBAction onDailySearchClick(_ sender: Any) {
        
    }
    
    @IBAction onMonthlySearchClick(_ sender: Any) {
        
    }
    
}

fileprivate extension SearchViewController {
    func prepareNavigation() {
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(onBackClick))
        leftButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: LatoFont.bold(with: 20)]
    }
    
    func prepareButtons() {
        let btn1 = TabItem(title: "Daily", titleColor: Color.white)
        btn1.pulseAnimation = .centerRadialBeyondBounds
        btn1.setTabItemColor(UIColor.iYellow, for: .selected)
        btn1.setTabItemColor(UIColor.white, for: .normal)
        btn1.titleLabel?.font = LatoFont.bold(with: 15)
        btn1.tag = 1
        buttons.append(btn1)
       
        let btn2 = TabItem(title: "Monthly", titleColor: Color.white)
        btn2.pulseAnimation = .centerRadialBeyondBounds
        btn2.setTabItemColor(UIColor.iYellow, for: .selected)
        btn2.setTabItemColor(UIColor.white, for: .normal)
        btn2.titleLabel?.font = LatoFont.bold(with: 15)
        btn2.tag = 2
        buttons.append(btn2)
    }
    
    func prepareTabBar() {
        tabBar.delegate = self
        
        tabBar.dividerColor = UIColor.iBlack80
        tabBar.dividerAlignment = .top
        tabBar.dividerThickness = 0.3
        
        tabBar.lineColor = UIColor.iYellow
        tabBar.lineAlignment = .bottom
        tabBar.lineHeight = 4
        
        tabBar.tabItems = buttons
    }
    
    func prepareAddressField() {
        addressField.placeholder = "Enter Address, Venue, or Airport"
        addressField.placeholderLabel.font = LatoFont.regular(with: 15)
        addressField.placeholderActiveScale = 0.7
        addressField.placeholderNormalColor = UIColor.iBlack50
        addressField.placeholderActiveColor = UIColor.iBlack50
        
        addressField.isClearIconButtonEnabled = true
        addressField.font = LatoFont.regular(with: 15)
        addressField.textColor = UIColor.black
        addressField.textInsets = EdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        addressField.dividerNormalHeight = 1
        addressField.dividerActiveHeight = 2
        addressField.dividerNormalColor = UIColor.iBlack50
        addressField.dividerActiveColor = UIColor.iDarkBlue
        
        let leftView = UIImageView()
        leftView.image = UIImage(systemName: "magnifyingglass")
        addressField.leftView = leftView
        addressField.leftViewOffset = -8
        addressField.leftViewNormalColor = UIColor.iBlack50
        addressField.leftViewActiveColor = UIColor.iDarkBlue
    }
    
    func prepareStartTimeField() {
        startTimeField.placeholder = "Start Time"
        startTimeField.placeholderLabel.font = LatoFont.regular(with: 15)
        startTimeField.placeholderActiveScale = 0.7
        startTimeField.placeholderNormalColor = UIColor.iBlack50
        startTimeField.placeholderActiveColor = UIColor.iBlack50
        
        startTimeField.isClearIconButtonEnabled = true
        startTimeField.font = LatoFont.regular(with: 15)
        startTimeField.textColor = UIColor.black
        startTimeField.textInsets = EdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        startTimeField.dividerNormalHeight = 1
        startTimeField.dividerActiveHeight = 2
        startTimeField.dividerNormalColor = UIColor.iBlack50
        startTimeField.dividerActiveColor = UIColor.iDarkBlue
        
        let leftView = UIImageView()
        leftView.image = UIImage(systemName: "clock")
        startTimeField.leftView = leftView
        startTimeField.leftViewOffset = -8
        startTimeField.leftViewNormalColor = UIColor.iBlack50
        startTimeField.leftViewActiveColor = UIColor.iDarkBlue
    }
    
    func prepareEndTimeField() {
        endTimeField.placeholder = "End Time"
        endTimeField.placeholderLabel.font = LatoFont.regular(with: 15)
        endTimeField.placeholderActiveScale = 0.7
        endTimeField.placeholderNormalColor = UIColor.iBlack50
        endTimeField.placeholderActiveColor = UIColor.iBlack50
        
        endTimeField.isClearIconButtonEnabled = true
        endTimeField.font = LatoFont.regular(with: 15)
        endTimeField.textColor = UIColor.black
        endTimeField.textInsets = EdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        endTimeField.dividerNormalHeight = 1
        endTimeField.dividerActiveHeight = 2
        endTimeField.dividerNormalColor = UIColor.iBlack50
        endTimeField.dividerActiveColor = UIColor.iDarkBlue
        
        let leftView = UIImageView()
        leftView.image = UIImage(systemName: "clock")
        endTimeField.leftView = leftView
        endTimeField.leftViewOffset = -8
        endTimeField.leftViewNormalColor = UIColor.iBlack50
        endTimeField.leftViewActiveColor = UIColor.iDarkBlue
    }
    
    func prepareMAddressField() {
        mAddressField.placeholder = "Enter Address, Venue, or Airport"
        mAddressField.placeholderLabel.font = LatoFont.regular(with: 15)
        mAddressField.placeholderActiveScale = 0.7
        mAddressField.placeholderNormalColor = UIColor.iBlack50
        mAddressField.placeholderActiveColor = UIColor.iBlack50
        
        mAddressField.isClearIconButtonEnabled = true
        mAddressField.font = LatoFont.regular(with: 15)
        mAddressField.textColor = UIColor.black
        mAddressField.textInsets = EdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        mAddressField.dividerNormalHeight = 1
        mAddressField.dividerActiveHeight = 2
        mAddressField.dividerNormalColor = UIColor.iBlack50
        mAddressField.dividerActiveColor = UIColor.iDarkBlue
        
        let leftView = UIImageView()
        leftView.image = UIImage(systemName: "magnifyingglass")
        mAddressField.leftView = leftView
        mAddressField.leftViewOffset = -8
        mAddressField.leftViewNormalColor = UIColor.iBlack50
        mAddressField.leftViewActiveColor = UIColor.iDarkBlue
    }
    
    func prepareMStartTimeField() {
        mStartTimeField.placeholder = "Start Parking On"
        mStartTimeField.placeholderLabel.font = LatoFont.regular(with: 15)
        mStartTimeField.placeholderActiveScale = 0.7
        mStartTimeField.placeholderNormalColor = UIColor.iBlack50
        mStartTimeField.placeholderActiveColor = UIColor.iBlack50
        
        mStartTimeField.isClearIconButtonEnabled = true
        mStartTimeField.font = LatoFont.regular(with: 15)
        mStartTimeField.textColor = UIColor.black
        mStartTimeField.textInsets = EdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        mStartTimeField.dividerNormalHeight = 1
        mStartTimeField.dividerActiveHeight = 2
        mStartTimeField.dividerNormalColor = UIColor.iBlack50
        mStartTimeField.dividerActiveColor = UIColor.iDarkBlue
        
        let leftView = UIImageView()
        leftView.image = UIImage(systemName: "calendar")
        mStartTimeField.leftView = leftView
        mStartTimeField.leftViewOffset = -8
        mStartTimeField.leftViewNormalColor = UIColor.iBlack50
        mStartTimeField.leftViewActiveColor = UIColor.iDarkBlue
    }
    
    func prepareSearchButton() {
        dailySearchButton.roundCorners(corners: [.allCorners], radius: 4)
        dailySearchButton.titleLabel?.font = LatoFont.black(with: 18)
        
        monthlySearchButton.roundCorners(corners: [.allCorners], radius: 4)
        monthlySearchButton.titleLabel?.font = LatoFont.black(with: 18)
    }
    
}

extension SearchViewController: TabBarDelegate {
    @objc
    func tabBar(tabBar: TabBar, willSelect tabItem: TabItem) {
        print("will select")
    }
    
    @objc
    func tabBar(tabBar: TabBar, didSelect tabItem: TabItem) {
        print("did select")
        let tag = tabItem.tag
        if tag != selectedTag {
            if tag == 1 {
                monthlyView.hideFade()
                dailyView.showFade()
            } else {
                dailyView.hideFade()
                monthlyView.showFade()
            }
            
            selectedTag = tag
        }
        
    }
}
