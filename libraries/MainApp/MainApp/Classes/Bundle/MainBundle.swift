//
//  MainBundle.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import Foundation
import ChofyExtensions

final class MainBundle: BundleDelegate {
    
    // MARK: Properties
    static var type: AnyClass {
        return MainBundle.self
    }
    
    static var resourcesBundle: String {
        return "MainAppResources"
    }
}
