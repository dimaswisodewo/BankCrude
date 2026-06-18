//
//  PrimaryButton.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

/// A highly reusable and SOLID primary button component.
/// Matches the style shown in `primary-button.png` with a dark background, custom icon, and text.
public struct PrimaryButton: View {
    public let title: String
    public let icon: Image?
    public let backgroundColor: Color
    public let foregroundColor: Color
    public let iconColor: Color
    public let height: CGFloat
    public let action: () -> Void
    
    /// Designated initializer for full customization.
    public init(
        title: String,
        icon: Image? = nil,
        backgroundColor: Color = .primaryBlack,
        foregroundColor: Color = .white,
        iconColor: Color = .primaryRed,
        height: CGFloat = 56,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.iconColor = iconColor
        self.height = height
        self.action = action
    }
    
    /// Convenience initializer using a system image name.
    public init(
        title: String,
        systemImageName: String?,
        backgroundColor: Color = .primaryBlack,
        foregroundColor: Color = .white,
        iconColor: Color = .primaryRed,
        height: CGFloat = 56,
        action: @escaping () -> Void
    ) {
        self.title = title
        if let systemImageName = systemImageName {
            self.icon = Image(systemName: systemImageName)
        } else {
            self.icon = nil
        }
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.iconColor = iconColor
        self.height = height
        self.action = action
    }
    @Environment(\.isEnabled) private var isEnabled
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon = icon {
                    icon
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(isEnabled ? iconColor : Color.textSecondary.opacity(0.6))
                }
                
                Text(title)
                    .typography(.body, weight: .semibold)
                    .foregroundColor(isEnabled ? foregroundColor : Color.textSecondary.opacity(0.8))
            }
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(isEnabled ? backgroundColor : Color.textSecondary.opacity(0.15))
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(isEnabled ? 0.12 : 0.0), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}

/// Scale-effect animation on press to provide tactile feedback.
public struct PrimaryButtonStyle: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

#Preview {
    VStack(spacing: 16) {
        PrimaryButton(
            title: "Transfer (Enabled)",
            systemImageName: "arrowshape.turn.up.left.fill"
        ) {
            print("Transfer tapped")
        }
        
        PrimaryButton(
            title: "QRIS (Disabled)",
            systemImageName: "qrcode"
        ) {
            print("QRIS tapped")
        }
        .disabled(true)
    }
    .padding(24)
    .background(Color.backgroundWhite)
}
