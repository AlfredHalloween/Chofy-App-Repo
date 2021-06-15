//
//  PageCell.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 16/04/21.
//

import UIKit

final class PageCell: UICollectionViewCell {
    
    // MARK: Properties
    static let identifier: String = String(describing: PageCell.self)
    
    // MARK: Outlets
    @IBOutlet private weak var imagePage: UIImageView! {
        didSet {
            imagePage.layer.cornerRadius = 12
            imagePage.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet private weak var labelPage: UILabel!
    
    // MARK: Methods
    func setup(image: String, label: String) {
        imagePage.find(url: image)
        labelPage.text = label
    }
}
