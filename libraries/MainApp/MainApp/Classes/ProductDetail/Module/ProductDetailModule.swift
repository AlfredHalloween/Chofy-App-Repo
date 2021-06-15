//
//  ProductDetailModule.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 06/05/21.
//

import Foundation
import RxSwift
import RxCocoa

final class ProductDetailModule {
    
    private let presenter: ProductDetailPresenterDelegate
    
    init(with baseController: UIViewController,
         product: Product,
         uploadSubject: PublishSubject<Void>) {
        let wireframe: ProductDetailWireframe = ProductDetailWireframe(with: baseController)
        let interactor: ProductDetailInteractor = ProductDetailInteractor(productInfo: product)
        self.presenter = ProductDetailPresenter(wireframe: wireframe,
                                                interactor: interactor,
                                                uploadSubject: uploadSubject)
    }
    
    func showProductDetail() {
        presenter.showProductDetail()
    }
}
