//
//  ProductDetailDataSource.swift
//  Alamofire
//
//  Created by Juan Alfredo García González on 06/05/21.
//

import Foundation
import IGListKit

final class ProductDetailDataSource: NSObject, ListAdapterDataSource {
    
    var sections: [ListDiffable] = []
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return sections
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is ProductDetailHeaderDiffable:
            return ProductDetailHeaderSectionController()
        case is ProductDetailDescriptionDiffable:
            return ProductDetailDescriptionSectionController()
        default:
            return ListSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
