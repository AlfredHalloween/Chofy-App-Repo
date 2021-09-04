//
//  SearchInteractor.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 06/05/21.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchInteractor {
    
    // MARK: Properties
    let dataManager: SearchDataManager = SearchDataManager()
    
    func getProducts(name: String) -> Single<[Product]> {
        return dataManager.getProducts(name: name)
    }
    
    func getProduct(barCode: String) -> Single<Product> {
        return dataManager.getProduct(barCode: barCode)
    }
}
