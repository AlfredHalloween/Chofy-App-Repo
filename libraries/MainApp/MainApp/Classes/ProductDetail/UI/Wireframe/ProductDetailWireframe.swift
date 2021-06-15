//
//  ProductDetailWireframe.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 06/05/21.
//

import Foundation
import RxSwift
import RxCocoa
import ChofyStyleGuide

protocol ProductDetailWireframeDelegate {
    var productObservable: Observable<Void> { get }
    
    func showProductDetail(presenter: ProductDetailPresenterDelegate)
    func showEditProduct(formType: ProductFormType)
    func showToast(message: String, isWarning: Bool)
    func dismiss()
}

final class ProductDetailWireframe {
    
    private weak var baseController: UIViewController?
    private var navigation: UINavigationController?
    
    private let productSubject: PublishSubject = PublishSubject<Void>()
    
    init(with baseController: UIViewController) {
        self.baseController = baseController
    }
}

extension ProductDetailWireframe: ProductDetailWireframeDelegate {
    var productObservable: Observable<Void> {
        return productSubject
    }
    
    func showProductDetail(presenter: ProductDetailPresenterDelegate) {
        let vc: ProductDetailViewController = ProductDetailViewController(presenter: presenter)
        navigation = UINavigationController(rootViewController: vc)
        navigation?.navigationBar.barTintColor = ChofyColors.screenBackground
        navigation?.navigationBar.tintColor = ChofyColors.btnTintColor
        guard let navigation = navigation else { return }
        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .coverVertical
        baseController?.present(navigation, animated: true)
    }
    
    func showEditProduct(formType: ProductFormType) {
        guard let navigation = navigation else { return }
        let module: ProductFormModule = ProductFormModule(navigation: navigation,
                                                          formType: formType,
                                                          productSubject: productSubject,
                                                          fromNavigation: true)
        module.showEditProduct()
    }
    
    func showToast(message: String, isWarning: Bool) {
        ChofyToast.showToast(title: message, isWarning: isWarning)
    }
    
    func dismiss() {
        navigation?.dismiss(animated: true)
    }
}
