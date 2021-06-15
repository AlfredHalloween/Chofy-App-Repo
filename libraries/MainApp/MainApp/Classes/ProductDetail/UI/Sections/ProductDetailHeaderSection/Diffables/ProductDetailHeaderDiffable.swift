//
//  ProductDetailHeaderDiffable.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 06/05/21.
//

import Foundation
import IGListKit

final class ProductDetailHeaderDiffable: ListDiffable {
    var image: String
    var name: String
    var price: Double
    
    init(image: String, name: String, price: Double) {
        self.image = image
        self.name = name
        self.price = price
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return "\(image)_\(name)_\(price)" as NSString
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
