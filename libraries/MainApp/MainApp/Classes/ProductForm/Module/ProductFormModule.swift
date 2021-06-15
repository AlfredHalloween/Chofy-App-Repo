//
//  EditProductModule.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 04/06/21.
//

import Foundation
import RxSwift
import RxCocoa

final class ProductFormModule {
    
    private let presenter: ProductFormPresenterDelegate
    
    init(baseController: UIViewController? = nil,
         navigation: UINavigationController? = nil,
         formType: ProductFormType,
         productSubject: PublishSubject<Void>,
         fromNavigation: Bool) {
        let wireframe: ProductFormWireframe = ProductFormWireframe(navigation: navigation,
                                                                   baseController: baseController)
        let interactor: ProductFormInteractor = ProductFormInteractor(formType: formType)
        presenter = ProductFormPresenter(wireframe: wireframe,
                                         interactor: interactor,
                                         productSubject: productSubject,
                                         fromNavigation: fromNavigation)
    }
    
    func showEditProduct() {
        presenter.showEditProduct()
    }
}
