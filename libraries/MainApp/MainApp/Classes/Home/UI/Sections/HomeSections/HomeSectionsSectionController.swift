//
//  HomeSectionsSectionController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 16/04/21.
//

import Foundation
import IGListKit

protocol HomeSectionsSectionControllerDelegate: NSObject {
    func didSelectSection(section: HomeSection)
}

final class HomeSectionsSectionController: ListSectionController {
    
    private var diffable: HomeSectionDiffable?
    private var delegate: HomeSectionsSectionControllerDelegate?
    
    init(delegate: HomeSectionsSectionControllerDelegate) {
        self.delegate = delegate
        super.init()
        supplementaryViewSource = self
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else {
            return .zero
        }
        let cellWidth: CGFloat = context.containerSize.width / 2
        let cellHeight: CGFloat = 72
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: HomeSectionCell = reuse(for: index, with: MainBundle.bundle)
        if let item = diffable?.sections[index] {
            cell.setup(image: item.image, name: item.name)
        }
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        guard let item = diffable?.sections[index] else {
            return
        }
        delegate?.didSelectSection(section: item)
    }
    
    override func numberOfItems() -> Int {
        return diffable?.sections.count ?? 0
    }
    
    override func didUpdate(to object: Any) {
        diffable = object as? HomeSectionDiffable
    }
}

extension HomeSectionsSectionController: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        if numberOfItems() == 0 {
            return []
        }
        return [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            let header: HomeSectionHeaderView = reuse(for: index, type: elementKind, with: MainBundle.bundle)
            if let title = diffable?.title,
               let subtitle = diffable?.subtitle {
                header.setup(title: title, subtitle: subtitle)
            }
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        guard let context = collectionContext else {
            return .zero
        }
        let headerWidth: CGFloat = context.containerSize.width
        let headerSize: CGSize = HomeSectionHeaderView.getCellSize(with: headerWidth,
                                                                   title: "Título del header para enseñar la vista de prueba",
                                                                   subtitle: "Subtitle label")
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            return headerSize
        default:
            return .zero
        }
    }
}
