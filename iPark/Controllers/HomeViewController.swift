//
//  HomeViewController.swift
//  iPark
//
//  Created by King on 2019/11/13.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import MapKit
import Material

class HomeViewController: UIViewController {
    
    @IBOutlet weak var btnToggle: RaisedButton!
    @IBOutlet weak var btnFilters: RaisedButton!
    @IBOutlet weak var hoursImageView: UIImageView!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var btnArrow: FlatButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    @IBOutlet weak var filterView: UIScrollView!
    @IBOutlet weak var bottomHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var mkMapView: MKMapView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var checkBtn24Hours: FlatButton!
    @IBOutlet weak var checkBtn7Days: FlatButton!
    @IBOutlet weak var checkBtnCovered: FlatButton!
    @IBOutlet weak var checkBtnPaved: FlatButton!
    @IBOutlet weak var checkBtnValet: FlatButton!
    @IBOutlet weak var checkBtnOversizedVehicles: FlatButton!
    @IBOutlet weak var checkBtnGreen: FlatButton!
    @IBOutlet weak var checkBtnTesla: FlatButton!
    @IBOutlet weak var checkBtnOutdoors: FlatButton!
    @IBOutlet weak var checkBtnOnSiteStaff: FlatButton!
    
    fileprivate var mainStoryboard: UIStoryboard!
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    var userLocation = CLLocationCoordinate2D(latitude: 40.71, longitude: -74.01)
    
    let bottomViewHeight: CGFloat = 185
    let filterViewWidth: CGFloat = 270
    
    /// Toggle bottom shown/hidden parameter
    private var isShowBottomView: Bool = false
    
    /// Toggle Filter parameter
    private var isShowFilter: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        /// Initialize the UI Settings
        prepareUI()
        prepareHoursImageView()
        prepareArrowButton()
        
        prepareSegmentedControl()
        
        /// Register table view xib
        tableView.register(UINib(nibName: "\(HomeCell.self)", bundle: Bundle.main), forCellReuseIdentifier: HomeCell.reuseIdentifier)
        /// Register collection view xib
        bottomCollectionView.register(UINib(nibName: "\(BookedCell.self)", bundle: Bundle.main), forCellWithReuseIdentifier: BookedCell.reuseIdentifier)
        
        /// Set LocationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        checkLocationService()
        
    }
    
    // Set the status bar style as light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    /// Toggle to show the Map / List
    @IBAction func onClickToggle(_ sender: Any) {
        updateBottomView(isShow: false, animate: false)
        updateFilterView(isShow: false, animate: false)
        
        if listView.isHidden {
            listView.showFlip()
            mkMapView.hideFlip()
            btnToggle.setTitle("MAP", for: .normal)
        } else if mkMapView.isHidden {
            mkMapView.showFlip()
            listView.hideFlip()
            btnToggle.setTitle("LIST", for: .normal)
        }
    }
    
    @IBAction func onClickUserLocation(_ sender: Any) {
        showLocation(userLocation)
    }
    
    /// Show / Hidden recently booked locations
    @IBAction func onClickArrow(_ sender: Any) {
        updateBottomView(isShow: !isShowBottomView)
        updateFilterView(isShow: false, animate: false)
    }
    
    /// Toggle Filters
    @IBAction func onClickFilters(_ sender: Any) {
        updateFilterView(isShow: !isShowFilter)
        updateBottomView(isShow: false, animate: false)
    }

    /// SegmentedControl value change event when click SORT BY DISTANCE / SORT BY PRICE
    @IBAction func onViewIndexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            /// TODO: Sort by distance
            tableView.reloadData()
            break
        case 1:
            /// TODO: Sort by price
            tableView.reloadData()
            break
        default:
            break
        }
    }
    
    @IBAction func onApplyFiltersBtnClick(_ sender: Any) {
        isShowFilter = false
    }
    
    @IBAction func onClearBtnClick(_ sender: Any) {
        checkBtn24Hours.isSelected = false
        checkBtn7Days.isSelected = false
        checkBtnCovered.isSelected = false
        checkBtnPaved.isSelected = false
        checkBtnValet.isSelected = false
        checkBtnOversizedVehicles.isSelected = false
        checkBtnGreen.isSelected = false
        checkBtnTesla.isSelected = false
        checkBtnOutdoors.isSelected = false
        checkBtnOnSiteStaff.isSelected = false
    }
    
    @IBAction func onFilterButtonChanged(_ sender: FlatButton) {
        sender.isSelected = !sender.isSelected
    }
    
    func updateBottomView(isShow: Bool, animate: Bool = true) {
        isShowBottomView = isShow
        if isShowBottomView {
            if animate {
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                    self.bottomView.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.btnArrow.transform = CGAffineTransform(translationX: 0, y: 0)
                }) { _ in
                    self.btnArrow.imageView!.rotate(withAngle: CGFloat(0), animated: false)
                    self.btnArrow.imageView!.rotate(withAngle: CGFloat(Double.pi), animated: true)
                }
            } else {
                self.bottomView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.btnArrow.transform = CGAffineTransform(translationX: 0, y: 0)
                self.btnArrow.imageView!.rotate(withAngle: CGFloat(Double.pi), animated: false)
            }
        } else {
            if animate {
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                    self.bottomView.transform = CGAffineTransform(translationX: 0, y: self.bottomViewHeight)
                    self.btnArrow.transform = CGAffineTransform(translationX: 0, y: self.bottomViewHeight)
                }) { _ in
                    self.btnArrow.imageView!.rotate(withAngle: CGFloat(Double.pi), animated: false)
                    self.btnArrow.imageView!.rotate(withAngle: CGFloat(0), animated: true)
                }
            } else {
                self.bottomView.transform = CGAffineTransform(translationX: 0, y: self.bottomViewHeight)
                self.btnArrow.transform = CGAffineTransform(translationX: 0, y: self.bottomViewHeight)
                self.btnArrow.imageView!.rotate(withAngle: CGFloat(0), animated: false)
            }
            
        }
    }
    
    func updateFilterView(isShow: Bool, animate: Bool = true) {
        isShowFilter = isShow
        if isShowFilter {
            if animate {
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                    self.filterView.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: { _ in
                    self.btnFilters.setTitle("CLOSE", for: .normal)
                    self.btnFilters.setImage(UIImage(named: "icon-close-circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    self.btnFilters.tintColor = UIColor.iDarkBlue
                    self.btnFilters.imageView!.rotate(withAngle: CGFloat(0), animated: false)
                    self.btnFilters.imageView!.rotate(withAngle: CGFloat(Double.pi), animated: true)
                })
            } else {
                self.filterView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.btnFilters.setTitle("CLOSE", for: .normal)
                self.btnFilters.setImage(UIImage(named: "icon-close-circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
                self.btnFilters.tintColor = UIColor.iDarkBlue
            }
        } else {
            if animate {
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                    self.filterView.transform = CGAffineTransform(translationX: self.filterViewWidth, y: 0)
                }, completion: { _ in
                    self.btnFilters.setTitle("FILTERS", for: .normal)
                    self.btnFilters.setImage(UIImage(), for: .normal)
                })
            } else {
                self.filterView.transform = CGAffineTransform(translationX: self.filterViewWidth, y: 0)
                self.btnFilters.setTitle("FILTERS", for: .normal)
                self.btnFilters.setImage(UIImage(), for: .normal)
            }
        }
    }
    
    func showLocation(_ coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mkMapView.setRegion(region, animated: true)
    }

}

