//
//  ChofyStyleBundle.swift
//  ChofyExtensions
//
//  Created by Juan Alfredo García González on 18/04/21.
//

import Foundation
import ChofyExtensions

final class ChofyStyleBundle: BundleDelegate {
    static var type: AnyClass {
        return ChofyStyleBundle.self
    }
    
    static var resourcesBundle: String {
        return "ChofyStyleGuideResources"
    }
}
