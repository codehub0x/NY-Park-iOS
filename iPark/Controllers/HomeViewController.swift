//
//  HomeViewController.swift
//  iPark
//
//  Created by King on 2019/11/13.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var btnToggle: UIButton!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var btnFilters: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var imageTime: UIImageView!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var mkMapView: MKMapView!
    @IBOutlet weak var listView: UIView!
    
    private var isShowBottomView: Bool = false {
        didSet {
            bottomView.layoutIfNeeded()
            if isShowBottomView {
                UIView.animate(withDuration: 1) {
                    self.bottomHeightConstraint.constant = 160
                    self.bottomView.layoutIfNeeded()
                    self.btnArrow.setImage(UIImage(named: "icon-down-arrow.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    self.btnArrow.tintColor = UIColor.iBlack90
                }
            } else {
                UIView.animate(withDuration: 1) {
                    self.bottomHeightConstraint.constant = 0
                    self.bottomView.layoutIfNeeded()
                    self.btnArrow.setImage(UIImage(named: "icon-up-arrow.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    self.btnArrow.tintColor = UIColor.iBlack90
                }
            }
        }
    }
    
    private var isShowFilter: Bool = false {
        didSet {
            if isShowFilter {
                UIView.animate(withDuration: 1) {
                    self.filterWidthConstraint.constant = 240
                    self.btnFilters.setTitle("CLOSE", for: .normal)
                    self.btnFilters.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
                }
            } else {
                UIView.animate(withDuration: 1) {
                    self.filterWidthConstraint.constant = 0
                    self.btnFilters.setTitle("FILTERS", for: .normal)
                    self.btnFilters.setImage(UIImage(), for: .normal)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func onClickToggle(_ sender: Any) {
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
    
    @IBAction func onClickFavorite(_ sender: Any) {
        
    }
    
    @IBAction func onClickArrow(_ sender: Any) {
        isShowBottomView = !isShowBottomView
    }
    
    @IBAction func onClickFilters(_ sender: Any) {
        isShowFilter = !isShowFilter
    }


}

fileprivate extension HomeViewController {
    func prepareUI() {
        btnToggle.roundCorners(corners: [.allCorners], radius: 4.0)
        btnFilters.roundCorners(corners: [.allCorners], radius: 4.0)
        btnSearch.roundCorners(corners: [.allCorners], radius: 4.0)
        btnArrow.roundCorners(corners: [.topLeft, .topRight], radius: 18.0)
        btnArrow.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        viewDetails.roundCorners(corners: [.allCorners], radius: 8.0)
        viewDetails.layer.borderWidth = 0.5
        viewDetails.layer.borderColor = UIColor.iBlack60.cgColor
        viewDetails.layer.cornerRadius = 8.0
        viewDetails.layer.masksToBounds = true
        
        // Set image color
        btnFavorite.setImage(UIImage(named: "icon-favorite.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnFavorite.tintColor = UIColor.white
        btnArrow.setImage(UIImage(named: "icon-up-arrow.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnArrow.tintColor = UIColor.iBlack90
        imageTime.image = imageTime.image?.withRenderingMode(.alwaysTemplate)
        imageTime.tintColor = UIColor.white
    }
}
