//
//  GenericModalWireframe.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 18/06/21.
//

import Foundation

protocol GenericModalWireframeDelegate {
    func showGenericModal(presenter: GenericModalPresenterDelegate)
    func dismiss()
}

final class GenericModalWireframe {
    
    private weak var baseController: UIViewController?
    private weak var topController: UIViewController?
    
    init(with baseController: UIViewController) {
        self.baseController = baseController
    }
}

extension GenericModalWireframe: GenericModalWireframeDelegate {
    
    func showGenericModal(presenter: GenericModalPresenterDelegate) {
        guard let baseController = baseController else { return }
        let vc: GenericModalViewController = GenericModalViewController(presenter: presenter)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        topController = vc
        baseController.present(vc, animated: true)
    }
    
    func dismiss() {
        topController?.dismiss(animated: true)
    }
}
