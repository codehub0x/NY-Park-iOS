//
//  VehiclesViewController.swift
//  iPark
//
//  Created by King on 2019/11/20.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialTextFields

class VehiclesViewController: UIViewController {
    
    static let storyboardId = "\(VehiclesViewController.self)"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var makeField: MDCTextField!
    @IBOutlet weak var modelField: MDCTextField!
    @IBOutlet weak var colorField: MDCTextField!
    @IBOutlet weak var plateField: MDCTextField!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnAdd: MDCButton!
    
    var makeFieldController: CustomTextInputControllerOutlined!
    var modelFieldController: CustomTextInputControllerOutlined!
    var colorFieldController: CustomTextInputControllerOutlined!
    var plateFieldController: CustomTextInputControllerOutlined!
    
    var data: [[String: String]] = [
        ["make": "Bently", "model": "Contiential", "color": "Black", "plate": "FAA-1000"],
        ["make": "Ford", "model": "Mustang", "color": "Red", "plate": "FAA-1000"],
        ["make": "BMW", "model": "Mustang", "color": "White", "plate": "FAA-1000"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adjustUIHeight()
        prepareNavigation()
        prepareView()
        
        tableView.register(UINib(nibName: "\(VehicleCell.self)", bundle: Bundle.main), forCellReuseIdentifier: VehicleCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    fileprivate func adjustUIHeight() {
        // Calculate the expected height - table height + edit view height
        let tableHeight: CGFloat = CGFloat(data.count * 108)

        tableHeightConstraint.constant = tableHeight
    }
    
    @objc func onBackClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onAddVehicleBtnClick(_ sender: Any) {
        var valid = true
        
        let make = makeField.text?.trimmed ?? ""
        if make.isEmpty {
            makeFieldController.setErrorText("Vehicle Make is required", errorAccessibilityValue: "")
            makeField.becomeFirstResponder()
            valid = false
        }
        
        let model = modelField.text?.trimmed ?? ""
        if model.isEmpty {
            modelFieldController.setErrorText("Vehicle Model is required", errorAccessibilityValue: "")
            if valid {
                modelField.becomeFirstResponder()
            }
            valid = false
        }
        
        let color = colorField.text?.trimmed ?? ""
        if color.isEmpty {
            colorFieldController.setErrorText("Color is required", errorAccessibilityValue: "")
            if valid {
                colorField.becomeFirstResponder()
            }
            valid = false
        }
        
        let plate = plateField.text?.trimmed ?? ""
        if plate.isEmpty {
            plateFieldController.setErrorText("Plate is required", errorAccessibilityValue: "")
            if valid {
                plateField.becomeFirstResponder()
            }
            valid = false
        }
        
        if valid {
            // TODO: Save vehicles
            
            
        }
    }
    
}

// MARK: - TableView data source
extension VehiclesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VehicleCell.reuseIdentifier, for: indexPath) as! VehicleCell
        cell.delegate = self
        cell.configure(data[indexPath.row])
        return cell
    }
}

// MARK: - TableView delegate
extension VehiclesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
}

extension VehiclesViewController: VehicleCellDelegate {
    func onEdit(_ item: [String: String]) {
        
    }
}

// MARK: - UITextField delegate
extension VehiclesViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 51:
            makeFieldController.setErrorText(nil, errorAccessibilityValue: nil)
            break
        case 52:
            modelFieldController.setErrorText(nil, errorAccessibilityValue: nil)
            break
        case 53:
            colorFieldController.setErrorText(nil, errorAccessibilityValue: nil)
            break
        case 54:
            plateFieldController.setErrorText(nil, errorAccessibilityValue: nil)
            break
        default:
            break
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let str = textField.text?.trimmed, !str.isEmpty {
            return
        } else {
            switch textField.tag {
            case 51:
                makeFieldController.setErrorText("Vehicle Make is required", errorAccessibilityValue: "")
                break
            case 52:
                modelFieldController.setErrorText("Vehicle Model is required", errorAccessibilityValue: "")
                break
            case 53:
                colorFieldController.setErrorText("Color is required", errorAccessibilityValue: "")
                break
            case 54:
                plateFieldController.setErrorText("Plate is required", errorAccessibilityValue: "")
                break
            default:
                break
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 51:
            modelField.becomeFirstResponder()
            break
        case 52:
            colorField.becomeFirstResponder()
            break
        case 53:
            plateField.becomeFirstResponder()
            break
        default:
            self.view.endEditing(true)
            break
        }
        return true
    }
}

