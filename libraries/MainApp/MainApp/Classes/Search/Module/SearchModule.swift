//
//  SearchModule.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import Foundation

final class SearchModule {
    
    // MARK: Properties
    private let presenter: SearchPresenterDelegate
    
    init() {
        let wireframe: SearchWireframe = SearchWireframe()
        let interactor: SearchInteractor = SearchInteractor()
        presenter = SearchPresenter(with: wireframe, interactor: interactor)
    }
    
    func getSearchTab() -> UIViewController {
        return presenter.getSearchTab()
    }
}
