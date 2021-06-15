//
//  GenericSelectorWireframe.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 09/06/21.
//

import Foundation

protocol GenericSelectorWireframeDelegate {
    func showGenericSelector(presenter: GenericSelectorPresenterDelegate)
    func dismiss(completion: (() -> ())?)
}

final class GenericSelectorWireframe {
    
    // MARK: Outlets
    private weak var navigation: UINavigationController?
    private weak var baseController: UIViewController?
    
    init(with navigation: UINavigationController) {
        self.navigation = navigation
    }
}

extension GenericSelectorWireframe: GenericSelectorWireframeDelegate {
    
    func showGenericSelector(presenter: GenericSelectorPresenterDelegate) {
        let vc: GenericSelectorViewController = GenericSelectorViewController(presenter: presenter)
        baseController = vc
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        navigation?.present(vc, animated: true)
    }
    
    func dismiss(completion: (() -> ())? = nil) {
        baseController?.dismiss(animated: true, completion: {
            completion?()
        })
    }
}
