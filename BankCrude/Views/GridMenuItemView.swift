//
//  GridMenuItemView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

/// A clean data model representing a menu item in the transaction feature grid.
public struct GridMenuItem: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let title: String
    public let iconName: String
    public let isSystemIcon: Bool
    public let isNewFeature: Bool
    
    /// Initializes a GridMenuItem.
    /// - Parameters:
    ///   - id: Unique identifier. Defaults to a new UUID.
    ///   - title: The display title of the menu item.
    ///   - iconName: The name of the icon (SF Symbol or custom asset name).
    ///   - isSystemIcon: A boolean flag indicating if `iconName` refers to an SF Symbol. Defaults to true.
    ///   - isNewFeature: A boolean flag indicating if this menu item represents a new feature. Defaults to false.
    public init(
        id: UUID = UUID(),
        title: String,
        iconName: String,
        isSystemIcon: Bool = true,
        isNewFeature: Bool = false
    ) {
        self.id = id
        self.title = title
        self.iconName = iconName
        self.isSystemIcon = isSystemIcon
        self.isNewFeature = isNewFeature
    }
}

/// A reusable SwiftUI view displaying a premium grid menu button.
/// Features a rounded border with the app's primary red styling and micro-interaction scaling.
public struct GridMenuItemView: View {
    public let item: GridMenuItem
    public let onTap: () -> Void
    
    /// Initializes a GridMenuItemView.
    /// - Parameters:
    ///   - item: The menu item data model to render.
    ///   - onTap: Callback triggered when the user taps the item.
    public init(item: GridMenuItem, onTap: @escaping () -> Void) {
        self.item = item
        self.onTap = onTap
    }
    
    public var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                Spacer(minLength: 0)
                
                // Icon
                if item.isSystemIcon {
                    Image(systemName: item.iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.textPrimary)
                } else {
                    Image(item.iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
                
                Spacer(minLength: 0)
                
                // Title
                Text(item.title)
                    .typography(size: 10, weight: .regular)
                    .foregroundColor(.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .minimumScaleFactor(0.7)
                    .padding(.horizontal, 4)
                    .frame(maxWidth: .infinity)
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .aspectRatio(1.0, contentMode: .fit)
            .background(Color.white)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.primaryRed, lineWidth: 1)
            )
            .cornerRibbon("NEW", gradient: .ribbonRed, isVisible: item.isNewFeature)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

/// A button style that implements a scaling animation when pressed, enhancing visual feedback.
public struct ScaleButtonStyle: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

#Preview {
    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
        GridMenuItemView(
            item: GridMenuItem(
                title: "Transfer Same Bank",
                iconName: "arrow.up"
            ),
            onTap: { print("Tapped item") }
        )
        GridMenuItemView(
            item: GridMenuItem(
                title: "Mobile Data",
                iconName: "iphone"
            ),
            onTap: { print("Tapped item") }
        )
    }
    .padding(24)
    .background(Color.backgroundWhite)
}
