//
//  GenericSelectorInteractor.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 09/06/21.
//

import Foundation

protocol GenericSelectorItem {
    var idSelector: Int { get }
    var imageSelector: String? { get }
    var nameSelector: String { get }
}

protocol GenericSelectorInteractorDelegate {
    var items: [GenericSelectorItem] { get }
}

final class GenericSelectorInteractor {
    
    // MARK: Properties
    private let itemsSelector: [GenericSelectorItem]
    
    init(itemsSelector: [GenericSelectorItem]) {
        self.itemsSelector = itemsSelector
    }
}

extension GenericSelectorInteractor: GenericSelectorInteractorDelegate {
    var items: [GenericSelectorItem] {
        return itemsSelector
    }
}
