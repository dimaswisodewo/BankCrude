//
//  NotificationRowView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

/// The category of notification.
public enum NotificationType: String, Codable {
    case spending
    case income
    case general
}

/// Data model representing a notification item.
public struct NotificationItem: Identifiable, Equatable {
    public let id: UUID
    public let date: Date
    public let title: String
    public let amount: Decimal?
    public let type: NotificationType
    public let detail: String
    public let isUnread: Bool
    
    public init(
        id: UUID = UUID(),
        date: Date,
        title: String,
        amount: Decimal?,
        type: NotificationType,
        detail: String,
        isUnread: Bool = false
    ) {
        self.id = id
        self.date = date
        self.title = title
        self.amount = amount
        self.type = type
        self.detail = detail
        self.isUnread = isUnread
    }
    
    /// Formats the date to match the "16 June 2026" visual representation.
    public var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
}

/// A reusable SwiftUI component that displays a single notification item with rich formatted text.
public struct NotificationRowView: View {
    public let notification: NotificationItem
    public let onTap: (() -> Void)?
    
    /// Initializes the notification row view.
    /// - Parameters:
    ///   - notification: The notification model to display.
    ///   - onTap: An optional action block triggered when the user taps the row.
    public init(
        notification: NotificationItem,
        onTap: (() -> Void)? = nil
    ) {
        self.notification = notification
        self.onTap = onTap
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
        VStack(alignment: .leading, spacing: 8) {
            // Date
            Text(notification.dateString)
                .typography(.footnote, weight: .regular)
                .foregroundColor(.textSecondary)
            
            // Title
            Text(notification.title)
                .typography(.body, weight: .bold)
                .foregroundColor(.textPrimary)
            
            // Message (Rich text with inline amount styling)
            messageView
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .contentShape(Rectangle())
        .background(Color.backgroundWhite)
        .cornerRibbon("NEW", gradient: .ribbonBlue, isVisible: notification.isUnread)
    }
    
    @ViewBuilder
    private var messageView: some View {
        let font = AppFont.poppins
        let regularFont = Font.custom(font.postScriptName(for: .regular), size: 14, relativeTo: .subheadline)
        let boldFont = Font.custom(font.postScriptName(for: .bold), size: 14, relativeTo: .subheadline)
        
        switch notification.type {
        case .spending:
            if let amount = notification.amount {
                Text("You spent ")
                    .font(regularFont)
                    .foregroundColor(.textPrimary)
                + Text(amount.formattedAsRupiah())
                    .font(boldFont)
                    .foregroundColor(.transactionRed)
                + Text(" \(notification.detail)")
                    .font(regularFont)
                    .foregroundColor(.textPrimary)
            } else {
                Text(notification.detail)
                    .font(regularFont)
                    .foregroundColor(.textPrimary)
            }
            
        case .income:
            if let amount = notification.amount {
                Text("You received ")
                    .font(regularFont)
                    .foregroundColor(.textPrimary)
                + Text(amount.formattedAsRupiah())
                    .font(boldFont)
                    .foregroundColor(.transactionGreen)
                + Text(" \(notification.detail)")
                    .font(regularFont)
                    .foregroundColor(.textPrimary)
            } else {
                Text(notification.detail)
                    .font(regularFont)
                    .foregroundColor(.textPrimary)
            }
            
        case .general:
            Text(notification.detail)
                .font(regularFont)
                .foregroundColor(.textPrimary)
        }
    }
}

#Preview {
    let calendar = Calendar.current
    let date = calendar.date(from: DateComponents(year: 2026, month: 6, day: 16)) ?? Date()
    
    let mockNotifications = [
        NotificationItem(
            date: date,
            title: "Cashflow - Spending",
            amount: 50000.00,
            type: .spending,
            detail: "to Meynabel Dimas Wisodewo - Bank Jago at Investment Category",
            isUnread: true
        ),
        NotificationItem(
            date: date,
            title: "Cashflow - Spending",
            amount: 10050000.00,
            type: .spending,
            detail: "at Shopping",
            isUnread: false
        ),
        NotificationItem(
            date: date,
            title: "Cashflow - Income",
            amount: 2150000.00,
            type: .income,
            detail: "from Meynabel Dimas Wisodewo at Shopping Category",
            isUnread: true
        ),
        NotificationItem(
            date: date,
            title: "Cashflow - Income",
            amount: 2150000.00,
            type: .income,
            detail: "from Meynabel Dimas Wisodewo at Shopping Category"
        )
    ]
    
    return ScrollView {
        VStack(spacing: 0) {
            ForEach(mockNotifications) { item in
                NotificationRowView(notification: item)
                
                if item.id != mockNotifications.last?.id {
                    Divider()
                        .background(Color.black.opacity(0.06))
                        .padding(.horizontal, 24)
                }
            }
        }
    }
    .background(Color.backgroundWhite)
}
