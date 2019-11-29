//
//  SearchViewController.swift
//  iPark
//
//  Created by King on 2019/11/14.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material
import MapKit

enum SearchType {
    case Daily
    case Monthly
}

protocol SearchDelegate {
    func onDailySearch(mapItem: MKMapItem, startTime: Date, endTime: Date)
    func onMonthlySearch(mapItem: MKMapItem, startDate: Date)
}

class SearchViewController: UIViewController {
    
    static let storyboardId = "\(SearchViewController.self)"
    
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
    
    fileprivate var buttons = [TabItem]()
    fileprivate var selectedTag = 1
    
    let datePicker = UIDatePicker()
    
    var delegate: SearchDelegate?
    var dailyMapItem: MKMapItem?
    var monthlyMapItem: MKMapItem?
    
    open var startTime: Date? {
        didSet {
            startTimeField.text = startTime!.dateString()
            startTimeField.detail = ""
        }
    }
    
    open var endTime: Date? {
        didSet {
            endTimeField.text = endTime!.dateString()
            endTimeField.detail = ""
        }
    }
    
    open var startDate: Date? {
        didSet {
            mStartTimeField.text = startDate!.dateString("EEE, MMM dd")
            mStartTimeField.detail = ""
        }
    }
    
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
        
        prepareDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc fileprivate func onBackClick() {
        self.dismiss(animated: true)
    }
    
    @IBAction func onDailySearchClick(_ sender: Any) {
        self.view.endEditing(true)
        
        var valid = true
        if addressField.isEmpty {
            addressField.detail = "Empty Address"
            valid = false
        }
        
        if startTimeField.isEmpty {
            startTimeField.detail = "Empty Start Time"
            valid = false
        }
        
        if endTimeField.isEmpty {
            endTimeField.detail = "Empty End Time"
            valid = false
        }
        
        if valid {
            self.delegate?.onDailySearch(mapItem: dailyMapItem!, startTime: startTime!, endTime: endTime!)
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func onMonthlySearchClick(_ sender: Any) {
        self.view.endEditing(true)
        
        var valid = true
        if mAddressField.isEmpty {
            mAddressField.detail = "Empty Address"
            valid = false
        }
        
        if mStartTimeField.isEmpty {
            mStartTimeField.detail = "Empty Start Parking On"
            valid = false
        }
        
        if valid {
            self.delegate?.onMonthlySearch(mapItem: monthlyMapItem!, startDate: startDate!)
            self.dismiss(animated: true)
        }
    }
    
    @objc func donePicker() {
        if startTimeField.isFirstResponder {
            startTime = datePicker.date
        } else if endTimeField.isFirstResponder {
            endTime = datePicker.date
        } else if mStartTimeField.isFirstResponder {
            startDate = datePicker.date
        }
        
        self.view.endEditing(true)
    }
    
    @objc func cancelPicker() {
        self.view.endEditing(true)
    }
}

extension SearchViewController: TabBarDelegate {
    @objc func tabBar(tabBar: TabBar, willSelect tabItem: TabItem) {
        
    }
    
    @objc func tabBar(tabBar: TabBar, didSelect tabItem: TabItem) {
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

extension SearchViewController: TextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 11:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newVC = storyboard.instantiateViewController(withIdentifier: LocationSearchTable.storyboardId) as! LocationSearchTable
            newVC.searchType = SearchType.Daily
            newVC.delegate = self
            self.navigationController?.pushViewController(newVC, animated: true)
            return false
        case 21:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newVC = storyboard.instantiateViewController(withIdentifier: LocationSearchTable.storyboardId) as! LocationSearchTable
            newVC.searchType = SearchType.Monthly
            newVC.delegate = self
            self.navigationController?.pushViewController(newVC, animated: true)
            return false
        case 12:
            // Set picker mode
            datePicker.datePickerMode = .dateAndTime
            // Set minimum date
            datePicker.minimumDate = Date()
            // Set selected date
            if let date = startTime {
                datePicker.date = date
            }
            break
        case 13:
            // Set picker mode
            datePicker.datePickerMode = .dateAndTime
            // Set minimum date
            if let minDate = startTime {
                datePicker.minimumDate = minDate.add(minutes: 30)
            } else {
                datePicker.minimumDate = Date().add(minutes: 30)
            }
            // Set selected date
            if let date = endTime {
                datePicker.date = date
            }
            break
        case 22:
            // Set picker mode
            datePicker.datePickerMode = .date
            // Set minimum date
            datePicker.minimumDate = Date()
            // Set selected date
            if let date = startDate {
                datePicker.date = date
            }
            break
        default:
            break
        }
        
        return true
    }
    
}

extension SearchViewController: LocationSearchDelegate {
    func onClickAddress(searchType: SearchType, mapItem: MKMapItem) {
        let address = parseAddress(selectedItem: mapItem.placemark)
        switch searchType {
        case .Daily:
            self.dailyMapItem = mapItem
            self.addressField.text = address
            self.addressField.detail = ""
            break
        case .Monthly:
            self.monthlyMapItem = mapItem
            self.mAddressField.text = address
            self.mAddressField.detail = ""
            break
        }
    }
}

fileprivate extension SearchViewController {
    func prepareNavigation() {
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        leftButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: LatoFont.bold(with: 20)]
    }
    
