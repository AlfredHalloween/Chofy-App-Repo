//
//  HomeTabModule.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import Foundation

final class HomeTabModule {
    
    private let presenter: HomeTabPresenterDelegate
    
    init(with baseController: UIViewController) {
        let wireframe: HomeTabWireframe = HomeTabWireframe(with: baseController)
        self.presenter = HomeTabPresenter(with: wireframe)
    }
    
    func showHomeTab() {
        presenter.showHomeTab()
    }
}
