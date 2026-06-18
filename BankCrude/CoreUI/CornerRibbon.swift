//
//  CornerRibbon.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

/// Predefined gradients for ribbons that align with the premium styling requirements.
public extension LinearGradient {
    static let ribbonRed = LinearGradient(
        colors: [Color.primaryRed, Color(hex: "B30F08")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let ribbonBlue = LinearGradient(
        colors: [Color(hex: "0A7EFA"), Color(hex: "054C99")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let ribbonGold = LinearGradient(
        colors: [Color(hex: "FFC107"), Color(hex: "FF8F00")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

/// A shape that draws a precise parallel diagonal ribbon across the top-right corner.
public struct CornerRibbonShape: Shape {
    public init() {}
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Parallel diagonal strip in the top-right corner:
        // Left boundary goes from (w * 0.35, 0) to (w, h * 0.65)
        // Right boundary goes from (w * 0.75, 0) to (w, h * 0.25)
        path.move(to: CGPoint(x: w * 0.35, y: 0))
        path.addLine(to: CGPoint(x: w * 0.75, y: 0))
        path.addLine(to: CGPoint(x: w, y: h * 0.25))
        path.addLine(to: CGPoint(x: w, y: h * 0.65))
        path.closeSubpath()
        
        return path
    }
}

/// A internal view that renders the diagonal corner ribbon with rotated text.
struct CornerRibbonView: View {
    let text: String
    let gradient: LinearGradient
    
    var body: some View {
        GeometryReader { geometry in
            let w = geometry.size.width
            let h = geometry.size.height
            
            CornerRibbonShape()
                .fill(gradient)
                .shadow(color: Color.black.opacity(0.12), radius: 2, x: 1, y: 1)
            
            Text(text.uppercased())
                .typography(size: 7.5, weight: .bold)
                .foregroundColor(.white)
                .rotationEffect(.degrees(45))
                // Position text at the mathematical midpoint of the center line
                .position(x: w * 0.775, y: h * 0.225)
        }
    }
}

/// ViewModifier to overlay a corner ribbon on the top-right corner of any view.
public struct CornerRibbonModifier: ViewModifier {
    public let text: String
    public let gradient: LinearGradient
    public let isVisible: Bool
    
    public init(text: String, gradient: LinearGradient = .ribbonRed, isVisible: Bool = true) {
        self.text = text
        self.gradient = gradient
        self.isVisible = isVisible
    }
    
    public func body(content: Content) -> some View {
        if isVisible {
            content
                .overlay(
                    CornerRibbonView(text: text, gradient: gradient)
                        .frame(width: 44, height: 44)
                        .allowsHitTesting(false),
                    alignment: .topTrailing
                )
        } else {
            content
        }
    }
}

public extension View {
    /// Overlays a small diagonal ribbon on the top-right corner of the view.
    /// - Parameters:
    ///   - text: The label to display in the ribbon (e.g. "NEW").
    ///   - gradient: The gradient color scheme for the ribbon. Defaults to `.ribbonRed`.
    ///   - isVisible: Controls whether the ribbon is displayed. Defaults to `true`.
    func cornerRibbon(
        _ text: String,
        gradient: LinearGradient = .ribbonRed,
        isVisible: Bool = true
    ) -> some View {
        self.modifier(CornerRibbonModifier(text: text, gradient: gradient, isVisible: isVisible))
    }
}

// MARK: - Previews
#Preview {
    VStack(spacing: 24) {
        // Red "NEW" ribbon on a square card
        Color.white
            .frame(width: 100, height: 100)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.primaryRed, lineWidth: 1)
            )
            .cornerRibbon("NEW", gradient: .ribbonRed)
            .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
        
        // Blue "NEW" ribbon on a square card
        Color.white
            .frame(width: 100, height: 100)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(hex: "0A7EFA"), lineWidth: 1)
            )
            .cornerRibbon("NEW", gradient: .ribbonBlue)
            .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
            
        // Gold "HOT" ribbon on a square card
        Color.white
            .frame(width: 100, height: 100)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(hex: "FFC107"), lineWidth: 1)
            )
            .cornerRibbon("HOT", gradient: .ribbonGold)
            .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.backgroundWhite)
}
