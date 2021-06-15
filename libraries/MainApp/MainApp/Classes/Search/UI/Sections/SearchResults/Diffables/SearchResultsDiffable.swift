//
//  SearchResultsDiffable.swift
//  ChofyStyleGuide
//
//  Created by Juan Alfredo García González on 19/04/21.
//

import Foundation
import IGListKit

final class SearchResultsDiffable: ListDiffable {
    var products: [Product]
    
    init(products: [Product]) {
        self.products = products
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return products.map {
            "\(String($0.id ?? 0))_\($0.barCode ?? "")_\($0.name ?? "")_\($0.company?.name ?? "")_\(String($0.price ?? 0.0))_\($0.description ?? "")_\($0.image ?? ""))"
        }.joined(separator: "-") as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let otherObject = object,
              let identifier = diffIdentifier() as? String,
              let otherIdentifier = otherObject.diffIdentifier() as? String else {
            return false
        }
        return identifier == otherIdentifier
    }
}
