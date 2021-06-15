//
//  DoubleExtension.swift
//  ChofyExtensions
//
//  Created by Juan Alfredo García González on 07/05/21.
//

import Foundation

public extension Double {
    
    func toCurrency() -> String? {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber)
    }
}
