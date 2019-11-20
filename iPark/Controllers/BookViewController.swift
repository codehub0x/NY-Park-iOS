//
//  BookViewController.swift
//  iPark
//
//  Created by King on 2019/11/19.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

class BookViewController: UIViewController {
    
    static let storyboardId = "\(BookViewController.self)"
    
    @IBOutlet weak var labelDays: UILabel!
    @IBOutlet weak var labelHours: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelVehicle: UILabel!
    @IBOutlet weak var labelPayment: UILabel!
    @IBOutlet weak var switchMultipleDays: UISwitch!
    @IBOutlet weak var labelTotalName: UILabel!
    @IBOutlet weak var labelTotalPrice: UILabel!
    @IBOutlet weak var btnAddpayment: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var bookData: [Any]! = []
    
    fileprivate var mainStoryboard: UIStoryboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        prepareNavigation(title: "West 90TH Garage Corp.", subTitle: "7 East 14th Street, New York, NY...")
        prepareAddPaymentButton()
        
        collectionView.register(UINib(nibName: "\(BookCell.self)", bundle: Bundle.main), forCellWithReuseIdentifier: BookCell.reuseIdentifier)
        
        initBookData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    fileprivate func initBookData() {
        let now = Date()
        bookData.append(["date": now, "value": "$11.95", "valid": true])
        bookData.append(["date": now.add(days: 1)!, "value": "$11.95", "valid": true])
        bookData.append(["date": now.add(days: 2)!, "value": "$11.95", "valid": true])
        bookData.append(["date": now.add(days: 3)!, "value": "SOLD OUT", "valid": false])
        bookData.append(["date": now.add(days: 4)!, "value": "$11.95", "valid": true])
        bookData.append(["date": now.add(days: 5)!, "value": "$11.95", "valid": true])
        bookData.append(["date": now.add(days: 6)!, "value": "$11.95", "valid": true])
        
        collectionView.reloadData()
    }
    
    @objc func onBackClick() {
        if let count = self.navigationController?.viewControllers.count, count > 1 {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func onVehicleBtnClick(_ sender: Any) {
        let newVC: UIViewController!
        if #available(iOS 13.0, *) {
            newVC = mainStoryboard.instantiateViewController(identifier: VehiclesViewController.storyboardId)
        } else {
            // Fallback on earlier versions
            newVC = mainStoryboard.instantiateViewController(withIdentifier: VehiclesViewController.storyboardId)
        }
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func onPaymentBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onPromoCodeBtnClick(_ sender: Any) {
        
    }
    
    @IBAction func onAddPaymentBtnClick(_ sender: Any) {
        
    }
    
    func deselectAllItems(except: IndexPath) {
        for (index, _) in bookData.enumerated() {
            if index != except.row {
                if let cell = collectionView.cellForItem(at: IndexPath(row: index, section: except.section)) as? BookCell {
                    cell.button.isSelected = false
                }
            }
        }
    }
}

// MARK: - CollectionView datasource
extension BookViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCell.reuseIdentifier, for: indexPath) as! BookCell
        cell.configure(bookData[indexPath.row] as! [String: Any], indexPath: indexPath)
        cell.delegate = self
        return cell
    }
}

// MARK: - CollectionView delegate
extension BookViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - Collection View Flow Layout Delegate
extension BookViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 58, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
    }
}

// MARK: - BooKCell delegate
extension BookViewController: BookCellDelegate {
    func onItemClick(_ indexPath: IndexPath) {
        if !switchMultipleDays.isOn {
            deselectAllItems(except: indexPath)
        }
    }
}

fileprivate extension BookViewController {
    func prepareNavigation(title: String, subTitle: String) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.setTwoLineTitle(lineOne: title, lineTwo: subTitle)
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func prepareAddPaymentButton() {
        let textString = NSMutableAttributedString(
            string: btnAddpayment.title(for: .normal)!,
            attributes: [
                NSAttributedString.Key.font: LatoFont.black(with: 18),
                NSAttributedString.Key.foregroundColor: btnAddpayment.titleColor(for: .normal)!
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 1, range: textRange)
        btnAddpayment.setAttributedTitle(textString, for: .normal)
    }
}
