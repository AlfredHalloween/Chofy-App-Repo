//
//  EditProductInteractor.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 04/06/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProductFormInteractorDelegate {
    var productFormType: ProductFormType { get }
    func getCompany(id: Int) -> Single<CompanyEditable>
    func getCompanies() -> Single<[CompanyEditable]>
    func getProduct(id: Int) -> Single<ProductEditable>
    func createProduct(product: ProductEditable) -> Single<ProductEditable>
    func editProduct(id: Int, product: ProductEditable) -> Single<ProductEditable>
}

final class ProductFormInteractor {
    private let dataManager: ProductFormDataManager
    internal let formType: ProductFormType
    
    init(dataManager: ProductFormDataManager = ProductFormDataManager(),
         formType: ProductFormType) {
        self.dataManager = dataManager
        self.formType = formType
    }
}

extension ProductFormInteractor: ProductFormInteractorDelegate {
    var productFormType: ProductFormType {
        return formType
    }
    
    func getCompany(id: Int) -> Single<CompanyEditable> {
        return dataManager.getCompany(id: id)
    }
    
    func getCompanies() -> Single<[CompanyEditable]> {
        return dataManager.getCompanies()
    }
    
    func getProduct(id: Int) -> Single<ProductEditable> {
        return dataManager.getProduct(id: id)
    }
    
    func createProduct(product: ProductEditable) -> Single<ProductEditable> {
        return dataManager.createProduct(product: product)
    }
    
    func editProduct(id: Int, product: ProductEditable) -> Single<ProductEditable> {
        return dataManager.editProduct(id: id, product: product)
    }
}
