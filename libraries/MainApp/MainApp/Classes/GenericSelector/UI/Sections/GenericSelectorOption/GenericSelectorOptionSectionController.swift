//
//  GenericSelectorOptionSectionController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 09/06/21.
//

import Foundation
import IGListKit

protocol GenericSelectorOptionSectionControllerDelegate: AnyObject {
    func didSelectSelectorOption(_ option: GenericSelectorItem)
}

final class GenericSelectorOptionSectionController: ListSectionController {
    
    // MARK: Properties
    private var diffable: GenericSelectorDiffable?
    private weak var delegate: GenericSelectorOptionSectionControllerDelegate?
    
    init(delegate: GenericSelectorOptionSectionControllerDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        let width: CGFloat = context.containerSize.width
        let height: CGFloat = 72.0
        return CGSize(width: width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cellId = String(describing: GenericSelectorOptionCell.self)
        guard let context = collectionContext,
              let items = diffable?.items,
              let cell = context.dequeueReusableCell(withNibName: cellId,
                                                     bundle: MainBundle.bundle,
                                                     for: self,
                                                     at: index) as? GenericSelectorOptionCell else {
            return UICollectionViewCell()
        }
        let item = items[index]
        cell.setup(image: item.imageSelector,
                   name: item.nameSelector,
                   isLast: (items.count - 1) == index)
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        guard let item = diffable?.items[index] else {
            return
        }
        delegate?.didSelectSelectorOption(item)
    }
    
    override func numberOfItems() -> Int {
        return diffable?.items.count ?? 0
    }
    
    override func didUpdate(to object: Any) {
        diffable = object as? GenericSelectorDiffable
    }
}
