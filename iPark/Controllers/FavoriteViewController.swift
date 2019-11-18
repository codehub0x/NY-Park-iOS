//
//  FavoriteViewController.swift
//  iPark
//
//  Created by King on 2019/11/16.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation()
        tableView.register(UINib(nibName: "\(SavedCell.self)", bundle: Bundle.main), forCellReuseIdentifier: SavedCell.reuseIdentifier)
    }
    
    @objc func onBackClick() {
        self.dismiss(animated: true)
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedCell.reuseIdentifier, for: indexPath) as! SavedCell
        cell.delegate = self
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
}

extension FavoriteViewController: SavedCellDelegate {
    func onDetails() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var detailsVC: UIViewController!
        if #available(iOS 13.0, *) {
            detailsVC = storyboard.instantiateViewController(identifier: "DetailsViewController")
        } else {
            // Fallback on earlier versions
            detailsVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController")
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func onBook() {
        
    }
    
    
}

fileprivate extension FavoriteViewController {
    func prepareNavigation() {
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        leftButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: LatoFont.bold(with: 20)]
    }
}
