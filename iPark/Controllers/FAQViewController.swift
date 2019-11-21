//
//  FAQViewController.swift
//  iPark
//
//  Created by King on 2019/11/21.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Material

struct FAQSection {
    let title: String
    let items: [FAQItem]
    
    init(title: String, items: [FAQItem]) {
        self.title = title
        self.items = items
    }
}

enum SectionOperation {
    case sectionExpand
    case sectionCollapse
}

class FAQViewController: UIViewController {
    
    static let storyboardId = "\(FAQViewController.self)"
    
    @IBOutlet weak var tableView: UITableView!
    
    var data: [FAQSection]!
    var expandedSections = [SectionOperation]()
    var expandedCells = [Int: [CellOperation]]()
    var heightAtIndexPath = NSMutableDictionary()
    var multipleSelect = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation()
        
        tableView.register(UINib(nibName: "\(FAQViewCell.self)", bundle: Bundle.main), forCellReuseIdentifier: FAQViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func initData() {
        let items = [FAQItem(question: "What is reddit?", answer: "reddit is a source for what's new and popular on the web. Users like you provide all of the content and decide, through voting, what's good and what's junk. Links that receive community approval bubble up towards #1, so the front page is constantly in motion and (hopefully) filled with fresh, interesting links."), FAQItem(question: "What does the name \"reddit\" mean?", answer: "It's (sort of) a play on words -- i.e., \"I read it on reddit.\" Also, there are some unintentional but interesting Latin meanings to the word \"reddit\"."), FAQItem(question: "How is a submission's score determined?", answer: "A submission's score is simply the number of upvotes minus the number of downvotes. If five users like the submission and three users don't it will have a score of 2. Please note that the vote numbers are not \"real\" numbers, they have been \"fuzzed\" to prevent spam bots etc. So taking the above example, if five users upvoted the submission, and three users downvote it, the upvote/downvote numbers may say 23 upvotes and 21 downvotes, or 12 upvotes, and 10 downvotes. The points score is correct, but the vote totals are \"fuzzed\".")]
        data = [
            FAQSection(title: "How it works", items: items),
            FAQSection(title: "What is iPark", items: items),
            FAQSection(title: "Booking", items: items),
            FAQSection(title: "Monthly Parking", items: items),
            FAQSection(title: "Post Purchase", items: items),
            FAQSection(title: "Parking Pass", items: items),
            FAQSection(title: "Commercial Accounts", items: items),
            FAQSection(title: "Account/Billing", items: items)
        ]
        
        expandedSections = Array(repeating: SectionOperation.sectionCollapse, count: data.count)
        for (index, item) in data.enumerated() {
            expandedCells[index] = Array(repeating: CellOperation.collapsed, count: item.items.count)
        }
        tableView.reloadData()
    }
    
    @objc func onBackClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didSelectSection(_ gesture: UITapGestureRecognizer) {
        let v = gesture.view!
        let section = v.tag
        
        updateSection(section)
    }
}

// MARK: - TableView data source
extension FAQViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if expandedSections[section] == .sectionCollapse {
            return 0
        } else {
            return data[section].items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FAQViewCell.reuseIdentifier, for: indexPath) as! FAQViewCell
        cell.delegate = self
        let currentItem = data[indexPath.section].items[indexPath.row]
        let cellOperation = expandedCells[indexPath.section]![indexPath.row]
        cell.configure(currentItem: currentItem, indexPath: indexPath, cellOperation: cellOperation)
        updateCellOperation(indexPath: indexPath, cellOperation: cellOperation)
        
        return cell
    }
    
}

// MARK: - TableView delegate
extension FAQViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = self.heightAtIndexPath.object(forKey: indexPath) {
            return CGFloat(height as! CGFloat)
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let height = cell.frame.size.height
        self.heightAtIndexPath.setObject(height, forKey: indexPath as NSCopying)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))

        let label = UILabel()
        label.frame = CGRect.init(x: 32, y: 10, width: headerView.frame.width - 50, height: headerView.frame.height - 20)
        label.text = data[section].title
        label.font = LatoFont.regular(with: 23.33)
        label.textColor = UIColor.iDarkBlue

        headerView.addSubview(label)
        headerView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectSection(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        
        headerView.tag = section
        headerView.addGestureRecognizer(tapGesture)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 5))
        let separatorView = UIView(frame: CGRect(x: 8, y: 4, width: tableView.frame.width - 16, height: 0.5))
        separatorView.backgroundColor = UIColor.iBlack70
        footerView.addSubview(separatorView)
        return footerView
    }
    
}

// MARK: - FAQSectionCell delegate
extension FAQViewController: FAQViewCellDelegate {
    func didSelectQuestion(indexPath: IndexPath) {
        updateRow(indexPath)
    }
}

fileprivate extension FAQViewController {
    func prepareNavigation() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "FAQ"
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon-arrow-left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(onBackClick))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func updateCellOperation(indexPath: IndexPath, cellOperation: CellOperation) {
        if cellOperation == .expand {
            expandedCells[indexPath.section]![indexPath.row] = .expanded
        } else if cellOperation == .collapse {
            expandedCells[indexPath.section]![indexPath.row] = .collapsed
        }
    }
    
    func updateSection(_ section: Int) {
        if !multipleSelect {
            for (index, item) in data.enumerated() {
                if index != section {
                    expandedSections[index] = .sectionCollapse
                    expandedCells[index] = Array(repeating: .collapsed, count: item.items.count)
                }
            }
            tableView.reloadData()
        }
        if expandedSections[section] == .sectionExpand {
            expandedSections[section] = .sectionCollapse
            expandedCells[section] = Array(repeating: .collapsed, count: data[section].items.count)
        } else {
            expandedSections[section] = .sectionExpand
        }
        tableView.reloadSections(IndexSet(integer: section), with: .fade)
    }
    
    func updateRow(_ indexPath: IndexPath) {
        if !multipleSelect {
            for (index, _) in expandedCells.enumerated() {
                for (subIndex, _) in (expandedCells[index]?.enumerated())! {
                    if !(index == indexPath.section && subIndex == indexPath.row) {
                        expandedCells[index]![subIndex] = .collapsed
                    }
                }
            }
            tableView.reloadData()
        }
        if expandedCells[indexPath.section]![indexPath.row] == .expanded {
            expandedCells[indexPath.section]![indexPath.row] = .collapse
        } else {
            expandedCells[indexPath.section]![indexPath.row] = .expand
        }
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .fade)
        tableView.reloadRows(at: [indexPath], with: .fade)
        tableView.scrollToRow(at: IndexPath(row: indexPath.row, section: indexPath.section), at: .top, animated: true)
    }
}

