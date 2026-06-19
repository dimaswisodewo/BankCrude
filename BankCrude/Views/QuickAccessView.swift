//
//  QuickAccessView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

/// A clean data model representing an item in the Quick Access grid.
/// Wraps `GridMenuItem` or acts as a placeholder for the add new button.
public enum QuickAccessItemType: Identifiable, Equatable {
    case menuItem(GridMenuItem)
    case add
    
    public var id: String {
        switch self {
        case .menuItem(let item):
            return item.id.uuidString
        case .add:
            return "add_button"
        }
    }
}

/// A view that displays a grid of quick access utilities.
/// Built using the reusable `FlexibleGridView`.
public struct QuickAccessView: View {
    public let onItemTap: (GridMenuItem) -> Void
    public let onEditTap: (Bool) -> Void
    public let onAddTap: () -> Void
    
    @State private var isEditing = false
    
    // Grid items representing the E-Money, Virtual Account, PLN Electricity, PDAM, Credit Card, and Installment options.
    private let items: [QuickAccessItemType] = MockData.quickAccessItems
    
    public init(
        onItemTap: @escaping (GridMenuItem) -> Void,
        onEditTap: @escaping (Bool) -> Void,
        onAddTap: @escaping () -> Void
    ) {
        self.onItemTap = onItemTap
        self.onEditTap = onEditTap
        self.onAddTap = onAddTap
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header Section
            SectionHeaderView(
                "Quick Access",
                buttonTitle: isEditing ? "Save" : "Edit",
                buttonAction: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        isEditing.toggle()
                    }
                    onEditTap(isEditing)
                }
            )
            
            // Reusable Grid View
            FlexibleGridView(
                items,
                columnsCount: 4,
                horizontalSpacing: 12,
                verticalSpacing: 12
            ) { itemType in
                switch itemType {
                case .menuItem(let item):
                    ZStack(alignment: .topTrailing) {
                        GridMenuItemView(item: item) {
                            if !isEditing {
                                onItemTap(item)
                            }
                        }
                        .disabled(isEditing)
                        .quickAccessShake(isEnabled: isEditing)
                        
                        if isEditing {
                            Button(action: {
                                // Visual indicator only: deletion logic disabled per request
                                print("Tapped delete indicator for \(item.title)")
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.primaryRed)
                                    .background(Color.white.clipShape(Circle()))
                                    .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 1)
                            }
                            .buttonStyle(.plain)
                            .offset(x: 4, y: -4)
                            .transition(.scale.combined(with: .opacity))
                        }
                    }
                case .add:
                    Button(action: onAddTap) {
                        VStack {
                            Spacer()
                            Circle()
                                .fill(Color.primaryRed.opacity(0.1))
                                .frame(width: 48, height: 48)
                                .overlay(
                                    Image(systemName: "plus")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.primaryRed)
                                )
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1.0, contentMode: .fit)
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .disabled(isEditing)
                }
            }
        }
    }
}

struct QuickAccessShakeModifier: ViewModifier {
    let isEnabled: Bool
    @State private var isShaking = false
    
    private let angleOffset = Double.random(in: -0.15...0.15)
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(isEnabled ? (isShaking ? 1.2 + angleOffset : -1.2 + angleOffset) : 0))
            .offset(
                x: isEnabled ? (isShaking ? -0.8 : 0.8) : 0,
                y: isEnabled ? (isShaking ? 0.4 : -0.4) : 0
            )
            .onAppear {
                if isEnabled {
                    startShaking()
                }
            }
            .onChange(of: isEnabled) { _, newValue in
                if newValue {
                    startShaking()
                } else {
                    withAnimation(.easeOut(duration: 0.15)) {
                        isShaking = false
                    }
                }
            }
    }
    
    private func startShaking() {
        isShaking = false
        let delay = Double.random(in: 0...0.08)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            guard isEnabled else { return }
            withAnimation(
                Animation.linear(duration: 0.12)
                    .repeatForever(autoreverses: true)
            ) {
                isShaking = true
            }
        }
    }
}

extension View {
    func quickAccessShake(isEnabled: Bool) -> some View {
        self.modifier(QuickAccessShakeModifier(isEnabled: isEnabled))
    }
}

#Preview {
    QuickAccessView(
        onItemTap: { item in print("Tapped \(item.title)") },
        onEditTap: { isEditing in print("Tapped Edit: \(isEditing)") },
        onAddTap: { print("Tapped Add") }
    )
    .padding(24)
    .background(Color.backgroundWhite)
}
