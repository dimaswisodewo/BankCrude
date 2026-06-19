//
//  TransactionRowView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

/// The flow type of a transaction.
public enum TransactionType: String, Codable {
    case inflow
    case outflow
}

/// The execution status of a transaction.
public enum TransactionStatus: String, Codable {
    case success
    case failed
    case pending
    
    public var backgroundColor: Color {
        switch self {
        case .success:
            return Color.successGreenBg
        case .failed:
            return Color.failedRedBg
        case .pending:
            return Color(hex: "FFF3E0")
        }
    }
    
    public var foregroundColor: Color {
        switch self {
        case .success:
            return Color.successGreen
        case .failed:
            return Color.failedRed
        case .pending:
            return Color(hex: "F57C00")
        }
    }
}

/// Data model representing a transaction item.
public struct TransactionItem: Identifiable, Equatable, Hashable {
    public let id: UUID
    public let date: Date
    public let title: String
    public let subtitle: String
    public let amount: Decimal
    public let type: TransactionType
    public let status: TransactionStatus?
    public let note: String?
    public let sourceAccountName: String?
    public let sourceAccountNumber: String?
    
    public init(
        id: UUID = UUID(),
        date: Date,
        title: String,
        subtitle: String,
        amount: Decimal,
        type: TransactionType,
        status: TransactionStatus? = nil,
        note: String? = nil,
        sourceAccountName: String? = nil,
        sourceAccountNumber: String? = nil
    ) {
        self.id = id
        self.date = date
        self.title = title
        self.subtitle = subtitle
        self.amount = amount
        self.type = type
        self.status = status
        self.note = note
        self.sourceAccountName = sourceAccountName
        self.sourceAccountNumber = sourceAccountNumber
    }
    
    public var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    public var monthString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: date)
    }
    
    public var yearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: date)
    }
    
    public var amountString: String {
        amount.formattedAsRupiah()
    }
}

/// A reusable SwiftUI component that displays a single transaction in a clean, modern row layout.
public struct TransactionRowView: View {
    public let transaction: TransactionItem
    public let showChevron: Bool
    public let onTap: (() -> Void)?
    
    /// Initializes the transaction row view.
    /// - Parameters:
    ///   - transaction: The transaction model to display.
    ///   - showChevron: Optional override to control chevron visibility. Defaults to true if `onTap` is provided.
    ///   - onTap: An optional action block triggered when the user taps the row.
    public init(
        transaction: TransactionItem,
        showChevron: Bool? = nil,
        onTap: (() -> Void)? = nil
    ) {
        self.transaction = transaction
        self.onTap = onTap
        self.showChevron = showChevron ?? (onTap != nil)
    }
    
    public var body: some View {
        if let onTap = onTap {
            Button(action: onTap) {
                rowContent
            }
            .buttonStyle(PlainButtonStyle())
        } else {
            rowContent
        }
    }
    
    private var rowContent: some View {
        HStack(alignment: .center, spacing: 16) {
            // Date column
            VStack(spacing: 2) {
                Text(transaction.dayString)
                    .typography(.title2, weight: .bold)
                    .foregroundColor(.textPrimary)
                Text(transaction.monthString)
                    .typography(.caption, weight: .semibold)
                    .foregroundColor(.textSecondary)
                Text(transaction.yearString)
                    .typography(.caption, weight: .semibold)
                    .foregroundColor(.textSecondary)
            }
            .frame(width: 50)
            
            // Transaction Details Column
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .typography(.body, weight: .semibold)
                    .foregroundColor(.textPrimary)
                    .lineLimit(1)
                
                Text(transaction.amountString)
                    .typography(.subheadline, weight: .bold)
                    .foregroundColor(transaction.type == .inflow ? .transactionGreen : .transactionRed)
                
                Text(transaction.subtitle)
                    .typography(.footnote, weight: .regular)
                    .foregroundColor(.textSecondary)
                    .lineLimit(2)
                
                if let status = transaction.status {
                    Text(status.rawValue.capitalized)
                        .typography(.caption, weight: .semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(status.backgroundColor)
                        .foregroundColor(status.foregroundColor)
                        .clipShape(Capsule())
                        .padding(.top, 2)
                }
            }
            
            Spacer()
            
            // Chevron indicator if interactive
            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.textSecondary)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .contentShape(Rectangle())
    }
}

#Preview {
    let calendar = Calendar.current
    let baseDate = calendar.date(from: DateComponents(year: 2026, month: 6, day: 24)) ?? Date()
    
    return ScrollView {
        VStack(spacing: 0) {
            // 1. Success Outflow (with chevron)
            TransactionRowView(
                transaction: TransactionItem(
                    date: baseDate,
                    title: "Meynabel Dimas Wisodewo",
                    subtitle: "Transfer to BCA Account",
                    amount: 50000.00,
                    type: .outflow,
                    status: .success
                ),
                onTap: { print("Tapped item 1") }
            )
            
            Divider().padding(.horizontal, 24)
            
            // 2. Inflow (no chevron, no status)
            TransactionRowView(
                transaction: TransactionItem(
                    date: calendar.date(byAdding: .day, value: -2, to: baseDate) ?? baseDate,
                    title: "Meynabel Dimas Wisodewo",
                    subtitle: "Received from Radhita Salsabila - CIMB Account",
                    amount: 99000000.00,
                    type: .inflow,
                    status: nil
                )
            )
            
            Divider().padding(.horizontal, 24)
            
            // 3. Failed Outflow (with chevron)
            TransactionRowView(
                transaction: TransactionItem(
                    date: calendar.date(byAdding: .day, value: -3, to: baseDate) ?? baseDate,
                    title: "Meynabel Dimas Wisodewo",
                    subtitle: "Transfer to Bank Jago Account",
                    amount: 2000000.00,
                    type: .outflow,
                    status: .failed
                ),
                onTap: { print("Tapped item 3") }
            )
            
            Divider().padding(.horizontal, 24)
            
            // 4. Success Outflow (with chevron)
            TransactionRowView(
                transaction: TransactionItem(
                    date: calendar.date(byAdding: .day, value: -4, to: baseDate) ?? baseDate,
                    title: "Meynabel Dimas Wisodewo",
                    subtitle: "Virtual Account Transfer to BCA Account",
                    amount: 250000.00,
                    type: .outflow,
                    status: .success
                ),
                onTap: { print("Tapped item 4") }
            )
        }
        .background(Color.backgroundWhite)
    }
}
