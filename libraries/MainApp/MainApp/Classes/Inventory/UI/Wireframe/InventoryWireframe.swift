//
//  InventoryWireframe.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 16/04/21.
//

import Foundation

protocol InventoryWireframeDelegate {
    
    func getInventoryTab(presenter: InventoryPresenterDelegate) -> UIViewController
}

final class InventoryWireframe {}

extension InventoryWireframe: InventoryWireframeDelegate {
    
    func getInventoryTab(presenter: InventoryPresenterDelegate) -> UIViewController {
        return InventoryViewController(with: presenter)
    }
}
