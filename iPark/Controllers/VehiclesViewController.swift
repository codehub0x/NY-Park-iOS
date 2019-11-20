//
//  VehiclesViewController.swift
//  iPark
//
//  Created by King on 2019/11/20.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class VehiclesViewController: UIViewController {
    
    static let storyboardId = "\(VehiclesViewController.self)"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var makeField: UITextField!
    @IBOutlet weak var modelField: UITextField!
    @IBOutlet weak var colorField: UITextField!
    @IBOutlet weak var plateField: UITextField!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    
    var data: [[String: String]] = [
        ["make": "Bently", "model": "Contiential", "color": "Black", "plate": "FAA-1000"],
        ["make": "Ford", "model": "Mustang", "color": "Red", "plate": "FAA-1000"],
        ["make": "BMW", "model": "Mustang", "color": "White", "plate": "FAA-1000"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adjustUIHeight()
        prepareNavigation()
        
        tableView.register(UINib(nibName: "\(VehicleCell.self)", bundle: Bundle.main), forCellReuseIdentifier: VehicleCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    fileprivate func adjustUIHeight() {
        let windowSize = UIScreen.main.bounds
        var bottomPadding: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
//            let topPadding = window?.safeAreaInsets.top ?? 0
            bottomPadding = window?.safeAreaInsets.bottom ?? 0
//            padding = topPadding + bottomPadding
        }
        var viewHeight = windowSize.height - bottomPadding - self.topbarHeight
        
        // Calculate the expected height - table height + edit view height
        let tableHeight: CGFloat = CGFloat(data.count * 108)
        let expectedHeight: CGFloat = tableHeight + 520
        if viewHeight < expectedHeight {
            viewHeight = expectedHeight
        }
        
        tableHeightConstraint.constant = tableHeight
        heightConstraint.constant = viewHeight
    }
    
    @objc func onBackClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onAddVehicleBtnClick(_ sender: Any) {
        
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

fileprivate extension VehiclesViewController {
    func prepareNavigation() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "Vehicles"
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
    }
}
