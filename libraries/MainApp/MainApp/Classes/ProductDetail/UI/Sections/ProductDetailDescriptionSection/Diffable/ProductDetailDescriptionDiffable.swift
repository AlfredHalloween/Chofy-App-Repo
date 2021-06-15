//
//  ProductDetailDescriptionDiffable.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 10/06/21.
//

import Foundation
import IGListKit

final class ProductDetailDescriptionDiffable: ListDiffable {
    var title: String
    var description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return "\(title)_\(description)" as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let otherObject = object,
              let identifier = diffIdentifier() as? String,
              let otherIdentifiet = otherObject.diffIdentifier() as? String else {
            return false
        }
        return identifier == otherIdentifiet
    }
}
