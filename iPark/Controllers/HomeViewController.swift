//
//  HomeViewController.swift
//  iPark
//
//  Created by King on 2019/11/13.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import MapKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialContainerScheme

class HomeViewController: UIViewController {
    
    @IBOutlet weak var btnToggle: MDCButton!
    @IBOutlet weak var btnSearch: MDCButton!
    @IBOutlet weak var btnFilters: MDCButton!
    @IBOutlet weak var btnFavorite: MDCButton!
    @IBOutlet weak var btnHours: MDCButton!
    @IBOutlet weak var hoursImageView: UIImageView!
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    @IBOutlet weak var filterView: UIScrollView!
    @IBOutlet weak var bottomHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var mkMapView: MKMapView!
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnApplyFilters: MDCButton!
    @IBOutlet weak var btnClear: MDCButton!
    @IBOutlet weak var checkBtn24Hours: MDCButton!
    @IBOutlet weak var checkBtn7Days: MDCButton!
    @IBOutlet weak var checkBtnCovered: MDCButton!
    @IBOutlet weak var checkBtnPaved: MDCButton!
    @IBOutlet weak var checkBtnValet: MDCButton!
    @IBOutlet weak var checkBtnOversizedVehicles: MDCButton!
    @IBOutlet weak var checkBtnGreen: MDCButton!
    @IBOutlet weak var checkBtnTesla: MDCButton!
    @IBOutlet weak var checkBtnOutdoors: MDCButton!
    @IBOutlet weak var checkBtnOnSiteStaff: MDCButton!
    // MarkerInfos
    @IBOutlet weak var viewMarkerInfo: UIView!
    @IBOutlet weak var labelInfoAddress: UIView!
    @IBOutlet weak var labelInfoTitle: UIView!
    @IBOutlet weak var imageViewInfoItem: UIImageView!
    @IBOutlet weak var imageViewInfoLocation: UIImageView!
    @IBOutlet weak var labelInfoDistance: UILabel!
    @IBOutlet weak var labelInfoPrice: UILabel!
    @IBOutlet weak var btnInfoBook: MDCButton!
    @IBOutlet weak var btnInfoDetails: MDCButton!
    @IBOutlet weak var btnCurrentLocation: MDCFloatingButton!
    
    fileprivate var mainStoryboard: UIStoryboard!
    
    let locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    
    let bottomViewHeight: CGFloat = 185
    let filterViewWidth: CGFloat = 270
    
    /// Toggle bottom show/hide parameter
    private var isShowBottomView: Bool = false
    /// Toggle Filter parameter
    private var isShowFilter: Bool = false
    /// Toggle MarkerInfo view show/hide parameter
    private var isShowMarkerInfo: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        /// Initialize the UI Settings
        prepareUI()
        prepareHoursImageView()
        prepareHeaderButtons()
        prepareFilterButtons()
        prepareCurrentLocationButton()
        prepareArrowButton()
        prepareSegmentedControl()
        prepareMarkerInfoView()
        
        /// Register table view xib
        tableView.register(UINib(nibName: "\(HomeCell.self)", bundle: Bundle.main), forCellReuseIdentifier: HomeCell.reuseIdentifier)
        /// Register collection view xib
        bottomCollectionView.register(UINib(nibName: "\(BookedCell.self)", bundle: Bundle.main), forCellWithReuseIdentifier: BookedCell.reuseIdentifier)
        
        /// Set LocationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        checkLocationService()
        
        addDummyMarkers()
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
        hideMakerInfoView(animate: false)
        
