//
//  InventoryModule.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 16/04/21.
//

import Foundation

final class InventoryModule {
    
    private let presenter: InventoryPresenterDelegate
    
    init() {
        let wireframe: InventoryWireframe = InventoryWireframe()
        presenter = InventoryPresenter(with: wireframe)
    }
    
    func showInventory() -> UIViewController {
        return presenter.showInventory()
    }
}
