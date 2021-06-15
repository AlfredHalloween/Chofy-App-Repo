//
//  InventoryPresenter.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 16/04/21.
//

import Foundation

protocol InventoryPresenterDelegate: InventoryViewOutput {
    func showInventory() -> UIViewController
}

final class InventoryPresenter {
    
    private let wireframe: InventoryWireframeDelegate
    
    init(with wireframe: InventoryWireframeDelegate) {
        self.wireframe = wireframe
    }
}

extension InventoryPresenter: InventoryPresenterDelegate {
    func showInventory() -> UIViewController {
        return wireframe.getInventoryTab(presenter: self)
    }
}
