//
//  Typography.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

/// Represents the custom font families stored in the resources directory.
public enum AppFont: String, CaseIterable {
    case poppins = "Poppins"
    
    /// Maps the font family and a specific weight to its registered PostScript font name.
    /// Default custom font resolves to "Poppins-Regular".
    public func postScriptName(for weight: Font.Weight) -> String {
        switch self {
        case .poppins:
            switch weight {
            case .semibold, .bold, .heavy, .black:
                return "Poppins-SemiBold"
            default:
                return "Poppins-Regular"
            }
        }
    }
}

/// Predefined typography styles mapping to custom fonts and default weights with Dynamic Type support.
public enum TypographyStyle: CaseIterable {
    case largeTitle
    case title
    case title2
    case title3
    case headline
    case subheadline
    case body
    case callout
    case footnote
    case caption
    
    /// The font size for the style.
    public var size: CGFloat {
        switch self {
        case .largeTitle: return 34
        case .title: return 28
        case .title2: return 22
        case .title3: return 20
        case .headline: return 17
        case .subheadline: return 15
        case .body: return 17
        case .callout: return 16
        case .footnote: return 13
        case .caption: return 12
        }
    }
    
    /// The app font family for the style.
    public var font: AppFont {
        return .poppins
    }
    
    /// The default font weight for the style.
    public var defaultWeight: Font.Weight {
        switch self {
        case .largeTitle, .title, .title2, .title3, .headline:
            return .semibold
        default:
            return .regular
        }
    }
    
    /// The associated SwiftUI Font.TextStyle for Dynamic Type scaling.
    public var textStyle: Font.TextStyle {
        switch self {
        case .largeTitle: return .largeTitle
        case .title: return .title
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .body: return .body
        case .callout: return .callout
        case .footnote: return .footnote
        case .caption: return .caption
        }
    }
}

/// A SwiftUI ViewModifier that applies a custom AppFont with a specific size, weight, and dynamic scaling behavior.
public struct TypographyModifier: ViewModifier {
    public let fontName: String
    public let size: CGFloat
    public let textStyle: Font.TextStyle
    
    public func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: size, relativeTo: textStyle))
    }
}

public extension View {
    /// Applies a predefined typography style using the custom Poppins font, allowing weight override.
    /// - Parameters:
    ///   - style: The typography style to apply.
    ///   - weight: Optional weight override. If nil, uses the style's default weight.
    func typography(_ style: TypographyStyle, weight: Font.Weight? = nil) -> some View {
        let appliedWeight = weight ?? style.defaultWeight
        let fontName = style.font.postScriptName(for: appliedWeight)
        return self.modifier(TypographyModifier(fontName: fontName, size: style.size, textStyle: style.textStyle))
    }
    
    /// Applies a custom size of a specific custom AppFont with Dynamic Type scaling.
    /// - Parameters:
    ///   - font: The AppFont case (e.g. .poppins). Default is .poppins.
    ///   - size: The size of the font in points.
    ///   - weight: The weight of the font. Defaults to .regular (resolves to Poppins-Regular).
    ///   - textStyle: The SwiftUI TextStyle to scale relative to. Default is .body.
    func typography(
        font: AppFont = .poppins,
        size: CGFloat,
        weight: Font.Weight = .regular,
        relativeTo textStyle: Font.TextStyle = .body
    ) -> some View {
        let fontName = font.postScriptName(for: weight)
        return self.modifier(TypographyModifier(fontName: fontName, size: size, textStyle: textStyle))
    }
}
