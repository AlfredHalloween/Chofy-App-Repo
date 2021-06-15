//
//  EditProductEntities.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 05/06/21.
//

import Foundation

enum ProductFormType {
    case new(String?)
    case edit(Product)
}

struct ProductEditable: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var weight: String?
    var company: Int?
    var price: Double?
    var image: String?
    var barCode: String?
}

struct CompanyEditable: Codable {
    var id: Int?
    var name: String?
    var logo: String?
}

extension CompanyEditable: GenericSelectorItem {
    var idSelector: Int {
        return id ?? 0
    }
    
    var imageSelector: String? {
        return logo
    }
    
    var nameSelector: String {
        return name ?? ""
    }
}
