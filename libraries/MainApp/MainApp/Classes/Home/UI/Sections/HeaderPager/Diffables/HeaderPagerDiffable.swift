//
//  HeaderPagerDiffable.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 16/04/21.
//

import Foundation
import IGListKit

final class HeaderPagerDiffable: ListDiffable {
    
    // MARK: Properties
    let identifier: String
    let pages: [HeaderPager]
    
    init(identifier: String, pages: [HeaderPager]) {
        self.identifier = identifier
        self.pages = pages
    }
    
    // MARK: Methods
    func diffIdentifier() -> NSObjectProtocol {
        let arrayId: String = pages.map { "\($0.title)_\($0.image)" }.joined(separator: "*")
        return arrayId as NSString
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
