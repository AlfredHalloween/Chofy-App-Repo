//
//  SearchResultsCell.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 19/04/21.
//

import UIKit
import ChofyStyleGuide

final class SearchResultsCell: UICollectionViewCell {
    
    // MARK: Properties
    static let identifier: String = String(describing: SearchResultsCell.self)
    
    // MARK: Outlets
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productName: UILabel! {
        didSet {
            productName.font = ChofyFontCatalog.bodyBold
            productName.numberOfLines = 2
        }
    }
    @IBOutlet private weak var productDescription: UILabel! {
        didSet {
            productDescription.font = ChofyFontCatalog.captionOneRegular
        }
    }
    @IBOutlet private weak var productPrice: UILabel! {
        didSet {
            productPrice.textAlignment = .right
            productPrice.font = ChofyFontCatalog.headlineBlack
        }
    }
    @IBOutlet private weak var divider: UIView! {
        didSet {
            divider.backgroundColor = ChofyColors.dividerCell
        }
    }
    
    func setup(image: String,
               name: String,
               description: String,
               price: String?,
               isLast: Bool) {
        productImage.find(url: image, placeholder: ChofyImages.notAvailable)
        productName.text = name
        productDescription.text = description
        productPrice.text = price
        divider.isHidden = isLast
        divider.alpha = isLast ? 0.0 : 1.0
    }
}
