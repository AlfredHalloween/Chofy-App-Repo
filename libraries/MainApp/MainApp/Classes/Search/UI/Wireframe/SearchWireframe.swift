//
//  SearchWireframe.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import Foundation
import RxSwift
import RxCocoa
import ChofyStyleGuide

protocol SearchWireframeDelegate {
    var uploadObservable: Observable<Void> { get }
    
    func getSearchTab(presenter: SearchPresenterDelegate) -> UIViewController
    func showQRScreen(completion: @escaping QRReaderCompletion)
    func showProductDetail(product: Product)
    func showNewProduct(barCode: String?)
    func showToast(message: String, isWarning: Bool)
}

final class SearchWireframe {
    
    // MARK: Properties
    private weak var baseController: UIViewController?
    private var navigation: UINavigationController?
    private let uploadSubject: PublishSubject = PublishSubject<Void>()
}

extension SearchWireframe: SearchWireframeDelegate {
    var uploadObservable: Observable<Void> {
        return uploadSubject
    }
    
    func getSearchTab(presenter: SearchPresenterDelegate) -> UIViewController {
        let vc = SearchViewController(with: presenter)
        let navigation = UINavigationController()
        navigation.viewControllers = [vc]
        vc.navigationController?.navigationBar.prefersLargeTitles = true
        baseController = navigation
        return navigation
    }
    
    func showQRScreen(completion: @escaping QRReaderCompletion) {
        guard let baseController = baseController else {
            return
        }
        let module = QrReaderModule(with: baseController, completion: completion)
        module.showQrReader()
    }
    
    func showProductDetail(product: Product) {
        guard let baseController = baseController else {
            return
        }
        let module: ProductDetailModule = ProductDetailModule(with: baseController,
                                                              product: product,
                                                              uploadSubject: uploadSubject)
        module.showProductDetail()
    }
    
    func showNewProduct(barCode: String? = nil) {
        guard let baseController = baseController else {
            return
        }
        
        let module: ProductFormModule = ProductFormModule(baseController: baseController,
                                                          formType: .new(barCode),
                                                          productSubject: uploadSubject,
                                                          fromNavigation: false)
        module.showEditProduct()
    }
    
    func showToast(message: String, isWarning: Bool) {
        ChofyToast.showToast(title: message, isWarning: isWarning)
    }
}

