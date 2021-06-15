//
//  EditProductWireframe.swift
//  Pods
//
//  Created by Juan Alfredo García González on 04/06/21.
//

import Foundation
import ChofyStyleGuide

protocol ProductFormWireframeDelegate {
    func showProductForm(fromNavigation: Bool,
                         presenter: ProductFormPresenterDelegate)
    func dismiss()
    func closeNavigation()
    func showQRScreen(completion: @escaping QRReaderCompletion)
    func showCompanySelector(items: [CompanyEditable],
                             completion: @escaping GenericSelectorCompletion)
    func showToast(message: String, isWarning: Bool)
}

final class ProductFormWireframe {
    private var navigation: UINavigationController?
    private weak var baseController: UIViewController?
    
    init(navigation: UINavigationController? = nil, baseController: UIViewController? = nil) {
        self.baseController = baseController
        self.navigation = navigation
    }
}

extension ProductFormWireframe: ProductFormWireframeDelegate {
    func showProductForm(fromNavigation: Bool,
                         presenter: ProductFormPresenterDelegate) {
        if fromNavigation {
            showFromNavigation(presenter: presenter)
        } else {
            showFromBaseController(presenter: presenter)
        }
    }
    
    func dismiss() {
        navigation?.popViewController(animated: true)
    }
    
    func closeNavigation() {
        navigation?.dismiss(animated: true)
    }
    
    func showQRScreen(completion: @escaping QRReaderCompletion) {
        guard let baseController = navigation else {
            return
        }
        let module = QrReaderModule(with: baseController, completion: completion)
        module.showQrReader()
    }
    
    func showCompanySelector(items: [CompanyEditable],
                             completion: @escaping GenericSelectorCompletion) {
        guard let baseController = navigation else {
            return
        }
        let module = GenericSelectorModule(with: baseController,
                                        items: items,
                                        completion: completion)
        module.showGenericSelector()
    }
    
    func showToast(message: String, isWarning: Bool = false) {
        ChofyToast.showToast(title: message, isWarning: isWarning)
    }
}

private extension ProductFormWireframe {
    func showFromBaseController(presenter: ProductFormPresenterDelegate) {
        let vc: ProductFormViewController = ProductFormViewController(presenter: presenter)
        navigation = UINavigationController(rootViewController: vc)
        navigation?.navigationBar.barTintColor = ChofyColors.screenBackground
        navigation?.navigationBar.tintColor = ChofyColors.btnTintColor
        guard let navigation = navigation else { return }
        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .coverVertical
        baseController?.present(navigation, animated: true)
    }
    
    func showFromNavigation(presenter: ProductFormPresenterDelegate) {
        let vc: ProductFormViewController = ProductFormViewController(presenter: presenter)
        navigation?.pushViewController(vc, animated: true)
    }
}
