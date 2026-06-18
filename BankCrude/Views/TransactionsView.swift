//
//  TransactionsView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

/// Represents a grouped section of transactional menu items.
struct TransactionSection: Identifiable {
    let id = UUID()
    let title: String
    let columnsCount: Int?
    let items: [GridMenuItem]
}

/// The main Transactions screen conforming to the visual mockup `transactions-view.png`.
/// Integrates the reusable `SearchBarView` (with debounce mechanism), `FlexibleGridView`, and `GridMenuItemView` components.
struct TransactionsView: View {
    @State private var searchText = ""
    @State private var debouncedQuery = ""
    @State private var selectedItemMessage: String?
    
    // The data source defining all sections and items matching the mockup
    private let allSections = [
        TransactionSection(
            title: "Transfer",
            columnsCount: 4,
            items: [
                GridMenuItem(title: "Transfer Same Bank", iconName: "arrow.up"),
                GridMenuItem(title: "Transfer Other Bank", iconName: "building.columns"),
                GridMenuItem(title: "Virtual Account", iconName: "banknote"),
                GridMenuItem(title: "Proxy Address", iconName: "globe")
            ]
        ),
        TransactionSection(
            title: "Mobile",
            columnsCount: 4,
            items: [
                GridMenuItem(title: "Mobile Data", iconName: "iphone"),
                GridMenuItem(title: "Phone Credit", iconName: "phone.arrow.up.right"),
                GridMenuItem(title: "Post Paid", iconName: "iphone.badge.exclamationmark")
            ]
        ),
        TransactionSection(
            title: "Bills",
            columnsCount: 4,
            items: [
                GridMenuItem(title: "Credit Card", iconName: "creditcard"),
                GridMenuItem(title: "PLN Electricity", iconName: "lightbulb"),
                GridMenuItem(title: "PDAM", iconName: "drop"),
                GridMenuItem(title: "Installment", iconName: "creditcard"),
                GridMenuItem(title: "BPJS", iconName: "person.text.rectangle"),
                GridMenuItem(title: "PBB", iconName: "building.2"),
                GridMenuItem(title: "MPN", iconName: "building.columns")
            ]
        ),
        TransactionSection(
            title: "Top-Up",
            columnsCount: 4,
            items: [
                GridMenuItem(title: "E-Money", iconName: "wallet.pass"),
                GridMenuItem(title: "Mobile Legends", iconName: "gamecontroller"),
                GridMenuItem(title: "Genshin Impact", iconName: "gamecontroller")
            ]
        )
    ]
    
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
            .overlay(
                // Floating premium toast for taps
                VStack {
                    Spacer()
                    if let message = selectedItemMessage {
                        Text(message)
                            .typography(.footnote, weight: .semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color.primaryBlack.opacity(0.85))
                            .cornerRadius(24)
                            .shadow(radius: 5)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .padding(.bottom, 20)
                    }
                }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundWhite)
    }
    
    @ViewBuilder
    private func gridItemView(for item: GridMenuItem) -> some View {
        GridMenuItemView(item: item) {
            withAnimation(.spring()) {
                selectedItemMessage = "You tapped: \(item.title)"
            }
            // Auto-dismiss message after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if selectedItemMessage == "You tapped: \(item.title)" {
                    withAnimation {
                        selectedItemMessage = nil
                    }
                }
            }
        }
    }
}

#Preview {
    TransactionsView()
}
