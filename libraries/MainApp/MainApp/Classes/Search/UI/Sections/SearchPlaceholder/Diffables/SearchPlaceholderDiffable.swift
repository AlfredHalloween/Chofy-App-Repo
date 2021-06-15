//
//  SearchPlaceholderDiffable.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 18/04/21.
//

import Foundation
import IGListKit

final class SearchPlaceholderDiffable: ListDiffable {
    
    // MARK: Properties
    let idAnimation: String
    let subtitle: String
    
    init(idAnimation: String, subtitle: String) {
        self.idAnimation = idAnimation
        self.subtitle = subtitle
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return "\(idAnimation)_\(subtitle)" as NSString
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