fileprivate extension VehiclesViewController {
    func prepareNavigation() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "Vehicles"
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func prepareView() {
        prepareMakeField()
        prepareModelField()
        prepareColorField()
        preparePlateField()
        prepareButton()
    }
    
    func prepareButton() {
        btnAdd.applyContainedTheme(withScheme: Global.defaultButtonScheme())
    }
    
    func prepareMakeField() {
        makeField.font = LatoFont.regular(with: 17)
        makeField.textColor = .iBlack95
        
        makeFieldController = CustomTextInputControllerOutlined(textInput: makeField)
        makeFieldController.placeholderText = "Vehicle Make"
        makeFieldController.inlinePlaceholderFont = LatoFont.regular(with: 17)
        makeFieldController.inlinePlaceholderColor = .iBlack70
        makeFieldController.floatingPlaceholderNormalColor = .iBlack70
        makeFieldController.floatingPlaceholderActiveColor = .iDarkBlue
        makeFieldController.floatingPlaceholderErrorActiveColor = .red
        makeFieldController.errorColor = .red
        makeFieldController.normalColor = .iBlack70
        makeFieldController.activeColor = .iDarkBlue
    }
    
    func prepareModelField() {
        modelField.font = LatoFont.regular(with: 17)
        modelField.textColor = .iBlack95
        
        modelFieldController = CustomTextInputControllerOutlined(textInput: modelField)
        modelFieldController.placeholderText = "Vehicle Model"
        modelFieldController.inlinePlaceholderFont = LatoFont.regular(with: 17)
        modelFieldController.inlinePlaceholderColor = .iBlack70
        modelFieldController.floatingPlaceholderNormalColor = .iBlack70
        modelFieldController.floatingPlaceholderActiveColor = .iDarkBlue
        modelFieldController.floatingPlaceholderErrorActiveColor = .red
        modelFieldController.errorColor = .red
        modelFieldController.normalColor = .iBlack70
        modelFieldController.activeColor = .iDarkBlue
    }
    
    func prepareColorField() {
        colorField.font = LatoFont.regular(with: 17)
        colorField.textColor = .iBlack95
        
        colorFieldController = CustomTextInputControllerOutlined(textInput: colorField)
        colorFieldController.placeholderText = "Color"
        colorFieldController.inlinePlaceholderFont = LatoFont.regular(with: 17)
        colorFieldController.inlinePlaceholderColor = .iBlack70
        colorFieldController.floatingPlaceholderNormalColor = .iBlack70
        colorFieldController.floatingPlaceholderActiveColor = .iDarkBlue
        colorFieldController.floatingPlaceholderErrorActiveColor = .red
        colorFieldController.errorColor = .red
        colorFieldController.normalColor = .iBlack70
        colorFieldController.activeColor = .iDarkBlue
    }
    
    func preparePlateField() {
        plateField.font = LatoFont.regular(with: 17)
        plateField.textColor = .iBlack95
        
        plateFieldController = CustomTextInputControllerOutlined(textInput: plateField)
        plateFieldController.placeholderText = "Plate"
        plateFieldController.inlinePlaceholderFont = LatoFont.regular(with: 17)
        plateFieldController.inlinePlaceholderColor = .iBlack70
        plateFieldController.floatingPlaceholderNormalColor = .iBlack70
        plateFieldController.floatingPlaceholderActiveColor = .iDarkBlue
        plateFieldController.floatingPlaceholderErrorActiveColor = .red
        plateFieldController.errorColor = .red
        plateFieldController.normalColor = .iBlack70
        plateFieldController.activeColor = .iDarkBlue
    }
}
