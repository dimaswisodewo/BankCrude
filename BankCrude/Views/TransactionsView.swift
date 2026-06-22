//
//  TransactionsView.swift
//  BankCrude
//
//  Created by Meynabel Dimas Wisodewo on 18/06/26.
//

import SwiftUI

public struct TransactionSection: Identifiable {
    public let id: UUID
    public let title: String
    public let columnsCount: Int?
    public let items: [GridMenuItem]

    public init(id: UUID = UUID(), title: String, columnsCount: Int? = nil, items: [GridMenuItem]) {
        self.id = id
        self.title = title
        self.columnsCount = columnsCount
        self.items = items
    }
}

/// The main Transactions screen conforming to the visual mockup `transactions-view.png`.
/// Integrates the reusable `SearchBarView` (with debounce mechanism), `FlexibleGridView`, and `GridMenuItemView` components.
struct TransactionsView: View {
    @State private var searchText = ""
    @State private var debouncedQuery = ""
    @State private var selectedItemMessage: String?
    
    // The data source defining all sections and items matching the mockup
    private let allSections = MockData.transactionSections
    
    // Computes which sections and items to show based on the debounced search query
    private var filteredSections: [TransactionSection] {
        if debouncedQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return allSections
        }
        
        return allSections.compactMap { section in
            let matchingItems = section.items.filter { item in
                item.title.localizedCaseInsensitiveContains(debouncedQuery)
            }
            
            if matchingItems.isEmpty {
                return nil
            }
            
            return TransactionSection(
                title: section.title,
                columnsCount: section.columnsCount,
                items: matchingItems
            )
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Search Bar Area
            VStack(spacing: 8) {
                SearchBarView(
                    text: $searchText,
                    placeholder: "Search",
                    delay: 0.35
                ) { term in
                    // Debounced query is updated here
                    withAnimation(.easeInOut(duration: 0.2)) {
                        debouncedQuery = term
                    }
                    print("Debounced search callback triggered with term: '\(term)'")
                }
                
                // Visual indicators for debouncing status (Premium UI touch)
                HStack {
                    if searchText != debouncedQuery {
                        HStack(spacing: 6) {
                            ProgressView()
                                .controlSize(.mini)
                            Text("Typing...")
                                .typography(.caption, weight: .regular)
                                .foregroundColor(.textSecondary)
                        }
                    } else if !debouncedQuery.isEmpty {
                        Text("Showing results for \"\(debouncedQuery)\"")
                            .typography(.caption, weight: .semibold)
                            .foregroundColor(.primaryRed)
                    }
                    Spacer()
                }
                .frame(height: 16)
                .padding(.horizontal, 8)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 8)
            
            // Grid content
            ScrollView(.vertical, showsIndicators: false) {
                if filteredSections.isEmpty {
                    VStack(spacing: 16) {
                        Spacer(minLength: 40)
                        Image(systemName: "magnifyingglass.circle")
                            .font(.system(size: 48))
                            .foregroundColor(.textSecondary.opacity(0.6))
                        
                        Text("No matching transaction features found")
                            .typography(.body, weight: .medium)
                            .foregroundColor(.textSecondary)
                        
                        Text("Try searching for another keyword")
                            .typography(.footnote, weight: .regular)
                            .foregroundColor(.textSecondary.opacity(0.8))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 24)
                    .transition(.opacity)
                } else {
                    VStack(alignment: .leading, spacing: 24) {
                        ForEach(filteredSections) { section in
                            VStack(alignment: .leading, spacing: 16) {
                                SectionHeaderView(section.title)
                                
                                if let columnsCount = section.columnsCount {
                                    FlexibleGridView(
                                        section.items,
                                        columnsCount: columnsCount,
                                        horizontalSpacing: 12,
                                        verticalSpacing: 12,
                                        content: gridItemView
                                    )
                                } else {
                                    FlexibleGridView(
                                        section.items,
                                        horizontalSpacing: 12,
                                        verticalSpacing: 12,
                                        content: gridItemView
                                    )
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.bottom, 24)
                    .transition(.opacity)
                }
            }
            .toast(message: $selectedItemMessage)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundWhite)
    }
    
    @ViewBuilder
    private func gridItemView(for item: GridMenuItem) -> some View {
        GridMenuItemView(item: item) {
            selectedItemMessage = "You tapped: \(item.title)"
        }
    }
}

#Preview {
    TransactionsView()
}
