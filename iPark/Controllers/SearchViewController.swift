//
//  SearchViewController.swift
//  iPark
//
//  Created by King on 2019/11/14.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import MapKit
import Material
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialButtons

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
    @IBOutlet weak var addressField: MDCTextField!
    @IBOutlet weak var startTimeField: MDCTextField!
    @IBOutlet weak var endTimeField: MDCTextField!
    @IBOutlet weak var mAddressField: MDCTextField!
    @IBOutlet weak var mStartTimeField: MDCTextField!
    
    @IBOutlet weak var addressImageView: UIImageView!
    @IBOutlet weak var startTimeImageView: UIImageView!
    @IBOutlet weak var endTimeImageView: UIImageView!
    @IBOutlet weak var mAddressImageView: UIImageView!
    @IBOutlet weak var mStartTimeImageView: UIImageView!
    
    var addressFieldController: MDCTextInputControllerUnderline!
    var startTimeFieldController: MDCTextInputControllerUnderline!
    var endTimeFieldController: MDCTextInputControllerUnderline!
    var mAddressFieldController: MDCTextInputControllerUnderline!
    var mStartTimeFieldController: MDCTextInputControllerUnderline!
    
    fileprivate var buttons = [TabItem]()
    fileprivate var selectedTag = 1
    
    let datePicker = UIDatePicker()
    
    var delegate: SearchDelegate?
    var dailyMapItem: MKMapItem?
    var monthlyMapItem: MKMapItem?
    
    open var startTime: Date? {
        didSet {
            startTimeField.text = startTime!.dateString()
            startTimeFieldController.setErrorText(nil, errorAccessibilityValue: nil)
        }
    }
    
    open var endTime: Date? {
        didSet {
            endTimeField.text = endTime!.dateString()
            endTimeFieldController.setErrorText(nil, errorAccessibilityValue: nil)
        }
    }
    
    open var startDate: Date? {
        didSet {
            mStartTimeField.text = startDate!.dateString("EEE, MMM dd")
            mStartTimeFieldController.setErrorText(nil, errorAccessibilityValue: nil)
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
        
        prepareDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc fileprivate func onBackClick() {
        self.dismiss(animated: true)
    }
    
    @IBAction func onClickSearchBtn(_ sender: Any) {
        self.view.endEditing(true)

        var valid = true
        if selectedTag == 1 {
            if dailyMapItem == nil {
                addressFieldController.setErrorText("Empty Address", errorAccessibilityValue: "Empty Address")
                valid = false
            }
            
            if startTime == nil {
                startTimeFieldController.setErrorText("Empty Start Time", errorAccessibilityValue: "Empty Start Time")
                valid = false
            }
            
            if endTime == nil {
                endTimeFieldController.setErrorText("Empty End Time", errorAccessibilityValue: "Empty End Time")
                valid = false
            }
            
            if valid {
                self.delegate?.onDailySearch(mapItem: dailyMapItem!, startTime: startTime!, endTime: endTime!)
                self.dismiss(animated: true)
            }
        } else {
            if monthlyMapItem == nil {
                mAddressFieldController.setErrorText("Empty Address", errorAccessibilityValue: "Empty Address")
                valid = false
            }
            
            if startDate == nil {
                mStartTimeFieldController.setErrorText("Empty Start Parking On", errorAccessibilityValue: "Empty Start Parking On")
                valid = false
            }
            
            if valid {
                self.delegate?.onMonthlySearch(mapItem: monthlyMapItem!, startDate: startDate!)
                self.dismiss(animated: true)
            }
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

extension SearchViewController: UITextFieldDelegate {
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
            startTimeImageView.tintColor = .iDarkBlue
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
            endTimeImageView.tintColor = .iDarkBlue
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
            mStartTimeImageView.tintColor = .iDarkBlue
            break
        default:
            break
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 12:
            startTimeImageView.tintColor = .iBlack70
            break
        case 13:
            endTimeImageView.tintColor = .iBlack70
            break
        case 22:
            mStartTimeImageView.tintColor = .iBlack70
            break
        default:
            break
        }
    }
    
}

extension SearchViewController: LocationSearchDelegate {
    func onClickAddress(searchType: SearchType, mapItem: MKMapItem) {
        let address = parseAddress(selectedItem: mapItem.placemark)
        switch searchType {
        case .Daily:
            self.dailyMapItem = mapItem
            self.addressField.text = address
            self.addressFieldController.setErrorText(nil, errorAccessibilityValue: nil)
            break
        case .Monthly:
            self.monthlyMapItem = mapItem
            self.mAddressField.text = address
            self.mAddressFieldController.setErrorText(nil, errorAccessibilityValue: nil)
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
        addressField.font = LatoFont.regular(with: 15)
        addressField.textColor = .black
        
        addressFieldController = MDCTextInputControllerUnderline(textInput: addressField)
        addressFieldController.placeholderText = "Enter Address, Venue, or Airport"
        addressFieldController.inlinePlaceholderFont = LatoFont.regular(with: 15)
        addressFieldController.inlinePlaceholderColor = .iBlack70
        addressFieldController.floatingPlaceholderNormalColor = .iBlack70
        addressFieldController.floatingPlaceholderActiveColor = .iDarkBlue
        addressFieldController.floatingPlaceholderErrorActiveColor = .red
        addressFieldController.errorColor = .red
        addressFieldController.activeColor = .iDarkBlue
        addressFieldController.normalColor = .iBlack70
        
        addressImageView.image = addressImageView.image?.withRenderingMode(.alwaysTemplate)
        addressImageView.tintColor = .iBlack70
    }
    
    func prepareStartTimeField() {
        startTimeField.font = LatoFont.regular(with: 15)
        startTimeField.textColor = .black
        
        startTimeFieldController = MDCTextInputControllerUnderline(textInput: startTimeField)
        startTimeFieldController.placeholderText = "Start Time"
        startTimeFieldController.inlinePlaceholderFont = LatoFont.regular(with: 15)
        startTimeFieldController.inlinePlaceholderColor = .iBlack70
        startTimeFieldController.floatingPlaceholderNormalColor = .iBlack70
        startTimeFieldController.floatingPlaceholderActiveColor = .iDarkBlue
        startTimeFieldController.floatingPlaceholderErrorActiveColor = .red
        startTimeFieldController.errorColor = .red
        startTimeFieldController.activeColor = .iDarkBlue
        startTimeFieldController.normalColor = .iBlack70
        
        startTimeImageView.image = startTimeImageView.image?.withRenderingMode(.alwaysTemplate)
        startTimeImageView.tintColor = .iBlack70
    }
    
    func prepareEndTimeField() {
        endTimeField.font = LatoFont.regular(with: 15)
        endTimeField.textColor = .black
        
        endTimeFieldController = MDCTextInputControllerUnderline(textInput: endTimeField)
        endTimeFieldController.placeholderText = "End Time"
        endTimeFieldController.inlinePlaceholderFont = LatoFont.regular(with: 15)
        endTimeFieldController.inlinePlaceholderColor = .iBlack70
        endTimeFieldController.floatingPlaceholderNormalColor = .iBlack70
        endTimeFieldController.floatingPlaceholderActiveColor = .iDarkBlue
        endTimeFieldController.floatingPlaceholderErrorActiveColor = .red
        endTimeFieldController.errorColor = .red
        endTimeFieldController.activeColor = .iDarkBlue
        endTimeFieldController.normalColor = .iBlack70
        
        endTimeImageView.image = endTimeImageView.image?.withRenderingMode(.alwaysTemplate)
        endTimeImageView.tintColor = .iBlack70
    }
    
    func prepareMAddressField() {
        mAddressField.font = LatoFont.regular(with: 15)
        mAddressField.textColor = .black
        
        mAddressFieldController = MDCTextInputControllerUnderline(textInput: mAddressField)
        mAddressFieldController.placeholderText = "Enter Address, Venue, or Airport"
        mAddressFieldController.inlinePlaceholderFont = LatoFont.regular(with: 15)
        mAddressFieldController.inlinePlaceholderColor = .iBlack70
        mAddressFieldController.floatingPlaceholderNormalColor = .iBlack70
        mAddressFieldController.floatingPlaceholderActiveColor = .iDarkBlue
        mAddressFieldController.floatingPlaceholderErrorActiveColor = .red
        mAddressFieldController.errorColor = .red
        mAddressFieldController.activeColor = .iDarkBlue
        mAddressFieldController.normalColor = .iBlack70
        
        mAddressImageView.image = mAddressImageView.image?.withRenderingMode(.alwaysTemplate)
        mAddressImageView.tintColor = .iBlack70
    }
    
    func prepareMStartTimeField() {
        mStartTimeField.font = LatoFont.regular(with: 15)
        mStartTimeField.textColor = .black
        
        mStartTimeFieldController = MDCTextInputControllerUnderline(textInput: mStartTimeField)
        mStartTimeFieldController.placeholderText = "Start Parking On"
        mStartTimeFieldController.inlinePlaceholderFont = LatoFont.regular(with: 15)
        mStartTimeFieldController.inlinePlaceholderColor = .iBlack70
        mStartTimeFieldController.floatingPlaceholderNormalColor = .iBlack70
        mStartTimeFieldController.floatingPlaceholderActiveColor = .iDarkBlue
        mStartTimeFieldController.floatingPlaceholderErrorActiveColor = .red
        mStartTimeFieldController.errorColor = .red
        mStartTimeFieldController.activeColor = .iDarkBlue
        mStartTimeFieldController.normalColor = .iBlack70
        
        mStartTimeImageView.image = mStartTimeImageView.image?.withRenderingMode(.alwaysTemplate)
        mStartTimeImageView.tintColor = .iBlack70
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