        if listView.isHidden {
            viewContainer.bringSubviewToFront(listView)
            listView.showFlip()
            mapContainer.hideFlip()
            btnToggle.setTitle("MAP", for: .normal)
        } else if mapContainer.isHidden {
            viewContainer.bringSubviewToFront(mapContainer)
            mapContainer.showFlip()
            listView.hideFlip()
            btnToggle.setTitle("LIST", for: .normal)
        }
    }
    
    @IBAction func onClickUserLocation(_ sender: Any) {
        showLocation(userLocation)
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: SearchViewController.storyboardId) as! SearchViewController
        newVC.delegate = self
        let navVC = newVC.getNavigationController()
        navVC.modalPresentationStyle = .overFullScreen
        self.present(navVC, animated: true)
    }
    
    /// Show / Hidden recently booked locations
    @IBAction func onClickArrow(_ sender: Any) {
        updateBottomView(isShow: !isShowBottomView)
        updateFilterView(isShow: false, animate: false)
        hideMakerInfoView(animate: false)
    }
    
    /// Toggle Filters
    @IBAction func onClickFilters(_ sender: Any) {
        updateFilterView(isShow: !isShowFilter)
        updateBottomView(isShow: false, animate: false)
        hideMakerInfoView(animate: false)
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
        updateFilterView(isShow: false)
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
    
    @IBAction func onFilterButtonChanged(_ sender: MDCButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func onInfoBookBtnClick(_ sender: Any) {
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: BookViewController.storyboardId)
        let navVC = newVC.getNavigationController()
        navVC.modalPresentationStyle = .overFullScreen
        self.present(navVC, animated: true)
    }
    
    @IBAction func onInfoDetailsBtnClick(_ sender: Any) {
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: DetailsViewController.storyboardId)
        let navVC = newVC.getNavigationController()
        navVC.modalPresentationStyle = .overFullScreen
        self.present(navVC, animated: true)
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
    
    func showMarkerInfoView(price: String) {
        isShowMarkerInfo = true
        labelInfoPrice.text = price
        viewMarkerInfo.isHidden = false
        viewMarkerInfo.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0.2, animations: {
            self.viewMarkerInfo.alpha = 1
        })
    }
    
    func hideMakerInfoView(animate: Bool = true) {
        isShowMarkerInfo = false
        viewMarkerInfo.isHidden = true
    }
    
    func showLocation(_ coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: Global.defaultRegionRadius, longitudinalMeters: Global.defaultRegionRadius)
        mkMapView.setRegion(region, animated: true)
    }
    
    func addDummyMarkers() {
        let annotation1 = CustomAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 40.7578, longitude: -74.0123)
        annotation1.price = "$35"
        
        let annotation2 = CustomAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 40.7575, longitude: -73.9523)
        annotation2.price = "$14"
        
        let annotation3 = CustomAnnotation()
        annotation3.coordinate = CLLocationCoordinate2D(latitude: 40.7548, longitude: -74.0323)
        annotation3.price = "$25"
        
        let annotation4 = CustomAnnotation()
        annotation4.coordinate = CLLocationCoordinate2D(latitude: 40.7568, longitude: -74.0223)
        annotation4.price = "$28"
        
        let annotation5 = CustomAnnotation()
        annotation5.coordinate = CLLocationCoordinate2D(latitude: 40.7565, longitude: -73.9753)
        annotation5.price = "$34"
        
        mkMapView.addAnnotation(annotation1)
        mkMapView.addAnnotation(annotation2)
        mkMapView.addAnnotation(annotation3)
        mkMapView.addAnnotation(annotation4)
        mkMapView.addAnnotation(annotation5)
    }

}

// MARK: - TableView dataSource
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

// MARK: - TableView delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
}

// MARK: - TableViewCell delegate
extension HomeViewController: HomeCellDelegate {
    func onDetails() {
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: DetailsViewController.storyboardId)
        let navVC = newVC.getNavigationController()
        navVC.modalPresentationStyle = .overFullScreen
        self.present(navVC, animated: true)
    }
    
    func onBook() {
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: BookViewController.storyboardId)
        let navVC = newVC.getNavigationController()
        navVC.modalPresentationStyle = .overFullScreen
        self.present(navVC, animated: true)
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
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: DetailsViewController.storyboardId)
        let navVC = newVC.getNavigationController()
        navVC.modalPresentationStyle = .overFullScreen
        self.present(navVC, animated: true)
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

// MARK: - SearchViewController delegate
extension HomeViewController: SearchDelegate {
    func onDailySearch(mapItem: MKMapItem, startTime: Date, endTime: Date) {
        let coordinate = mapItem.placemark.coordinate
        mkMapView.setCenter(coordinate, animated: true)
    }
    
    func onMonthlySearch(mapItem: MKMapItem, startDate: Date) {
        let coordinate = mapItem.placemark.coordinate
        mkMapView.setCenter(coordinate, animated: true)
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
            Global.currentLocation = location.coordinate
            showLocation(location.coordinate)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}

// MARK: - MKMapView delegate
extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
          return nil
        }
        
        let annotationView = CustomAnnotationView(annotation: annotation as? CustomAnnotation)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? CustomAnnotation {
            showMarkerInfoView(price: annotation.price)
            updateBottomView(isShow: false, animate: false)
            updateFilterView(isShow: false, animate: false)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        hideMakerInfoView()
    }
}

