//
//  GenericSelectorOptionDataSource.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 09/06/21.
//

import Foundation
import RxSwift
import RxCocoa
import IGListKit

protocol GenericSelectorOptionDataSourceDelegate: AnyObject {
    func didSelectSelectorOption(_ option: GenericSelectorItem)
}

final class GenericSelectorOptionDataSource: NSObject {
    
    private var items: [ListDiffable] = []
    private weak var delegate: GenericSelectorOptionDataSourceDelegate?
    private lazy var selectorSectionController: GenericSelectorOptionSectionController = {
       return GenericSelectorOptionSectionController(delegate: self)
    }()
    
    init(delegate: GenericSelectorOptionDataSourceDelegate) {
        self.delegate = delegate
    }
    
    func updateDataSource(items: [ListDiffable]) {
        self.items = items
    }
}

extension GenericSelectorOptionDataSource: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return items
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is GenericSelectorDiffable:
            return selectorSectionController
        default:
            return ListSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension GenericSelectorOptionDataSource: GenericSelectorOptionSectionControllerDelegate {
    
    func didSelectSelectorOption(_ option: GenericSelectorItem) {
        delegate?.didSelectSelectorOption(option)
    }
}
