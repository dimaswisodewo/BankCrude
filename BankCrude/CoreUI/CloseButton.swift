//
//  CloseButton.swift
//  BankCrude
//
//  Created by Meynabel Dimas Wisodewo on 19/06/26.
//

import SwiftUI

/// A reusable close button styled consistently for navigation bars and sheets.
public struct CloseButton: View {
    public let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text("Close")
                .typography(.footnote, weight: .bold)
                .foregroundColor(.primaryRed)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    ZStack {
                        Capsule()
                            .fill(.ultraThinMaterial)
                        
                        LinearGradient(
                            colors: [.white.opacity(0.3), .clear, .black.opacity(0.03)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .clipShape(Capsule())
                    }
                )
                .overlay(
                    Capsule()
                        .stroke(
                            LinearGradient(
                                colors: [.white.opacity(0.7), .white.opacity(0.15)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1.2
                        )
                )
                .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
        }
        .buttonStyle(CloseButtonStyle())
    }
}

private struct CloseButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

#Preview {
    CloseButton { }
}
