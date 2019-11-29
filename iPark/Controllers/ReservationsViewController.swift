//
//  ReservationsViewController.swift
//  iPark
//
//  Created by King on 2019/11/13.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

enum ReservationType {
    case upcoming
    case past
    case cancelled
}

class ReservationsViewController: UIViewController {
    
    static let storyboardId = "\(ReservationsViewController.self)"
    
    @IBOutlet weak var tabBar: TabBar!
    fileprivate var buttons = [TabItem]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation()
        prepareButtons()
        prepareTabBar()
        
        tableView.register(UINib(nibName: "\(ReservationCell.self)", bundle: Bundle.main), forCellReuseIdentifier: ReservationCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func onBackClick() {
        if let count = self.navigationController?.viewControllers.count, count > 1 {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
}

fileprivate extension ReservationsViewController {
    func prepareNavigation() {
        self.navigationItem.title = "My Reservations"
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func prepareButtons() {
        let btn1 = TabItem(title: "Upcoming", titleColor: Color.white)
        btn1.pulseAnimation = .centerRadialBeyondBounds
        btn1.setTabItemColor(UIColor.iYellow, for: .selected)
        btn1.setTabItemColor(UIColor.white, for: .normal)
        btn1.titleLabel?.font = LatoFont.bold(with: 15)
        btn1.tag = 1
        buttons.append(btn1)
       
        let btn2 = TabItem(title: "Past", titleColor: Color.white)
        btn2.pulseAnimation = .centerRadialBeyondBounds
        btn2.setTabItemColor(UIColor.iYellow, for: .selected)
        btn2.setTabItemColor(UIColor.white, for: .normal)
        btn2.titleLabel?.font = LatoFont.bold(with: 15)
        btn2.tag = 2
        buttons.append(btn2)
        
        let btn3 = TabItem(title: "Canceled", titleColor: Color.white)
        btn3.pulseAnimation = .centerRadialBeyondBounds
        btn3.setTabItemColor(UIColor.iYellow, for: .selected)
        btn3.setTabItemColor(UIColor.white, for: .normal)
        btn3.titleLabel?.font = LatoFont.bold(with: 15)
        btn3.tag = 3
        buttons.append(btn3)
    }
    
    func prepareTabBar() {
        tabBar.delegate = self
        
        tabBar.backgroundColor = UIColor.iDarkBlue
        
        tabBar.dividerColor = UIColor.iBlack80
        tabBar.dividerAlignment = .top
        tabBar.dividerThickness = 0.3
        
        tabBar.lineColor = UIColor.iYellow
        tabBar.lineAlignment = .bottom
        tabBar.lineHeight = 4
        
        tabBar.tabItems = buttons
    }
}

extension ReservationsViewController: TabBarDelegate {
    @objc
    func tabBar(tabBar: TabBar, willSelect tabItem: TabItem) {
        print("will select")
    }
    
    @objc
    func tabBar(tabBar: TabBar, didSelect tabItem: TabItem) {
        print("did select")
        tableView.reloadData()
    }
}

extension ReservationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReservationCell.reuseIdentifier, for: indexPath) as! ReservationCell
        cell.delegate = self
        switch tabBar.selectedTabItem?.tag {
        case 1:
            cell.reservationType = .upcoming
            break
        case 2:
            cell.reservationType = .past
            break
        case 3:
            cell.reservationType = .cancelled
            break
        default:
            cell.reservationType = .upcoming
            break
        }
        return cell
    }
}

extension ReservationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ReservationsViewController: ReservationCellDelegate {
    func onDetails() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var detailsVC: UIViewController!
        let tag = tabBar.selectedTabItem?.tag
        if tag == 1 {
            detailsVC = storyboard.instantiateViewController(withIdentifier: UpcomingDetailsViewController.storyboardId)
        } else {
            detailsVC = storyboard.instantiateViewController(withIdentifier: DetailsViewController.storyboardId)
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func onDirections() {
        
    }
    
    func onRebook() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: BookViewController.storyboardId)
        self.navigationController?.pushViewController(newVC, animated: true)
    }
}
