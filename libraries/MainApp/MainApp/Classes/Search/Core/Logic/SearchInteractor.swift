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
    
    func getProducts(name: String) -> Single<ProductPage> {
        var items: [Product] = []
        for i in 1..<100 {
            let product1 = Product(id: i,
                                  barCode: "111111",
                                  name: "name 1",
                                  description: "description 1",
                                  weight: "100 g.",
                                  company: Company(id: 1, name: "Coca", logo: nil),
                                  price: 10.0,
                                  image: nil)
            items.append(product1)
        }
        let page = ProductPage(products: items)
        return Single.just(page)
        //return dataManager.getProducts(name: name)
    }
    
    func getProduct(barCode: String) -> Single<Product> {
        return dataManager.getProduct(barCode: barCode)
    }
}
