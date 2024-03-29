//
//  SearchProduct.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 19/04/21.
//

import Foundation

// MARK: Company DTO
struct Company: Decodable {
    var id: Int?
    var name: String?
    var logo: String?
}

struct ProductPage: Decodable {
    var products: [Product]
}

// MARK: Product DTO
struct Product: Decodable {
    var id: Int?
    var barCode: String?
    var name: String?
    var description: String?
    var weight: String?
    var company: Company?
    var price: Double?
    var image: String?
}
