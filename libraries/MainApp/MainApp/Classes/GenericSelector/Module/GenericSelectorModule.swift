//
//  GenericSelectorModule.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 09/06/21.
//

import Foundation

typealias GenericSelectorCompletion = (GenericSelectorItem) -> ()

final class GenericSelectorModule {
    
    // MARK: Properties
    private let presenter: GenericSelectorPresenterDelegate
    
    init(with navigation: UINavigationController,
         items: [GenericSelectorItem],
         completion: @escaping GenericSelectorCompletion) {
        let wireframe: GenericSelectorWireframe = GenericSelectorWireframe(with: navigation)
        let interactor: GenericSelectorInteractor = GenericSelectorInteractor(itemsSelector: items)
        presenter = GenericSelectorPresenter(wireframe: wireframe,
                                             interactor: interactor,
                                             completion: completion)
    }
    
    func showGenericSelector() {
        presenter.showGenericSelector()
    }
}
