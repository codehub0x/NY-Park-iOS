//
//  LocationSearchTableViewController.swift
//  iPark
//
//  Created by King on 2019/11/29.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import MapKit

protocol LocationSearchDelegate {
    func onClickAddress(searchType: SearchType, mapItem: MKMapItem)
}

class LocationSearchTable: UITableViewController {
    
    static let storyboardId = "\(LocationSearchTable.self)"
    let reuseIdentifier = "LocaionSearchCell"
    
    var resultSearchController = UISearchController()
    var matchingItems: [MKMapItem] = []
    var delegate: LocationSearchDelegate?
    var searchType: SearchType = SearchType.Daily
    
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
        resultSearchController.dismiss(animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    // MARK - UITableView DataSource & Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let item = matchingItems[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: item.placemark)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.onClickAddress(searchType: searchType, mapItem: matchingItems[indexPath.row])
        resultSearchController.dismiss(animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension LocationSearchTable: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        let region = MKCoordinateRegion(center: Global.currentLocation, latitudinalMeters: Global.searchRegionRadius, longitudinalMeters: Global.searchRegionRadius)
        request.region = region
        let search = MKLocalSearch(request: request)
        search.start { (response, _) in
            guard let response = response else { return }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
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
