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
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedCell.reuseIdentifier, for: indexPath)
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
}

fileprivate extension FavoriteViewController {
    func prepareNavigation() {
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(onBackClick))
        leftButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: LatoFont.bold(with: 20)]
    }
}
