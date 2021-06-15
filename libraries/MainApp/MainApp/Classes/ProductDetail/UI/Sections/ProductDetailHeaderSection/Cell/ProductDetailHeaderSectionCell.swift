//
//  ProductDetailHeaderSectionCell.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 06/05/21.
//

import UIKit
import ChofyExtensions
import ChofyStyleGuide

final class ProductDetailHeaderSectionCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: ProductDetailHeaderSectionCell.self)
    
    @IBOutlet private weak var headerImageView: UIImageView! {
        didSet {
            headerImageView.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet private weak var headerTitle: UILabel! {
        didSet {
            headerTitle.font = ChofyFontCatalog.h2Bold
            headerTitle.numberOfLines = 2
        }
    }
    @IBOutlet private weak var priceContainer: UIView! {
        didSet {
            priceContainer.backgroundColor = ChofyColors.card
            priceContainer.layer.cornerRadius = 8
        }
    }
    @IBOutlet private weak var priceLabel: UILabel! {
        didSet {
            priceLabel.font = ChofyFontCatalog.h2Black
            priceLabel.textColor = ChofyColors.textObscure
        }
    }
    
    func setup(image: String, name: String, price: String?) {
        headerImageView.find(url: image, placeholder: ChofyImages.notAvailable)
        headerTitle.text = name
        priceLabel.text = price
    }
}
