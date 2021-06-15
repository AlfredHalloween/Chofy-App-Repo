//
//  ProductDetailDataManager.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 09/06/21.
//

import Foundation
import RxSwift
import RxCocoa
import ChofyExtensions

final class ProductDetailDataManager: RequestBaseManager {
    
    func getProduct(id: Int) -> Single<Product> {
        return single(url: String(format: "%@%@", NetworkCommons.urlBase, "/product-id/\(id)"),
                      type: Product.self,
                      method: .get)
    }
}
