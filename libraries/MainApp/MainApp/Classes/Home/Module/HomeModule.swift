//
//  HomeModule.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import Foundation

final class HomeModule {
    
    // MARK: Properties
    private let presenter: HomePresenterDelegate
    
    init() {
        let wireframe: HomeWireframe = HomeWireframe()
        presenter = HomePresenter(with: wireframe)
    }
    
    // MARK: Methods
    func getHomeTab() -> UIViewController {
        return presenter.getHomeTab()
    }
}
