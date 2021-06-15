//
//  EditProductDataManager.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 04/06/21.
//

import Foundation
import ChofyExtensions
import RxSwift
import RxCocoa

final class ProductFormDataManager: RequestBaseManager {
    
    func getCompany(id: Int) -> Single<CompanyEditable> {
        return single(url: String(format: "%@%@", NetworkCommons.urlBase, "/company/\(id)"),
                      type: CompanyEditable.self,
                      method: .get)
    }
    
    func getCompanies() -> Single<[CompanyEditable]> {
        return single(url: String(format: "%@%@", NetworkCommons.urlBase, "/list-companies"),
                      type: [CompanyEditable].self,
                      method: .get)
    }
    
    func getProduct(id: Int) -> Single<ProductEditable> {
        return single(url: String(format: "%@%@", NetworkCommons.urlBase, "/get-product"),
                      type: ProductEditable.self,
                      method: .get,
                      parameters: ["id": id])
    }
    
    func createProduct(product: ProductEditable) -> Single<ProductEditable> {
        return single(url: String(format: "%@%@", NetworkCommons.urlBase, "/save-product"),
                      type: ProductEditable.self,
                      method: .post,
                      parameters: getProductParameters(product: product))
    }
    
    func editProduct(id: Int, product: ProductEditable) -> Single<ProductEditable> {
        return single(url: String(format: "%@%@", NetworkCommons.urlBase, "/edit-product/\(id)"),
                      type: ProductEditable.self,
                      method: .put,
                      parameters: getProductParameters(product: product))
    }
}

private extension ProductFormDataManager {
    func getProductParameters(product: ProductEditable) -> [String: Any] {
        return [
            "name": product.name ?? "",
            "description": product.description ?? "",
            "weight": product.weight ?? "",
            "company": product.company ?? 0,
            "price": product.price ?? 0.0,
            "image": product.image ?? "",
            "barCode": product.barCode ?? ""
        ]
    }
}
