//
//  HomeSectionCell.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 16/04/21.
//

import UIKit
import ChofyStyleGuide

final class HomeSectionCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: HomeSectionCell.self)
    
    @IBOutlet private weak var cellContent: UIView! {
        didSet {
            cellContent.backgroundColor = ChofyColors.card
            cellContent.layer.cornerRadius = 12
        }
    }
    @IBOutlet private weak var sectionImage: UIImageView!
    @IBOutlet private weak var sectionName: UILabel! {
        didSet {
            sectionName.numberOfLines = 0
            sectionName.textColor = ChofyColors.textObscure
        }
    }
    
    func setup(image: String, name: String) {
        sectionImage.find(url: image)
        sectionName.text = name
    }
}
