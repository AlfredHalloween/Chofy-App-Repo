//
//  HomeTabWireframe.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import Foundation
import ChofyStyleGuide

protocol HomeTabWireframeDelegate {
    func showHomeTab(presenter: HomeTabPresenterDelegate)
    func getTabs() -> [UIViewController]
}

final class HomeTabWireframe {
    
    private weak var baseController: UIViewController?
    private weak var topController: UIViewController? {
        if let top = baseController?.presentedViewController {
            return top
        } else if let top = baseController {
            return top
        }
        return nil
    }
    private weak var tabBar: UIViewController?
    
    init(with baseController: UIViewController) {
        self.baseController = baseController
    }
}

extension HomeTabWireframe: HomeTabWireframeDelegate {
    func showHomeTab(presenter: HomeTabPresenterDelegate) {
        let vc: UITabBarController = HomeTabViewController(with: presenter)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        tabBar = vc
        topController?.present(vc, animated: true)
    }
    
    func getTabs() -> [UIViewController] {
        return [
            getSearchModule()
        ]
    }
    
    func getHomeModule() -> UIViewController {
        let module: HomeModule = HomeModule()
        return module.getHomeTab()
    }
    
    func getSearchModule() -> UIViewController {
        let module: SearchModule = SearchModule()
        return module.getSearchTab()
    }
    
    func getInventoryModule() -> UIViewController {
        let module: InventoryModule = InventoryModule()
        return module.showInventory()
    }
}
