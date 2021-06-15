//
//  HomeTabPresenter.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import Foundation

protocol HomeTabPresenterDelegate: HomeTabViewOutput {
    func showHomeTab()
}

final class HomeTabPresenter {
    
    private let wireframe: HomeTabWireframeDelegate
    
    init(with wireframe: HomeTabWireframeDelegate) {
        self.wireframe = wireframe
    }
}

extension HomeTabPresenter: HomeTabPresenterDelegate {
    var viewControllers: [UIViewController] {
        return wireframe.getTabs()
    }
    
    func showHomeTab() {
        wireframe.showHomeTab(presenter: self)
    }
}
