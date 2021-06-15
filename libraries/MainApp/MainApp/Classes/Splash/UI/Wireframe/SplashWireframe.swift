//
//  SplashWireframe.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import Foundation

protocol SplashWireframeDelegate {
    func showSplash(presenter: SplashPresenterDelegate)
    func showHomeTab()
}

final class SplashWireframe {
    
    private let window: UIWindow
    private weak var topController: UIViewController?
    
    init(with window: UIWindow) {
        self.window = window
    }
    
}

extension SplashWireframe: SplashWireframeDelegate {
    
    func showSplash(presenter: SplashPresenterDelegate) {
        let vc: UIViewController = SplashViewController(with: presenter)
        topController = vc
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
    
    func showHomeTab() {
        guard let top = topController else { return }
        let homeTabModule: HomeTabModule = HomeTabModule(with: top)
        homeTabModule.showHomeTab()
    }
}
