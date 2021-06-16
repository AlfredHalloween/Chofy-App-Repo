//
//  GenericSelectorOptionCell.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 09/06/21.
//

import UIKit
import ChofyExtensions
import ChofyStyleGuide

final class GenericSelectorOptionCell: UICollectionViewCell {
    
    // MARK: Outlets
    @IBOutlet private weak var containerImage: UIView! {
        didSet {
            containerImage.roundedView()
            containerImage.backgroundColor = ChofyColors.card
        }
    }
    @IBOutlet private weak var caseLabel: UILabel! {
        didSet {
            caseLabel.isHidden = true
            caseLabel.alpha = 0.0
            caseLabel.textColor = ChofyColors.textObscure
            caseLabel.font = ChofyFontCatalog.headlineBold
        }
    }
    @IBOutlet private weak var optionImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = ChofyFontCatalog.bodyRegular
        }
    }
    @IBOutlet private weak var arrowImage: UIImageView! {
        didSet {
            let image: UIImage = ChofyIcons.rightArrow.withRenderingMode(.alwaysTemplate)
            arrowImage.image = image
            arrowImage.tintColor = ChofyColors.card
        }
    }
    @IBOutlet private weak var divider: UIView! {
        didSet {
            divider.backgroundColor = ChofyColors.dividerCell
        }
    }
    
    func setup(image: String?, name: String?, isLast: Bool) {
        if let image = image {
            caseLabel.isHidden = true
            caseLabel.alpha = 0.0
            optionImage.find(url: image)
        } else {
            caseLabel.isHidden = false
            caseLabel.alpha = 1.0
            caseLabel.text = String(name?.prefix(1) ?? "")
            optionImage.find(url: "")
        }
        nameLabel.text = name
        divider.isHidden = isLast
        divider.alpha = isLast ? 0.0 : 1.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        caseLabel.isHidden = true
        caseLabel.alpha = 0.0
    }
}
