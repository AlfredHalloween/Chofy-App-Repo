//
//  ChofyStyleColor.swift
//  ChofyExtensions
//
//  Created by Juan Alfredo García González on 18/04/21.
//

import Foundation

public struct ChofyColors {
    
    public static var text: UIColor {
        return UIColor(named: "text-color", in: ChofyStyleBundle.bundle, compatibleWith: .none) ?? UIColor()
    }
    
    public static var textObscure: UIColor {
        return UIColor(named: "text-obscure-color", in: ChofyStyleBundle.bundle, compatibleWith: .none) ?? UIColor()
    }
    
    public static var card: UIColor {
        return UIColor(named: "card-color", in: ChofyStyleBundle.bundle, compatibleWith: .none) ?? UIColor()
    }
    
    public static var gradientText: UIColor {
        return UIColor(named: "gradient-text", in: ChofyStyleBundle.bundle, compatibleWith: .none) ?? UIColor()
    }
    
    public static var dividerCell: UIColor {
        return UIColor(named: "divider-cell", in: ChofyStyleBundle.bundle, compatibleWith: .none) ?? UIColor()
    }
    
    public static var screenBackground: UIColor {
        return UIColor(named: "screen-background", in: ChofyStyleBundle.bundle, compatibleWith: .none) ?? UIColor()
    }
    
    public static var placeholderColor: UIColor {
        return UIColor(named: "placeholder-color", in: ChofyStyleBundle.bundle, compatibleWith: .none) ?? UIColor()
    }
    
    public static var textfieldColor: UIColor {
        return UIColor(named: "textfield-color", in: ChofyStyleBundle.bundle, compatibleWith: .none) ?? UIColor()
    }
    
    public static var btnTintColor: UIColor {
        return UIColor(named: "btn-tint-color", in: ChofyStyleBundle.bundle, compatibleWith: .none) ?? UIColor()
    }
    
    public static var okColor: UIColor {
        return UIColor(named: "ok-color", in: ChofyStyleBundle.bundle, compatibleWith: .none) ?? UIColor()
    }
    
    public static var failedColor: UIColor {
        return UIColor(named: "failed-color", in: ChofyStyleBundle.bundle, compatibleWith: .none) ?? UIColor()
    }
}
