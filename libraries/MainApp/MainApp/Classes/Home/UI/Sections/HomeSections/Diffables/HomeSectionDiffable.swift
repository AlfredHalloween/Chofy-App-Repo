//
//  HomeSectionDiffable.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 16/04/21.
//

import Foundation
import IGListKit

final class HomeSectionDiffable: ListDiffable {
    let title: String
    let subtitle: String
    let sections: [HomeSection]
    
    init(title: String, subtitle: String, sections: [HomeSection]) {
        self.title = title
        self.subtitle = subtitle
        self.sections = sections
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        let arrayId = sections.map { "\($0.image)_\($0.name)" }.joined(separator: "-")
        return "\(title)_\(subtitle)_\(arrayId)" as NSString
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