// MARK: - Initialize the UI settings
fileprivate extension HomeViewController {
    func prepareUI() {
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
    
    func prepareMarkerInfoView() {
        viewMarkerInfo.roundCorners(corners: [.allCorners], radius: 8.0)
        viewMarkerInfo.layer.borderWidth = 0.5
        viewMarkerInfo.layer.borderColor = UIColor.iBlack60.cgColor
        viewMarkerInfo.layer.cornerRadius = 8.0
        viewMarkerInfo.layer.masksToBounds = true
        viewMarkerInfo.isHidden = true
        
        imageViewInfoLocation.image = imageViewInfoLocation.image?.withRenderingMode(.alwaysTemplate)
        imageViewInfoLocation.tintColor = UIColor.iGray
        
        prepareInfoBookButton()
        prepareInfoDetailsButton()
    }
    
    func prepareHeaderButtons() {
        let scheme = MDCContainerScheme()
        scheme.colorScheme.primaryColor = .white
        scheme.colorScheme.onPrimaryColor = .iBlack90
        scheme.typographyScheme.button = LatoFont.medium(with: 11)
        btnToggle.applyContainedTheme(withScheme: scheme)
        btnToggle.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        btnSearch.applyContainedTheme(withScheme: scheme)
        btnSearch.isUppercaseTitle = false
        
        btnFavorite.applyTextTheme(withScheme: Global.textButtonScheme())
        btnFavorite.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        btnHours.applyTextTheme(withScheme: Global.textButtonScheme())
        
        btnFilters.applyContainedTheme(withScheme: Global.mediumButtonScheme())
    }
    
    func prepareFilterButtons() {
        btnApplyFilters.applyContainedTheme(withScheme: Global.mediumButtonScheme())
        
        btnClear.applyTextTheme(withScheme: Global.mediumTextButtonScheme())
        btnClear.isUppercaseTitle = false
        
        checkBtn24Hours.applyTextTheme(withScheme: Global.mediumTextButtonScheme())
        checkBtn24Hours.isUppercaseTitle = false
        
        checkBtn7Days.applyTextTheme(withScheme: Global.mediumTextButtonScheme())
        checkBtn7Days.isUppercaseTitle = false
        
        checkBtnCovered.applyTextTheme(withScheme: Global.mediumTextButtonScheme())
        checkBtnCovered.isUppercaseTitle = false
        
        checkBtnPaved.applyTextTheme(withScheme: Global.mediumTextButtonScheme())
        checkBtnPaved.isUppercaseTitle = false
        
        checkBtnValet.applyTextTheme(withScheme: Global.mediumTextButtonScheme())
        checkBtnValet.isUppercaseTitle = false
        
        checkBtnOversizedVehicles.applyTextTheme(withScheme: Global.mediumTextButtonScheme())
        checkBtnOversizedVehicles.isUppercaseTitle = false
        
        checkBtnGreen.applyTextTheme(withScheme: Global.mediumTextButtonScheme())
        checkBtnGreen.isUppercaseTitle = false
        
        checkBtnTesla.applyTextTheme(withScheme: Global.mediumTextButtonScheme())
        checkBtnTesla.isUppercaseTitle = false
        
        checkBtnOutdoors.applyTextTheme(withScheme: Global.mediumTextButtonScheme())
        checkBtnOutdoors.isUppercaseTitle = false
        
        checkBtnOnSiteStaff.applyTextTheme(withScheme: Global.mediumTextButtonScheme())
        checkBtnOnSiteStaff.isUppercaseTitle = false
        
    }
    
    func prepareCurrentLocationButton() {
        let scheme = MDCContainerScheme()
        scheme.colorScheme.primaryColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.8)
        btnCurrentLocation.applyContainedTheme(withScheme: scheme)
    }
    
    func prepareInfoBookButton() {
        let textString = NSMutableAttributedString(
            string: btnInfoBook.title(for: .normal)!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.black(with: 9),
                NSAttributedString.Key.foregroundColor: btnInfoBook.titleColor(for: .normal)!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 1.2, range: textRange)
        btnInfoBook.setAttributedTitle(textString, for: .normal)
        btnInfoBook.applyContainedTheme(withScheme: Global.tinyButtonScheme())
        btnInfoBook.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
    }
    
    func prepareInfoDetailsButton() {
        let textString = NSMutableAttributedString(
            string: btnInfoDetails.title(for: .normal)!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.black(with: 9),
                NSAttributedString.Key.foregroundColor: btnInfoDetails.titleColor(for: .normal)!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 1.2, range: textRange)
        btnInfoDetails.setAttributedTitle(textString, for: .normal)
        btnInfoDetails.setImage(UIImage(named: "icon-details")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnInfoDetails.tintColor = UIColor.iBlack90
        btnInfoDetails.applyOutlinedTheme(withScheme: Global.tinyOutlinedButtonScheme())
        btnInfoDetails.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        btnInfoDetails.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
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
