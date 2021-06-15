//
//  SplashModule.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import Foundation

open class SplashModule {
    
    private let presenter: SplashPresenterDelegate
    
    public init(with window: UIWindow) {
        let wireframe: SplashWireframe = SplashWireframe(with: window)
        presenter = SplashPresenter(with: wireframe)
    }
    
    public func showSplash() {
        presenter.showSplash()
    }
}
