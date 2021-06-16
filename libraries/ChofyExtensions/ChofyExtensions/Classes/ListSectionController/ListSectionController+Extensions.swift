//
//  ListSectionController+Extensions.swift
//  ChofyExtensions
//
//  Created by Juan Alfredo García González on 16/06/21.
//

import Foundation
import IGListKit

public extension ListSectionController {
    
    func reuse<T: UICollectionViewCell>(for index: Int, with bundle: Bundle) -> T {
        guard let context = collectionContext else {
            return UICollectionViewCell() as! T
        }
        let identifier: String = String(describing: T.self)
        return context.dequeueReusableCell(withNibName: identifier,
                                           bundle: bundle,
                                           for: self, at: index) as! T
    }
    
    func reuse<T: UICollectionReusableView>(for index: Int, type: String, with bundle: Bundle) -> T {
        guard let context = collectionContext else {
            return UICollectionReusableView() as! T
        }
        let identifier: String = String(describing: T.self)
        return context.dequeueReusableSupplementaryView(ofKind: type,
                                                        for: self,
                                                        nibName: identifier,
                                                        bundle: bundle,
                                                        at: index) as! T
    }
}
