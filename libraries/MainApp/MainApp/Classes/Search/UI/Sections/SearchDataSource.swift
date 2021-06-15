//
//  SearchDataSource.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 18/04/21.
//

import Foundation
import IGListKit

protocol SearchDataSourceDelegate: AnyObject {
    
    func didSelectProduct(_ product: Product)
}

final class SearchDataSource: NSObject {
    
    private var delegate: SearchDataSourceDelegate?
    var sections: [ListDiffable] = []
    
    init(delegate: SearchDataSourceDelegate) {
        self.delegate = delegate
    }
}

extension SearchDataSource: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return sections
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is SearchPlaceholderDiffable:
            return SearchPlaceholderSectionController()
        case is SearchResultsDiffable:
            return SearchResultsSectionController(delegate: self)
        default:
            return ListSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension SearchDataSource: SearchResultsSectionControllerDelegate {
    
    func didSelectProduct(_ product: Product) {
        delegate?.didSelectProduct(product)
    }
}
