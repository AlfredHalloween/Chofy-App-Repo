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
        guard let context = collectionContext else {
            return UICollectionViewCell()
        }
        let cell: ProductDetailHeaderSectionCell = context
            .dequeueReusableCell(withNibName: ProductDetailHeaderSectionCell.identifier,
                                 bundle: MainBundle.bundle,
                                 for: self,
                                 at: index) as! ProductDetailHeaderSectionCell
        if let item = diffable {
            cell.setup(image: item.image,
                       name: item.name,
                       price: item.price.toCurrency())
        }
        return cell
    }
    
    override func didUpdate(to object: Any) {
        diffable = object as? ProductDetailHeaderDiffable
    }
}
