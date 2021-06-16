//
//  ProductDetailDescriptionSectionController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 10/06/21.
//

import Foundation
import IGListKit

final class ProductDetailDescriptionSectionController: ListSectionController {
    
    private var diffable: ProductDetailDescriptionDiffable?
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext,
              let item = diffable else {
            return .zero
        }
        let width: CGFloat = context.containerSize.width
        return ProductDetailDescriptionCell.getCellSize(width: width,
                                                        title: item.title,
                                                        description: item.description)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: ProductDetailDescriptionCell = reuse(for: index, with: MainBundle.bundle)
        if let item = diffable {
            cell.setup(title: item.title, description: item.description)
        }
        return cell
    }
    
    override func didUpdate(to object: Any) {
        diffable = object as? ProductDetailDescriptionDiffable
    }
}
