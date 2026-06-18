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
    public let onEditTap: () -> Void
    public let onAddTap: () -> Void
    
    // Grid items representing the E-Money, Virtual Account, PLN Electricity, PDAM, Credit Card, and Installment options.
    private let items: [QuickAccessItemType] = [
        .menuItem(GridMenuItem(title: "E-Money", iconName: "wallet.pass")),
        .menuItem(GridMenuItem(title: "Virtual Account", iconName: "building.columns")),
        .menuItem(GridMenuItem(title: "PLN Electricity", iconName: "lightbulb")),
        .menuItem(GridMenuItem(title: "PDAM", iconName: "drop")),
        .menuItem(GridMenuItem(title: "Credit Card", iconName: "creditcard")),
        .menuItem(GridMenuItem(title: "Installment", iconName: "creditcard.trianglebadge.exclamationmark", isNewFeature: true)),
        .add
    ]
    
    public init(
        onItemTap: @escaping (GridMenuItem) -> Void,
        onEditTap: @escaping () -> Void,
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
                buttonTitle: "Edit",
                buttonAction: onEditTap
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
                    GridMenuItemView(item: item) {
                        onItemTap(item)
                    }
                case .add:
                    Button(action: onAddTap) {
                        VStack {
                            Spacer()
                            Image(systemName: "plus")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.primaryRed)
                                .frame(width: 48, height: 48)
                                .background(Color.white)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.primaryRed, lineWidth: 1.5)
                                )
                                .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1.0, contentMode: .fit)
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
        }
    }
}

#Preview {
    QuickAccessView(
        onItemTap: { item in print("Tapped \(item.title)") },
        onEditTap: { print("Tapped Edit") },
        onAddTap: { print("Tapped Add") }
    )
    .padding(24)
    .background(Color.backgroundWhite)
}