/// TableView dataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseIdentifier, for: indexPath) as! HomeCell
        cell.delegate = self
        return cell
    }
}

/// TableView delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
}

/// TableViewCell delegate
extension HomeViewController: HomeCellDelegate {
    func onDetails() {
        var vc: UIViewController!
        if #available(iOS 13.0, *) {
            vc = mainStoryboard.instantiateViewController(identifier: DetailsViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            vc = mainStoryboard.instantiateViewController(withIdentifier: DetailsViewController.storyboardId)
        }
        if let newVC = vc {
            let navVC = newVC.getNavigationController()
            navVC.modalPresentationStyle = .overFullScreen
            self.present(navVC, animated: true)
        }
    }
    
    func onBook() {
        var vc: UIViewController!
        if #available(iOS 13.0, *) {
            vc = mainStoryboard.instantiateViewController(identifier: BookViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            vc = mainStoryboard.instantiateViewController(withIdentifier: BookViewController.storyboardId)
        }
        if let newVC = vc {
            let navVC = newVC.getNavigationController()
            navVC.modalPresentationStyle = .overFullScreen
            self.present(navVC, animated: true)
        }
    }
    
}

// MARK: - CollectionView datasource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookedCell.reuseIdentifier, for: indexPath)
        
        return cell
    }
}

// MARK: - CollectionView delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var vc: UIViewController!
        if #available(iOS 13.0, *) {
            vc = mainStoryboard.instantiateViewController(identifier: DetailsViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            vc = mainStoryboard.instantiateViewController(withIdentifier: DetailsViewController.storyboardId)
        }
        if let newVC = vc {
            let navVC = newVC.getNavigationController()
            navVC.modalPresentationStyle = .overFullScreen
            self.present(navVC, animated: true)
        }
    }
}

// MARK: - Collection View Flow Layout Delegate
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 140, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 10
    }
}

// MARK: - LocatioinManager delegate
extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.userLocation = location.coordinate
            showLocation(location.coordinate)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}

// Initialize the UI settings
fileprivate extension HomeViewController {
    func prepareUI() {
        viewDetails.roundCorners(corners: [.allCorners], radius: 8.0)
        viewDetails.layer.borderWidth = 0.5
        viewDetails.layer.borderColor = UIColor.iBlack60.cgColor
        viewDetails.layer.cornerRadius = 8.0
        viewDetails.layer.masksToBounds = true
        
        filterWidthConstraint.constant = 270
        filterView.transform = CGAffineTransform(translationX: filterViewWidth, y: 0)
        
        bottomView.transform = CGAffineTransform(translationX: 0, y: bottomViewHeight)
        btnArrow.transform = CGAffineTransform(translationX: 0, y: bottomViewHeight)
    }
    
    func prepareArrowButton() {
        btnArrow.roundCorners(corners: [.topLeft, .topRight], radius: 18.0)
        btnArrow.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        btnArrow.setImage(UIImage(named: "icon-arrow-up")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnArrow.tintColor = UIColor.iBlack90
    }
    
    func prepareHoursImageView() {
        hoursImageView.image = hoursImageView.image?.withRenderingMode(.alwaysTemplate)
        hoursImageView.tintColor = UIColor.white
    }
    
    func prepareSegmentedControl() {
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: LatoFont.black(with: 9), NSAttributedString.Key.foregroundColor: UIColor.iBlack70, NSAttributedString.Key.kern: 2], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: LatoFont.black(with: 9), NSAttributedString.Key.foregroundColor: UIColor.iDarkBlue, NSAttributedString.Key.kern: 2], for: .selected)
        segmentedControl.setDividerImage(imageWithColor(color: UIColor.iBlack70), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(imageWithColor(color: UIColor(rgb: 0xEFF2F7)), for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(imageWithColor(color: UIColor(rgb: 0xEFF2F7)), for: .selected, barMetrics: .default)
        segmentedControl.setBackgroundImage(imageWithColor(color: UIColor(rgb: 0xEFF2F7)), for: .highlighted, barMetrics: .default)
    }
    
    func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}
