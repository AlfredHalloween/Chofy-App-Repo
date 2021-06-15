//
//  HomeSectionHeaderView.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 16/04/21.
//

import UIKit
import ChofyExtensions

final class HomeSectionHeaderView: UICollectionReusableView {
    
    static let identifier: String = String(describing: HomeSectionHeaderView.self)
        
    @IBOutlet private weak var titleHeader: UILabel! {
        didSet {
            titleHeader.numberOfLines = 0
            titleHeader.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        }
    }
    @IBOutlet private weak var subtitleHeader: UILabel! {
        didSet {
            subtitleHeader.numberOfLines = 0
            subtitleHeader.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        }
    }
    
    func setup(title: String, subtitle: String) {
        titleHeader.text = title
        subtitleHeader.text = subtitle
    }
    
    static func getCellSize(with width: CGFloat,
                            title: String,
                            subtitle: String) -> CGSize {
        let labelWidth: CGFloat = width - 16
        let verticalMargin: CGFloat = 24
        let titleHeight = title.height(with: labelWidth,
                                       font: UIFont.systemFont(ofSize: 28, weight: .semibold))
        let subtitleHeight = subtitle.height(with: labelWidth,
                                             font: UIFont.systemFont(ofSize: 20, weight: .regular))
        let cellHeight: CGFloat = verticalMargin + titleHeight + subtitleHeight
        return CGSize(width: width, height: cellHeight)
    }
}
