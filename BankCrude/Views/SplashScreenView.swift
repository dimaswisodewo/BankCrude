//
//  SplashScreenView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var animateLogo = false
    @State private var animateText = false
    
    var body: some View {
        ZStack {
            Color.backgroundWhite
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                HStack(spacing: 6) {
                    Text("Bank")
                        .typography(font: .poppins, size: 36, weight: .bold, relativeTo: .largeTitle)
                        .foregroundColor(.primaryBlack)
                    Text("Crude")
                        .typography(font: .poppins, size: 36, weight: .bold, relativeTo: .largeTitle)
                        .foregroundColor(.primaryRed)
                }
                .offset(y: animateText ? 0 : 20)
                .opacity(animateText ? 1.0 : 0.0)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6, blendDuration: 0).delay(0.2)) {
                animateLogo = true
            }
            withAnimation(.easeOut(duration: 0.6).delay(0.5)) {
                animateText = true
            }
        }
    }
}

// MARK: - Reusable Modifier & Extension

public struct SplashScreenModifier: ViewModifier {
    @State private var showSplash = true
    public var duration: Double
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            if showSplash {
                SplashScreenView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: showSplash)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                showSplash = false
            }
        }
    }
}

public extension View {
    /// Applies a custom animated splash screen that dismisses automatically after a duration.
    /// - Parameter duration: The duration in seconds to show the splash screen. Default is 2.0.
    func withSplashScreen(duration: Double = 2.0) -> some View {
        self.modifier(SplashScreenModifier(duration: duration))
    }
}

#Preview {
    SplashScreenView()
}
