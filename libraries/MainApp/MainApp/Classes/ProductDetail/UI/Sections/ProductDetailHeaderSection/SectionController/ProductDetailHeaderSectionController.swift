//
//  ProductDetailHeaderSectionController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 06/05/21.
//

import Foundation
import IGListKit

final class ProductDetailHeaderSectionController: ListSectionController {
    
    private var diffable: ProductDetailHeaderDiffable?
    
    override func sizeForItem(at index: Int) -> CGSize {
        let cellWidth: CGFloat = UIScreen.main.bounds.width
        let cellHeight: CGFloat = cellWidth * 0.75
        return CGSize(width: cellWidth, height: cellHeight + 72)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: ProductDetailHeaderSectionCell = reuse(for: index, with: MainBundle.bundle)
        if let item = diffable {
            cell.setup(image: item.image, name: item.name, price: item.price.toCurrency())
        }
        return cell
    }
    
    override func didUpdate(to object: Any) {
        diffable = object as? ProductDetailHeaderDiffable
    }
}
