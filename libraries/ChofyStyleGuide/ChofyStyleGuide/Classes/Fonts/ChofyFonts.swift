//
//  ChofyFonts.swift
//  ChofyStyleGuide
//
//  Created by Juan Alfredo García González on 10/06/21.
//

import Foundation

public enum ChofyFontSize: CGFloat {
    case h1 = 32
    case h2 = 24
    case headline = 20
    case body = 16
    case captionOne = 14
    case captionTwo = 12
    case label = 10
    case small = 8.4
}

public enum ChofyFontStyle: String {
    case thin = "NotoSansJP-Thin"
    case light = "NotoSansJP-Light"
    case regular = "NotoSansJP-Regular"
    case medium = "NotoSansJP-Medium"
    case bold = "NotoSansJP-Bold"
    case black = "NotoSansJP-Black"
}

public class ChofyFontCatalog {
    
    // MARK: H1 font
    public static var h1Thin: UIFont {
        return ChofyFont.font(.h1, style: .thin)
    }
    
    public static var h1Light: UIFont {
        return ChofyFont.font(.h1, style: .light)
    }
    
    public static var h1Regular: UIFont {
        return ChofyFont.font(.h1, style: .regular)
    }
    
    public static var h1Medium: UIFont {
        return ChofyFont.font(.h1, style: .medium)
    }
    
    public static var h1Bold: UIFont {
        return ChofyFont.font(.h1, style: .bold)
    }
    
    public static var h1Black: UIFont {
        return ChofyFont.font(.h1, style: .black)
    }
    
    // MARK: H2 font
    public static var h2Thin: UIFont {
        return ChofyFont.font(.h2, style: .thin)
    }
    
    public static var h2Light: UIFont {
        return ChofyFont.font(.h2, style: .light)
    }
    
    public static var h2Regular: UIFont {
        return ChofyFont.font(.h2, style: .regular)
    }
    
    public static var h2Medium: UIFont {
        return ChofyFont.font(.h2, style: .medium)
    }
    
    public static var h2Bold: UIFont {
        return ChofyFont.font(.h2, style: .bold)
    }
    
    public static var h2Black: UIFont {
        return ChofyFont.font(.h2, style: .black)
    }
    
    // MARK: Headline font
    public static var headlineThin: UIFont {
        return ChofyFont.font(.headline, style: .thin)
    }
    
    public static var headlineLight: UIFont {
        return ChofyFont.font(.headline, style: .light)
    }
    
    public static var headlineRegular: UIFont {
        return ChofyFont.font(.headline, style: .regular)
    }
    
    public static var headlineMedium: UIFont {
        return ChofyFont.font(.headline, style: .medium)
    }
    
    public static var headlineBold: UIFont {
        return ChofyFont.font(.headline, style: .bold)
    }
    
    public static var headlineBlack: UIFont {
        return ChofyFont.font(.headline, style: .black)
    }
    
    // MARK: Body font
    public static var bodyThin: UIFont {
        return ChofyFont.font(.body, style: .thin)
    }
    
    public static var bodyLight: UIFont {
        return ChofyFont.font(.body, style: .light)
    }
    
    public static var bodyRegular: UIFont {
        return ChofyFont.font(.body, style: .regular)
    }
    
    public static var bodyMedium: UIFont {
        return ChofyFont.font(.body, style: .medium)
    }
    
    public static var bodyBold: UIFont {
        return ChofyFont.font(.body, style: .bold)
    }
    
    public static var bodyBlack: UIFont {
        return ChofyFont.font(.body, style: .black)
    }
    
    // MARK: Caption One font
    public static var captionOneThin: UIFont {
        return ChofyFont.font(.captionOne, style: .thin)
    }
    
    public static var captionOneLight: UIFont {
        return ChofyFont.font(.captionOne, style: .light)
    }
    
    public static var captionOneRegular: UIFont {
        return ChofyFont.font(.captionOne, style: .regular)
    }
    
    public static var captionOneMedium: UIFont {
        return ChofyFont.font(.captionOne, style: .medium)
    }
    
    public static var captionOneBold: UIFont {
        return ChofyFont.font(.captionOne, style: .bold)
    }
    
    public static var captionOneBlack: UIFont {
        return ChofyFont.font(.captionOne, style: .black)
    }
    
    // MARK: Caption Two font
    public static var captionTwoThin: UIFont {
        return ChofyFont.font(.captionTwo, style: .thin)
    }
    
    public static var captionTwoLight: UIFont {
        return ChofyFont.font(.captionTwo, style: .light)
    }
    
    public static var captionTwoRegular: UIFont {
        return ChofyFont.font(.captionTwo, style: .regular)
    }
    
    public static var captionTwoMedium: UIFont {
        return ChofyFont.font(.captionTwo, style: .medium)
    }
    
    public static var captionTwoBold: UIFont {
        return ChofyFont.font(.captionTwo, style: .bold)
    }
    
    public static var captionTwoBlack: UIFont {
        return ChofyFont.font(.captionTwo, style: .black)
    }
    
    // MARK: Label font
    public static var labelThin: UIFont {
        return ChofyFont.font(.label, style: .thin)
    }
    
    public static var labelLight: UIFont {
        return ChofyFont.font(.label, style: .light)
    }
    
    public static var labelRegular: UIFont {
        return ChofyFont.font(.label, style: .regular)
    }
    
    public static var labelMedium: UIFont {
        return ChofyFont.font(.label, style: .medium)
    }
    
    public static var labelBold: UIFont {
        return ChofyFont.font(.label, style: .bold)
    }
    
    public static var labelBlack: UIFont {
        return ChofyFont.font(.label, style: .black)
    }
    
    // MARK: Small font
    public static var smallThin: UIFont {
        return ChofyFont.font(.small, style: .thin)
    }
    
    public static var smallLight: UIFont {
        return ChofyFont.font(.small, style: .light)
    }
    
    public static var smallRegular: UIFont {
        return ChofyFont.font(.small, style: .regular)
    }
    
    public static var smallMedium: UIFont {
        return ChofyFont.font(.small, style: .medium)
    }
    
    public static var smallBold: UIFont {
        return ChofyFont.font(.small, style: .bold)
    }
    
    public static var smallBlack: UIFont {
        return ChofyFont.font(.small, style: .black)
    }
}

public class ChofyFont {
    static func font(_ fontSize: CGFloat, style: String) -> UIFont {
        UIFont.register(font: style, withExtension: "otf")
        let font = UIFont(name: style, size: fontSize)
        return font ?? UIFont.defaultFont(size: fontSize)
    }
    
    static func font(_ fontSize: ChofyFontSize, style: ChofyFontStyle) -> UIFont {
        return ChofyFont.font(fontSize.rawValue, style: style.rawValue)
    }
}

public extension UIFont {
    convenience init?(_ type: ChofyFontStyle, size: CGFloat) {
        self.init(name: type.rawValue, size: size)
    }
    
    static func defaultFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    static func register(font named: String, withExtension extensionType: String) {
        let bundle = ChofyStyleBundle.bundle
        var error: Unmanaged<CFError>? = nil
        defer { error?.release() }
        guard let url = bundle.url(forResource: named, withExtension: extensionType),
              let provider = CGDataProvider(url: url as CFURL) else { return }
        if let font = CGFont(provider) {
            _ = CTFontManagerRegisterGraphicsFont(font, &error)
        }
    }
}
