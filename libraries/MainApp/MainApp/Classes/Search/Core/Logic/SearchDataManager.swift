//
//  SearchDataManager.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 06/05/21.
//

import Foundation
import ChofyExtensions
import RxSwift
import RxCocoa

final class SearchDataManager: RequestBaseManager {
    
    func getProducts(name: String) -> Single<ProductPage> {
        return single(url: "http://127.0.0.1:5000/store",//String(format: "%@%@", NetworkCommons.urlBase, "/find-products/\(name)"),
                      type: ProductPage.self,
                      method: .get)
    }
    
    func getProduct(barCode: String) -> Single<Product> {
        return single(url: String(format: "%@%@", NetworkCommons.urlBase, "/product/\(barCode)"),
                      type: Product.self,
                      method: .get)
    }
}
