//
//  GenericSelectorOptionDiffable.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 09/06/21.
//

import Foundation
import IGListKit

final class GenericSelectorDiffable: ListDiffable {
    var items: [GenericSelectorItem]
    
    init(items: [GenericSelectorItem]) {
        self.items = items
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return items.map {
            let identifier: String = String($0.idSelector)
            let name: String = $0.nameSelector
            let image: String = $0.imageSelector ?? ""
            return "\(identifier)_\(name)_\(image)"
        }.joined(separator: "*") as NSString
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
