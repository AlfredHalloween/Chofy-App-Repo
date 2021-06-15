//
//  ProductDetailDescriptionCell.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 10/06/21.
//

import UIKit
import ChofyStyleGuide

final class ProductDetailDescriptionCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: ProductDetailDescriptionCell.self)
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
            titleLabel.font = ChofyFontCatalog.headlineBold
        }
    }
    
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
            descriptionLabel.font = ChofyFontCatalog.bodyRegular
        }
    }
    
    func setup(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    static func getCellSize(width: CGFloat,
                            title: String,
                            description: String) -> CGSize {
        let textWidth: CGFloat = width - 32
        let margin: CGFloat = 24
        let titleHeight: CGFloat = title.height(with: textWidth,
                                                font: ChofyFontCatalog.headlineBold)
        let descriptionHeight: CGFloat = description.height(with: textWidth,
                                                            font: ChofyFontCatalog.bodyRegular)
        let height = margin + titleHeight + descriptionHeight
        return CGSize(width: width, height: height)
    }
}
