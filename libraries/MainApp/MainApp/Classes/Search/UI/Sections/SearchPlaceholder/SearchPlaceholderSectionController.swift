//
//  SearchPlaceholderSectionController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 18/04/21.
//

import Foundation
import IGListKit

final class SearchPlaceholderSectionController: ListSectionController {
    
    // MARK: Properties
    private var diffable: SearchPlaceholderDiffable?
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else {
            return .zero
        }
        let tabHeight: CGFloat = viewController?.tabBarController?.tabBar.frame.size.height ?? 0
        let statusHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let cellWidth: CGFloat = context.containerSize.width
        let cellHeight: CGFloat = context.containerSize.height
        return CGSize(width: cellWidth,
                      height: cellHeight - tabHeight - statusHeight)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: SearchPlaceholderCell = reuse(for: index, with: MainBundle.bundle)
        if let item = diffable {
            cell.setup(message: item.subtitle)
        }
        return cell
    }
    
    override func didUpdate(to object: Any) {
        diffable = object as? SearchPlaceholderDiffable
    }
}
