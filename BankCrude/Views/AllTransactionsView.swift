//
//  AllTransactionsView.swift
//  BankCrude
//
//  Created by Meynabel Dimas Wisodewo on 18/06/26.
//

import SwiftUI

enum TransactionFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case inflow = "Inflow"
    case outflow = "Outflow"
    case success = "Success"
    case failed = "Failed"
    case pending = "Pending"
    
    var id: String { rawValue }
}

struct AllTransactionsView: View {
    @Environment(NavigationRouter.self) private var router
    @State private var searchText = ""
    @State private var debouncedSearchText = ""
    @State private var selectedFilter: TransactionFilter = .all
    
    private var mockAllTransactions: [TransactionItem] {
        MockData.allTransactions
    }
    
    private var groupedTransactions: [(Date, [TransactionItem])] {
        let filtered = mockAllTransactions.filter { item in
            // 1. Text Search Filter
            if !debouncedSearchText.isEmpty {
                let matchesTitle = item.title.localizedCaseInsensitiveContains(debouncedSearchText)
                let matchesSubtitle = item.subtitle.localizedCaseInsensitiveContains(debouncedSearchText)
                let matchesAmount = item.amountString.localizedCaseInsensitiveContains(debouncedSearchText)
                if !matchesTitle && !matchesSubtitle && !matchesAmount {
                    return false
                }
            }
            
            // 2. Chip Filter
            switch selectedFilter {
            case .all:
                return true
            case .inflow:
                return item.type == .inflow
            case .outflow:
                return item.type == .outflow
            case .success:
                return item.status == .success
            case .failed:
                return item.status == .failed
            case .pending:
                return item.status == .pending
            }
        }
        
        // Group by day start date
        let grouped = Dictionary(grouping: filtered) { item in
            Calendar.current.startOfDay(for: item.date)
        }
        
        // Sort descending by date
        return grouped.sorted { $0.key > $1.key }
    }
    
    private func sectionHeaderTitle(for date: Date) -> String {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)
        
        if calendar.isDate(date, inSameDayAs: today) {
            return "Today"
        } else if let yesterday = yesterday, calendar.isDate(date, inSameDayAs: yesterday) {
            return "Yesterday"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM d, yyyy"
            return formatter.string(from: date)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Search Bar Area
            VStack(spacing: 8) {
                SearchBarView(
                    text: $searchText,
                    placeholder: "Search transactions...",
                    delay: 0.35
                ) { term in
                    debouncedSearchText = term
                }
                
                // Visual indicators for debouncing status
                HStack {
                    if searchText != debouncedSearchText {
                        HStack(spacing: 6) {
                            ProgressView()
                                .controlSize(.mini)
                            Text("Typing...")
                                .typography(.caption, weight: .regular)
                                .foregroundColor(.textSecondary)
                        }
                    } else if !debouncedSearchText.isEmpty {
                        Text("Showing results for \"\(debouncedSearchText)\"")
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
            
            // Filter chips scroll area
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(TransactionFilter.allCases) { filter in
                        FilterChip(
                            title: filter.rawValue,
                            isSelected: selectedFilter == filter,
                            action: {
                                selectedFilter = filter
                            }
                        )
                    }
                }
                .padding(.horizontal, 24)
            }
            .frame(height: 36)
            .padding(.bottom, 16)
            
            // Scroll view containing transaction history
            ScrollView(.vertical, showsIndicators: false) {
                if groupedTransactions.isEmpty {
                    VStack(spacing: 16) {
                        Spacer(minLength: 60)
                        Image(systemName: "tray.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.textSecondary.opacity(0.6))
                        
                        Text("No transactions found")
                            .typography(.body, weight: .medium)
                            .foregroundColor(.textSecondary)
                        
                        Text("Try selecting another filter or search query")
                            .typography(.footnote, weight: .regular)
                            .foregroundColor(.textSecondary.opacity(0.8))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 24)
                } else {
                    VStack(alignment: .leading, spacing: 24) {
                        ForEach(groupedTransactions, id: \.0) { date, transactions in
                            VStack(alignment: .leading, spacing: 12) {
                                SectionHeaderView(sectionHeaderTitle(for: date))
                                    .padding(.horizontal, 24)
                                
                                VStack(spacing: 0) {
                                    ForEach(transactions) { transaction in
                                        TransactionRowView(
                                            transaction: transaction,
                                            onTap: {
                                                router.push(.transactionReceipt(transaction, isFromTransfer: false))
                                            }
                                        )
                                        
                                        if transaction.id != transactions.last?.id {
                                            Divider()
                                                .background(Color.black.opacity(0.06))
                                                .padding(.horizontal, 24)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom, 24)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundWhite)
        .navigationTitle("Transaction History")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .typography(.footnote, weight: .semibold)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.primaryBlack : Color.clear)
                .foregroundColor(isSelected ? Color.backgroundWhite : Color.textSecondary)
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(isSelected ? Color.primaryBlack : Color.black.opacity(0.12), lineWidth: 1.2)
                )
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

#Preview {
    PreviewRouterWrapper {
        NavigationStack {
            AllTransactionsView()
        }
    }
}