    func prepareButtons() {
        let btn1 = TabItem(title: "Daily", titleColor: Color.white)
        btn1.pulseAnimation = .centerRadialBeyondBounds
        btn1.setTabItemColor(.iYellow, for: .selected)
        btn1.setTabItemColor(.white, for: .normal)
        btn1.titleLabel?.font = LatoFont.bold(with: 15)
        btn1.tag = 1
        buttons.append(btn1)
       
        let btn2 = TabItem(title: "Monthly", titleColor: Color.white)
        btn2.pulseAnimation = .centerRadialBeyondBounds
        btn2.setTabItemColor(.iYellow, for: .selected)
        btn2.setTabItemColor(.white, for: .normal)
        btn2.titleLabel?.font = LatoFont.bold(with: 15)
        btn2.tag = 2
        buttons.append(btn2)
    }
    
    func prepareTabBar() {
        tabBar.delegate = self
        
        tabBar.dividerColor = .iBlack80
        tabBar.dividerAlignment = .top
        tabBar.dividerThickness = 0.3
        
        tabBar.lineColor = .iYellow
        tabBar.lineAlignment = .bottom
        tabBar.lineHeight = 4
        
        tabBar.tabItems = buttons
    }
    
    func prepareDatePicker() {
        // Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Done & Cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker))
        
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        startTimeField.inputAccessoryView = toolbar
        startTimeField.inputView = datePicker
        
        endTimeField.inputAccessoryView = toolbar
        endTimeField.inputView = datePicker
        
        mStartTimeField.inputAccessoryView = toolbar
        mStartTimeField.inputView = datePicker
    }
    
    func prepareAddressField() {
        addressField.placeholder = "Enter Address, Venue, or Airport"
        addressField.placeholderLabel.font = LatoFont.regular(with: 15)
        addressField.placeholderActiveScale = 0.7
        addressField.placeholderNormalColor = .iBlack50
        addressField.placeholderActiveColor = .iDarkBlue
        addressField.placeholderHorizontalOffset = -12
        
        addressField.font = LatoFont.regular(with: 15)
        addressField.textColor = .black
        addressField.textInsets = EdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        addressField.detailColor = .red
        
        addressField.dividerNormalHeight = 1
        addressField.dividerActiveHeight = 2
        addressField.dividerNormalColor = .iBlack50
        addressField.dividerActiveColor = .iDarkBlue
        
        let leftView = UIImageView()
        leftView.image = UIImage(named: "icon-search")?.withRenderingMode(.alwaysTemplate)
        addressField.leftView = leftView
        addressField.leftViewOffset = -8
        addressField.leftViewNormalColor = .iBlack50
        addressField.leftViewActiveColor = .iDarkBlue
    }
    
    func prepareStartTimeField() {
        startTimeField.placeholder = "Start Time"
        startTimeField.placeholderLabel.font = LatoFont.regular(with: 15)
        startTimeField.placeholderActiveScale = 0.7
        startTimeField.placeholderNormalColor = .iBlack50
        startTimeField.placeholderActiveColor = .iDarkBlue
        startTimeField.placeholderHorizontalOffset = -12
        
        startTimeField.font = LatoFont.regular(with: 15)
        startTimeField.textColor = .black
        startTimeField.textInsets = EdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        startTimeField.detailColor = .red
        
        startTimeField.dividerNormalHeight = 1
        startTimeField.dividerActiveHeight = 2
        startTimeField.dividerNormalColor = .iBlack50
        startTimeField.dividerActiveColor = .iDarkBlue
        
        let leftView = UIImageView()
        leftView.image = UIImage(named: "icon-time")?.withRenderingMode(.alwaysTemplate)
        startTimeField.leftView = leftView
        startTimeField.leftViewOffset = -8
        startTimeField.leftViewNormalColor = .iBlack50
        startTimeField.leftViewActiveColor = .iDarkBlue
    }
    
