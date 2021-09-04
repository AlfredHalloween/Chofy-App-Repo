//
//  QrReaderWireframe.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 20/04/21.
//

import Foundation
import ChofyStyleGuide

typealias QREmptyCompletion = (() -> ())?

protocol QrReaderWireframeDelegate {
    
    func showQrReader(presenter: QrReaderPresenterDelegate)
    func dismissQr(completion: QREmptyCompletion)
    func showPermissionsModal(mainAction: @escaping GenericModuleCompletion,
                              secondaryAction: @escaping GenericModuleCompletion)
    func showToast(message: String, isWarning: Bool)
}

final class QrReaderWireframe {
    
    private weak var baseController: UIViewController?
    private weak var topController: UIViewController?
    
    init(with baseController: UIViewController) {
        self.baseController = baseController
    }
}

extension QrReaderWireframe: QrReaderWireframeDelegate {
    
    func showQrReader(presenter: QrReaderPresenterDelegate) {
        let vc = QrReaderViewController(with: presenter)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        topController = vc
        baseController?.present(vc, animated: true)
    }
    
    func dismissQr(completion: QREmptyCompletion) {
        topController?.dismiss(animated: true,
                               completion: completion)
    }
    
    func showPermissionsModal(mainAction: @escaping GenericModuleCompletion,
                              secondaryAction: @escaping GenericModuleCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            guard let baseController = self.topController else { return }
            let module: GenericModalModule = GenericModalModule(with: baseController,
                                                                input: QrReaderModalInput(),
                                                                mainActionCompletion: mainAction,
                                                                secondaryActionCompletion: secondaryAction)
            module.showGenericModal()
        }
    }
    
    func showToast(message: String, isWarning: Bool) {
        ChofyToast.showToast(title: message, isWarning: isWarning)
    }
}
