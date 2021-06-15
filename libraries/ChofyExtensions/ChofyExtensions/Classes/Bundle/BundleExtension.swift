//
//  BundleExtension.swift
//  ChofyExtensions
//
//  Created by Juan Alfredo García González on 17/04/21.
//

import Foundation

public protocol BundleDelegate {
    static var type: AnyClass { get }
    static var resourcesBundle: String { get }
}

public extension BundleDelegate {
    static var bundle: Bundle {
        let bundle: Bundle = Bundle(for: Self.type)
        guard let resourceBundleURL: URL = bundle.url(forResource: Self.resourcesBundle,
                                                      withExtension: "bundle") else {
            fatalError("MainBundleResources.bundle not found!")
        }
        
        guard let resourceBundle: Bundle = Bundle(url: resourceBundleURL) else {
            fatalError("Cannot access MainBundleResources.bundle")
        }
        return resourceBundle
    }
}

final class ChofyExtensionsBundle: BundleDelegate {
    static var type: AnyClass {
        return ChofyExtensionsBundle.self
    }
    
    static var resourcesBundle: String {
        return "ChofyExtensionsResources"
    }
}