    func prepareEndTimeField() {
        endTimeField.placeholder = "End Time"
        endTimeField.placeholderLabel.font = LatoFont.regular(with: 15)
        endTimeField.placeholderActiveScale = 0.7
        endTimeField.placeholderNormalColor = .iBlack50
        endTimeField.placeholderActiveColor = .iDarkBlue
        endTimeField.placeholderHorizontalOffset = -12
        
        endTimeField.font = LatoFont.regular(with: 15)
        endTimeField.textColor = .black
        endTimeField.textInsets = EdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        endTimeField.detailColor = .red
        
        endTimeField.dividerNormalHeight = 1
        endTimeField.dividerActiveHeight = 2
        endTimeField.dividerNormalColor = .iBlack50
        endTimeField.dividerActiveColor = .iDarkBlue
        
        let leftView = UIImageView()
        leftView.image = UIImage(named: "icon-time")?.withRenderingMode(.alwaysTemplate)
        endTimeField.leftView = leftView
        endTimeField.leftViewOffset = -8
        endTimeField.leftViewNormalColor = .iBlack50
        endTimeField.leftViewActiveColor = .iDarkBlue
    }
    
    func prepareMAddressField() {
        mAddressField.placeholder = "Enter Address, Venue, or Airport"
        mAddressField.placeholderLabel.font = LatoFont.regular(with: 15)
        mAddressField.placeholderActiveScale = 0.7
        mAddressField.placeholderNormalColor = .iBlack50
        mAddressField.placeholderActiveColor = .iDarkBlue
        mAddressField.placeholderHorizontalOffset = -12
        
        mAddressField.font = LatoFont.regular(with: 15)
        mAddressField.textColor = .black
        mAddressField.textInsets = EdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        mAddressField.detailColor = .red
        
        mAddressField.dividerNormalHeight = 1
        mAddressField.dividerActiveHeight = 2
        mAddressField.dividerNormalColor = .iBlack50
        mAddressField.dividerActiveColor = .iDarkBlue
        
        let leftView = UIImageView()
        leftView.image = UIImage(named: "icon-search")?.withRenderingMode(.alwaysTemplate)
        mAddressField.leftView = leftView
        mAddressField.leftViewOffset = -8
        mAddressField.leftViewNormalColor = .iBlack50
        mAddressField.leftViewActiveColor = .iDarkBlue
    }
    
    func prepareMStartTimeField() {
        mStartTimeField.placeholder = "Start Parking On"
        mStartTimeField.placeholderLabel.font = LatoFont.regular(with: 15)
        mStartTimeField.placeholderActiveScale = 0.7
        mStartTimeField.placeholderNormalColor = .iBlack50
        mStartTimeField.placeholderActiveColor = .iDarkBlue
        mStartTimeField.placeholderHorizontalOffset = -12
        
        mStartTimeField.font = LatoFont.regular(with: 15)
        mStartTimeField.textColor = .black
        mStartTimeField.textInsets = EdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        mStartTimeField.detailColor = .red
        
        mStartTimeField.dividerNormalHeight = 1
        mStartTimeField.dividerActiveHeight = 2
        mStartTimeField.dividerNormalColor = .iBlack50
        mStartTimeField.dividerActiveColor = .iDarkBlue
        
        let leftView = UIImageView()
        leftView.image = UIImage(named: "icon-calendar")?.withRenderingMode(.alwaysTemplate)
        mStartTimeField.leftView = leftView
        mStartTimeField.leftViewOffset = -8
        mStartTimeField.leftViewNormalColor = .iBlack50
        mStartTimeField.leftViewActiveColor = .iDarkBlue
    }
    
    func prepareSearchButton() {
        dailySearchButton.roundCorners(corners: [.allCorners], radius: 4)
        dailySearchButton.titleLabel?.font = LatoFont.black(with: 18)
        
        monthlySearchButton.roundCorners(corners: [.allCorners], radius: 4)
        monthlySearchButton.titleLabel?.font = LatoFont.black(with: 18)
    }
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    
}

