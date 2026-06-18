//
//  ToastView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

/// A premium, reusable floating toast view matching the design system of BankCrude.
public struct ToastView: View {
    public let message: String
    
    public init(message: String) {
        self.message = message
    }
    
    public var body: some View {
        Text(message)
            .typography(.footnote, weight: .semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.primaryBlack.opacity(0.85))
            .cornerRadius(24)
            .shadow(radius: 5)
    }
}

/// A view modifier that handles presenting and auto-dismissing a floating toast message.
public struct ToastModifier: ViewModifier {
    @Binding var message: String?
    public let duration: TimeInterval
    
    @State private var dismissTask: DispatchWorkItem?
    
    public func body(content: Content) -> some View {
        content
            .overlay(
                VStack {
                    Spacer()
                    if let message = message {
                        ToastView(message: message)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .padding(.bottom, 20)
                    }
                }
                .animation(.spring(response: 0.35, dampingFraction: 0.7, blendDuration: 0), value: message)
            )
            .onChange(of: message) { _, _ in
                // Cancel any pending dismissal task so we don't dismiss early on rapid clicks
                dismissTask?.cancel()
                
                let task = DispatchWorkItem {
                    withAnimation {
                        message = nil
                    }
                }
                dismissTask = task
                
                DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: task)
            }
    }
}

public extension View {
    /// Applies a premium floating toast to the view hierarchy.
    /// - Parameters:
    ///   - message: A binding to an optional string message. Setting it to a non-nil value displays the toast.
    ///   - duration: The duration in seconds before the toast is auto-dismissed. Defaults to 2.0.
    func toast(message: Binding<String?>, duration: TimeInterval = 2.0) -> some View {
        self.modifier(ToastModifier(message: message, duration: duration))
    }
}
