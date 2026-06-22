//
//  SegmentedPillControl.swift
//  BankCrude
//
//  Created by Meynabel Dimas Wisodewo on 18/06/26.
//

import SwiftUI

/// A highly reusable segmented control styled as a pill selector.
/// Matches the design from `pill.png` with a dark background and sliding red capsule indicator.
public struct SegmentedPillControl<T: Hashable>: View {
    @Binding private var selection: T
    private let items: [T]
    private let titleMapper: (T) -> String
    
    @Namespace private var animationNamespace
    
    /// Initializes the SegmentedPillControl.
    /// - Parameters:
    ///   - selection: Binding to the selected option.
    ///   - items: The list of items to display.
    ///   - titleMapper: A closure mapping an item to its display title.
    public init(
        selection: Binding<T>,
        items: [T],
        titleMapper: @escaping (T) -> String
    ) {
        self._selection = selection
        self.items = items
        self.titleMapper = titleMapper
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(items, id: \.self) { item in
                let isSelected = selection == item
                
                Button(action: {
                    if selection != item {
                        withAnimation(.spring(response: 0.32, dampingFraction: 0.78, blendDuration: 0)) {
                            selection = item
                        }
                    }
                }) {
                    Text(titleMapper(item))
                        .typography(.subheadline, weight: .semibold)
                        .foregroundColor(isSelected ? .white : .white.opacity(0.6))
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
                .background(
                    ZStack {
                        if isSelected {
                            Capsule()
                                .fill(Color.primaryRed)
                                .matchedGeometryEffect(id: "activePill", in: animationNamespace)
                        }
                    }
                )
            }
        }
        .padding(4)
        .background(Color.primaryBlack)
        .clipShape(Capsule())
        .shadow(color: Color.primaryBlack.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Preview
#Preview {
    struct PreviewWrapper: View {
        @State private var selection = "Transactions"
        let items = ["All", "Transactions", "Others"]
        
        var body: some View {
            VStack(spacing: 20) {
                SegmentedPillControl(
                    selection: $selection,
                    items: items,
                    titleMapper: { $0 }
                )
                .padding(.horizontal, 24)
                
                Text("Selected: \(selection)")
                    .typography(.body, weight: .medium)
                    .foregroundColor(.textPrimary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundWhite)
        }
    }
    
    return PreviewWrapper()
}
