//
//  ProductDetailInteractor.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 04/06/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProductDetailInteractorDelegate {
    var product: Product? { get }
    
    func getProduct(id: Int) -> Single<Product>
    func updateProduct(product: Product)
}

final class ProductDetailInteractor {
    
    private var productInfo: Product
    private let dataManager: ProductDetailDataManager
    
    init(productInfo: Product, dataManager: ProductDetailDataManager = ProductDetailDataManager()) {
        self.productInfo = productInfo
        self.dataManager = dataManager
    }
    
    func updateProduct(product: Product) {
        productInfo = product
    }
}

extension ProductDetailInteractor: ProductDetailInteractorDelegate {
    var product: Product? {
        return productInfo
    }
    
    func getProduct(id: Int) -> Single<Product> {
        return dataManager.getProduct(id: id)
    }
}
