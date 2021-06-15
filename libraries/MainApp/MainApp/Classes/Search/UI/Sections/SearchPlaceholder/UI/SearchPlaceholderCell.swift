//
//  SearchPlaceholderCell.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 18/04/21.
//

import UIKit
import ChofyStyleGuide

final class SearchPlaceholderCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: SearchPlaceholderCell.self)
    
    @IBOutlet private weak var animationContainer: UIView! {
        didSet {
            animationContainer.backgroundColor = UIColor.clear
            animationContainer.addAndFit(subview: ChofyAnim.search)
        }
    }
    @IBOutlet private weak var messageLabel: UILabel! {
        didSet {
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = ChofyFontCatalog.headlineBold
        }
    }
    
    func setup(message: String) {
        messageLabel.text = message
    }
}
