//
//  FAQItemCell.swift
//  iPark
//
//  Created by King on 2019/11/21.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

protocol FAQViewCellDelegate {
    func didSelectQuestion(indexPath: IndexPath)
}

class FAQViewCell: UITableViewCell {
    
    static let reuseIdentifier = "\(FAQViewCell.self)"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var indicatorImageView: UIImageView!
    @IBOutlet weak var answerLabelBottom: NSLayoutConstraint!
    
    var delegate: FAQViewCellDelegate!
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareCardView()
        prepareIndicatorImageView()
        selectionSetup()
    }
    
    @objc func didTapQuestion(_ recognizer: UIGestureRecognizer) {
        if delegate != nil {
            delegate.didSelectQuestion(indexPath: indexPath)
        }
    }
    
    func configure(currentItem: FAQItem, indexPath: IndexPath, cellOperation: CellOperation) {
        self.indexPath = indexPath
        questionLabel.text = currentItem.question
        switch cellOperation {
        case .collapsed:
            collapse(animated: false)
        case .expand:
            if let answer = currentItem.answer {
                expand(withAnswer: answer, animated: true)
            }
        case .collapse:
            collapse(animated: true)
        case .expanded:
            if let answer = currentItem.answer {
                expand(withAnswer: answer, animated: false)
            }
        }
    }
}

// MARK: - Private Methods
fileprivate extension FAQViewCell {
    func prepareCardView() {
        cardView.layer.cornerRadius = 6
        cardView.layer.borderColor = UIColor.iBlack70.cgColor
        cardView.layer.borderWidth = 0.5
        cardView.layer.masksToBounds = true
    }
    
    func prepareIndicatorImageView() {
        indicatorImageView.image = indicatorImageView.image?.withRenderingMode(.alwaysTemplate)
        indicatorImageView.tintColor = UIColor.iBlack95
    }
    
    private func selectionSetup() {
        questionLabel.isUserInteractionEnabled = true
        indicatorImageView.isUserInteractionEnabled = true
        let questionLabelGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapQuestion(_:)))
        questionLabel.addGestureRecognizer(questionLabelGestureRecognizer)
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapQuestion(_:)))
        indicatorImageView.addGestureRecognizer(imageGestureRecognizer)
    }
    
    private func expand(withAnswer answer: String, animated: Bool) {
        answerLabel.text = answer
        expand(animated: animated)
    }
    
    private func expand(animated: Bool) {
        answerLabel.isHidden = false
        if animated {
            answerLabel.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.answerLabel.alpha = 1
            })
        }
        answerLabelBottom.constant = 20
        update(arrow: .up, animated: animated)
    }
    
    private func collapse(animated: Bool) {
        answerLabel.text = ""
        answerLabel.isHidden = true
        answerLabelBottom.constant = 0
        update(arrow: .down, animated: animated)
    }
    
    private func update(arrow: Arrow, animated: Bool) {
        switch arrow {
        case .up:
            if animated {
                // Change direction from down to up with animation
                self.indicatorImageView.rotate(withAngle: CGFloat(0), animated: false)
                self.indicatorImageView.rotate(withAngle: CGFloat(Double.pi), animated: true)
            } else {
                // Change direction from down to up without animation
                self.indicatorImageView.rotate(withAngle: CGFloat(Double.pi), animated: false)
            }
            self.indicatorImageView.tintColor = UIColor.iDarkBlue
            self.questionLabel.textColor = UIColor.iDarkBlue
            self.cardView.layer.borderColor = UIColor.iDarkBlue.cgColor
        case .down:
            if animated {
                // Change direction from up to down with animation
                self.indicatorImageView.rotate(withAngle: CGFloat(Double.pi), animated: false)
                self.indicatorImageView.rotate(withAngle: CGFloat(0), animated: true)
            } else {
                // Change direction from up to down without animation
                self.indicatorImageView.rotate(withAngle: CGFloat(0), animated: false)
            }
            self.indicatorImageView.tintColor = UIColor.iBlack95
            self.questionLabel.textColor = UIColor.iBlack95
            self.cardView.layer.borderColor = UIColor.iBlack70.cgColor
        }
    }
}

public struct FAQItem {
    public let question: String
    public let answer: String?

    public init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}

enum Arrow: String {
    case up
    case down
}

enum CellOperation {
    case collapsed
    case expand
    case expanded
    case collapse
}
