//
//  LocationSearchTableViewController.swift
//  iPark
//
//  Created by King on 2019/11/29.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import UIKit

class LocationSearchTable: UITableViewController {
    
    static let storyboardId = "\(LocationSearchTable.self)"
    
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation()
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.hidesNavigationBarDuringPresentation = false
            controller.searchBar.sizeToFit()

            tableView.tableHeaderView = controller.searchBar

            return controller
        })()
        
        tableView.reloadData()
    }
    
    @objc fileprivate func onBackClick() {
        resultSearchController.dismiss(animated: false)
        self.navigationController?.popViewController(animated: true)
    }
}

extension LocationSearchTable: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.tableView.reloadData()
    }
}

fileprivate extension LocationSearchTable {
    func prepareNavigation() {
        self.title = "Location Search"
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        leftButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: LatoFont.bold(with: 20)]
    }
}
