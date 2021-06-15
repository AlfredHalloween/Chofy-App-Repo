//
//  EditProductHolderSectionController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 07/06/21.
//

import Foundation
import IGListKit

protocol ProductFormHolderSectionControllerDelegate: AnyObject {
    func didUpdateText(identifier: String, text: String)
    func showQrCamera()
    func openCompanySelector()
}

final class ProductFormHolderSectionController: ListSectionController {
    
    // MARK: Properties
    private var diffable: ProductFormDiffable?
    private weak var delegate: ProductFormHolderSectionControllerDelegate?
    
    init(delegate: ProductFormHolderSectionControllerDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext,
              let item: EditProductDiffable = diffable?.formItems[index] else { return .zero }
        let width: CGFloat = context.containerSize.width
        let height: CGFloat = item.identifier == .description ? 150 : 84
        return CGSize(width: width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let item: EditProductDiffable = diffable?.formItems[index] else {
            return UICollectionViewCell()
        }
        switch item.identifier {
        case .company:
            return getSelectorCell(index: index, item: item)
        case .description:
            return getEditableLargeCell(index: index, item: item)
        default:
            return getEditableCell(index: index, item: item)
        }
    }
    
    override func numberOfItems() -> Int {
        return diffable?.formItems.count ?? 0
    }
    
    override func didUpdate(to object: Any) {
        diffable = object as? ProductFormDiffable
    }
}

extension ProductFormHolderSectionController: ProductFormHolderCellDelegate {
    
    func didUpdateText(identifier: String, text: String) {
        delegate?.didUpdateText(identifier: identifier, text: text)
    }
    
    func showQrCamera() {
        delegate?.showQrCamera()
    }
}

extension ProductFormHolderSectionController: ProductFormSelectorCellDelegate {
    
    func openCompanySelector() {
        delegate?.openCompanySelector()
    }
}

private extension ProductFormHolderSectionController {
    
    func getEditableCell(index: Int, item: EditProductDiffable) -> UICollectionViewCell {
        guard let cell: ProductFormHolderCell = collectionContext?
                .dequeueReusableCell(withNibName: ProductFormHolderCell.cellIdentifier,
                                     bundle: MainBundle.bundle,
                                     for: self,
                                     at: index) as? ProductFormHolderCell else {
            return UICollectionViewCell()
        }
        cell.setup(identifier: item.identifier.rawValue,
                   text: item.text,
                   placeholderText: item.identifier.label,
                   keyboard: item.identifier.keyboardType,
                   showBarCode: item.identifier == .barCode,
                   isEditable: item.identifier.IsEditableCell)
        cell.delegate = self
        return cell
    }
    
    func getEditableLargeCell(index: Int, item: EditProductDiffable) -> UICollectionViewCell {
        guard let cell: ProductFormLargeHolderCell = collectionContext?
                .dequeueReusableCell(withNibName: ProductFormLargeHolderCell.cellIdentifier,
                                     bundle: MainBundle.bundle,
                                     for: self,
                                     at: index) as? ProductFormLargeHolderCell else {
            return UICollectionViewCell()
        }
        cell.setup(identifier: item.identifier.rawValue, title: item.identifier.label, description: item.text)
        cell.delegate = self
        return cell
    }
    
    func getSelectorCell(index: Int, item: EditProductDiffable) -> UICollectionViewCell {
        guard let cell: ProductFormSelectorCell = collectionContext?
                .dequeueReusableCell(withNibName: ProductFormSelectorCell.identifier,
                                     bundle: MainBundle.bundle,
                                     for: self,
                                     at: index) as? ProductFormSelectorCell else {
            return UICollectionViewCell()
        }
        cell.setup(placeholder: item.identifier.label,
                   name: item.text,
                   isEditable: item.identifier.IsEditableCell)
        cell.delegate = self
        return cell
    }
}
