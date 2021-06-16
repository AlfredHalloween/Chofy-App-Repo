//
//  SearchResultsSectionController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 19/04/21.
//

import Foundation
import IGListKit

protocol SearchResultsSectionControllerDelegate: NSObject {
    func didSelectProduct(_ product: Product)
}

final class SearchResultsSectionController: ListSectionController {
    
    // MARK: Properties
    private var delegate: SearchResultsSectionControllerDelegate?
    private var searchDiffable: SearchResultsDiffable?
    
    init(delegate: SearchResultsSectionControllerDelegate) {
        self.delegate = delegate
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 96, right: 0)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else {
            return .zero
        }
        let cellWidth: CGFloat = context.containerSize.width
        let cellHeight: CGFloat = 96
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: SearchResultsCell = reuse(for: index, with: MainBundle.bundle)
        if let items = searchDiffable?.products {
            let product = items[index]
            let price: Double = product.price ?? 0.0
            cell.setup(image: product.image ?? "",
                       name: product.name ?? "",
                       description: product.company?.name ?? "",
                       price: price.toCurrency(),
                       isLast: (items.count - 1) == index)
        }
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        guard let item = searchDiffable?.products[index] else {
            return
        }
        delegate?.didSelectProduct(item)
    }
    
    override func numberOfItems() -> Int {
        return searchDiffable?.products.count ?? 0
    }
    
    override func didUpdate(to object: Any) {
        searchDiffable = object as? SearchResultsDiffable
    }
}
