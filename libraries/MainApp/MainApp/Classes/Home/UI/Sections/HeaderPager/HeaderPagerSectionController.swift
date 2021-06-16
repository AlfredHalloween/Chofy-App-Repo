//
//  HeaderPagerSectionController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 16/04/21.
//

import Foundation
import IGListKit

// MARK: HeaderPagerSectionControllerDelegate
protocol HeaderPagerSectionControllerDelegate: NSObject {
    func didSelectPage(page: HeaderPager)
}

final class HeaderPagerSectionController: ListSectionController {
    
    // MARK: Properties
    private var pager: HeaderPagerDiffable?
    private var delegate: HeaderPagerSectionControllerDelegate?
    
    init(delegate: HeaderPagerSectionControllerDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    // MARK: Methods
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        let cellWidth: CGFloat = context.containerSize.width
        let cellHeight: CGFloat = cellWidth * 0.75
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: HeaderPagerCell = reuse(for: index, with: MainBundle.bundle)
        if let pages = pager?.pages {
            cell.delegate = self
            cell.setup(pages: pages)
        }
        return cell
    }
    
    override func didUpdate(to object: Any) {
        pager = object as? HeaderPagerDiffable
    }
}

// MARK: HeaderPagerCellDelegate implementation
extension HeaderPagerSectionController: HeaderPagerCellDelegate {
    
    func didSelectPage(page: HeaderPager) {
        delegate?.didSelectPage(page: page)
    }
}
