//
//  MockData.swift
//  BankCrude
//
//  Created by Meynabel Dimas Wisodewo on 19/06/26.
//

import SwiftUI

public struct MockData {
    // MARK: - Cards
    public static let cards: [CardItem] = [
        CardItem(
            accountType: "Saving Account",
            accountNumber: "0342039298",
            balance: 9999999999.00,
            gradientColors: [Color.primaryRed, Color(hex: "C21109")]
        ),
        CardItem(
            accountType: "Secondary Account",
            accountNumber: "0293049102",
            balance: 24500000.00,
            gradientColors: [Color(hex: "1A1D1A"), Color(hex: "343A34")]
        ),
        CardItem(
            accountType: "Investment Account",
            accountNumber: "0938491823",
            balance: 1200000000.00,
            gradientColors: [Color(hex: "0C58A6"), Color(hex: "083E75")]
        )
    ]
    
    // MARK: - Transactions
    public static var allTransactions: [TransactionItem] {
        let calendar = Calendar.current
        let baseDate = calendar.date(from: DateComponents(year: 2026, month: 6, day: 24)) ?? Date()
        
        return [
            TransactionItem(
                date: baseDate,
                title: "Aditya Pratama",
                subtitle: "Transfer to BCA Account (0342039298)",
                amount: 50000.00,
                type: .outflow,
                status: .success,
                note: "Weekly coffee share ☕️",
                sourceAccountName: "Saving Account",
                sourceAccountNumber: "0342039298"
            ),
            TransactionItem(
                date: baseDate,
                title: "Salary Inflow",
                subtitle: "PT Tech Indo - Monthly Salary",
                amount: 15000000.00,
                type: .inflow,
                status: .success,
                sourceAccountName: "Saving Account",
                sourceAccountNumber: "0342039298"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -1, to: baseDate) ?? baseDate,
                title: "PLN Electricity",
                subtitle: "Electricity Bill Payment",
                amount: 450000.00,
                type: .outflow,
                status: .success,
                note: "PLN ID: 53229048123",
                sourceAccountName: "Saving Account",
                sourceAccountNumber: "0342039298"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -1, to: baseDate) ?? baseDate,
                title: "McDonald's",
                subtitle: "Food & Beverage",
                amount: 125000.00,
                type: .outflow,
                status: .success,
                sourceAccountName: "Saving Account",
                sourceAccountNumber: "0342039298"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -2, to: baseDate) ?? baseDate,
                title: "Radhita Salsabila",
                subtitle: "Received from CIMB Account",
                amount: 99000000.00,
                type: .inflow,
                status: nil,
                sourceAccountName: "Saving Account",
                sourceAccountNumber: "0342039298"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -2, to: baseDate) ?? baseDate,
                title: "Steam Wallet Topup",
                subtitle: "Entertainment Purchase",
                amount: 600000.00,
                type: .outflow,
                status: .success,
                note: "Steam Game Bundle Purchases",
                sourceAccountName: "Secondary Account",
                sourceAccountNumber: "0293049102"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -3, to: baseDate) ?? baseDate,
                title: "Agus Subagja",
                subtitle: "Transfer to Bank Jago Account",
                amount: 2000000.00,
                type: .outflow,
                status: .failed,
                note: "Freelance down payment",
                sourceAccountName: "Secondary Account",
                sourceAccountNumber: "0293049102"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -4, to: baseDate) ?? baseDate,
                title: "Tokopedia",
                subtitle: "Virtual Account BCA Payment",
                amount: 250000.00,
                type: .outflow,
                status: .success,
                sourceAccountName: "Secondary Account",
                sourceAccountNumber: "0293049102"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -5, to: baseDate) ?? baseDate,
                title: "Starbucks Coffee",
                subtitle: "Food & Beverage",
                amount: 85000.00,
                type: .outflow,
                status: .success,
                note: "Cappuccino & Croissant",
                sourceAccountName: "Secondary Account",
                sourceAccountNumber: "0293049102"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -6, to: baseDate) ?? baseDate,
                title: "BPJS Health",
                subtitle: "Insurance Premium Payment",
                amount: 150000.00,
                type: .outflow,
                status: .success,
                sourceAccountName: "Saving Account",
                sourceAccountNumber: "0342039298"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -7, to: baseDate) ?? baseDate,
                title: "Tokopedia Refund",
                subtitle: "Refund for cancelled order",
                amount: 1200000.00,
                type: .inflow,
                status: .success,
                sourceAccountName: "Saving Account",
                sourceAccountNumber: "0342039298"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -8, to: baseDate) ?? baseDate,
                title: "Netflix Subscription",
                subtitle: "Entertainment Services",
                amount: 186000.00,
                type: .outflow,
                status: .success,
                sourceAccountName: "Secondary Account",
                sourceAccountNumber: "0293049102"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -10, to: baseDate) ?? baseDate,
                title: "Gopay Topup",
                subtitle: "E-Wallet Topup",
                amount: 500000.00,
                type: .outflow,
                status: .pending,
                sourceAccountName: "Saving Account",
                sourceAccountNumber: "0342039298"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -12, to: baseDate) ?? baseDate,
                title: "Indomaret Purchase",
                subtitle: "Groceries",
                amount: 98500.00,
                type: .outflow,
                status: .success,
                sourceAccountName: "Saving Account",
                sourceAccountNumber: "0342039298"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -14, to: baseDate) ?? baseDate,
                title: "Dividend Payout",
                subtitle: "Stock Market Dividends",
                amount: 350000.00,
                type: .inflow,
                status: .success,
                sourceAccountName: "Investment Account",
                sourceAccountNumber: "0938491823"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -15, to: baseDate) ?? baseDate,
                title: "Gym Membership",
                subtitle: "Monthly subscription",
                amount: 650000.00,
                type: .outflow,
                status: .failed,
                note: "Failed: insufficient balance",
                sourceAccountName: "Secondary Account",
                sourceAccountNumber: "0293049102"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -18, to: baseDate) ?? baseDate,
                title: "Shopee Pay Later",
                subtitle: "Bill Payment",
                amount: 890000.00,
                type: .outflow,
                status: .success,
                sourceAccountName: "Secondary Account",
                sourceAccountNumber: "0293049102"
            )
        ]
    }
    
    public static var dashboardTransactions: [TransactionItem] {
        let calendar = Calendar.current
        let baseDate = calendar.date(from: DateComponents(year: 2026, month: 6, day: 24)) ?? Date()
        
        return [
            TransactionItem(
                date: baseDate,
                title: "Aditya Pratama",
                subtitle: "Transfer to BCA Account (0342039298)",
                amount: 50000.00,
                type: .outflow,
                status: .success,
                note: "Weekly coffee share ☕️",
                sourceAccountName: "Saving Account",
                sourceAccountNumber: "0342039298"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -2, to: baseDate) ?? baseDate,
                title: "Radhita Salsabila",
                subtitle: "Received from CIMB Account",
                amount: 99000000.00,
                type: .inflow,
                status: nil,
                sourceAccountName: "Saving Account",
                sourceAccountNumber: "0342039298"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -3, to: baseDate) ?? baseDate,
                title: "Agus Subagja",
                subtitle: "Transfer to Bank Jago Account",
                amount: 2000000.00,
                type: .outflow,
                status: .failed,
                note: "Freelance down payment",
                sourceAccountName: "Secondary Account",
                sourceAccountNumber: "0293049102"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -4, to: baseDate) ?? baseDate,
                title: "Tokopedia",
                subtitle: "Virtual Account BCA Payment",
                amount: 250000.00,
                type: .outflow,
                status: .success,
                sourceAccountName: "Secondary Account",
                sourceAccountNumber: "0293049102"
            )
        ]
    }
    
    // MARK: - Notifications
    public static var notifications: [NotificationItem] {
        let calendar = Calendar.current
        let dateJune16 = calendar.date(from: DateComponents(year: 2026, month: 6, day: 16)) ?? Date()
        let dateJune15 = calendar.date(from: DateComponents(year: 2026, month: 6, day: 15)) ?? Date()
        let dateJune14 = calendar.date(from: DateComponents(year: 2026, month: 6, day: 14)) ?? Date()
        let dateJune12 = calendar.date(from: DateComponents(year: 2026, month: 6, day: 12)) ?? Date()
        let dateJune10 = calendar.date(from: DateComponents(year: 2026, month: 6, day: 10)) ?? Date()
        
        return [
            NotificationItem(
                date: dateJune16,
                title: "Cashflow - Spending",
                amount: 50000.00,
                type: .spending,
                detail: "to Meynabel Dimas Wisodewo - Bank Jago at Investment Category",
                isUnread: true
            ),
            NotificationItem(
                date: dateJune16,
                title: "Cashflow - Spending",
                amount: 10050000.00,
                type: .spending,
                detail: "at Shopping",
                isUnread: false
            ),
            NotificationItem(
                date: dateJune16,
                title: "Cashflow - Income",
                amount: 2150000.00,
                type: .income,
                detail: "from Meynabel Dimas Wisodewo at Shopping Category",
                isUnread: true
            ),
            NotificationItem(
                date: dateJune16,
                title: "Cashflow - Income",
                amount: 2150000.00,
                type: .income,
                detail: "from Meynabel Dimas Wisodewo at Shopping Category",
                isUnread: false
            ),
            NotificationItem(
                date: dateJune15,
                title: "Cashflow - Income",
                amount: 15000000.00,
                type: .income,
                detail: "from PT Tech Indo at Salary Category",
                isUnread: false
            ),
            NotificationItem(
                date: dateJune15,
                title: "Cashflow - Spending",
                amount: 450000.00,
                type: .spending,
                detail: "to PLN Electricity at Bills Category",
                isUnread: false
            ),
            NotificationItem(
                date: dateJune14,
                title: "Security Alert",
                amount: nil,
                type: .general,
                detail: "A new login was detected on iPhone 15 Pro at 14:32 WIB. If this wasn't you, please secure your account immediately.",
                isUnread: true
            ),
            NotificationItem(
                date: dateJune14,
                title: "System Update",
                amount: nil,
                type: .general,
                detail: "Bank Crude systems will undergo scheduled maintenance on 21 June 2026, 01:00 - 04:00 WIB. Some services may be temporarily unavailable.",
                isUnread: false
            ),
            NotificationItem(
                date: dateJune12,
                title: "Cashflow - Spending",
                amount: 85000.00,
                type: .spending,
                detail: "to Starbucks Coffee at Food & Beverage Category",
                isUnread: false
            ),
            NotificationItem(
                date: dateJune12,
                title: "Cashflow - Income",
                amount: 350000.00,
                type: .income,
                detail: "from Dividend Payout at Investment Category",
                isUnread: false
            ),
            NotificationItem(
                date: dateJune10,
                title: "Special Promotion",
                amount: nil,
                type: .general,
                detail: "Get up to 50% cashback on your first QRIS payment this week! Terms and conditions apply.",
                isUnread: true
            )
        ]
    }
    
    public static var previewNotifications: [NotificationItem] {
        let calendar = Calendar.current
        let date = calendar.date(from: DateComponents(year: 2026, month: 6, day: 16)) ?? Date()
        
        return [
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
    }
    
    // MARK: - Saved Accounts
    public static let savedAccounts: [SavedAccount] = [
        SavedAccount(name: "Radhita Salsabila", bank: "Bank Crude", accountNumber: "0342039298", initials: "RS"),
        SavedAccount(name: "Agus Subagja", bank: "Bank Mandiri", accountNumber: "1293840291", initials: "AS"),
        SavedAccount(name: "Dewi Lestari", bank: "Bank Jago", accountNumber: "9038481234", initials: "DL"),
        SavedAccount(name: "Budi Santoso", bank: "BRI", accountNumber: "0192840294", initials: "BS"),
        SavedAccount(name: "Siti Rahma", bank: "BNI", accountNumber: "7283940192", initials: "SR"),
        SavedAccount(name: "Aditya Pratama", bank: "BCA", accountNumber: "8293849102", initials: "AP"),
        SavedAccount(name: "Joe Cowy", bank: "Bank Crude", accountNumber: "8295842162", initials: "JC"),
        SavedAccount(name: "Geeb Run", bank: "Bank Crude", accountNumber: "8211845363", initials: "GR")
    ]
    
    // MARK: - Recipient Lookup Helper
    public static func recipientName(forAccountNumber accountNumber: String) -> String {
        if let account = savedAccounts.first(where: { $0.accountNumber == accountNumber }) {
            return account.name
        }
        return "Aditya Pratama" // Default fallback name
    }
    
    // MARK: - Quick Access
    public static let quickAccessItems: [QuickAccessItemType] = [
        .menuItem(GridMenuItem(title: "E-Money", iconName: "wallet.pass")),
        .menuItem(GridMenuItem(title: "Virtual Account", iconName: "banknote")),
        .menuItem(GridMenuItem(title: "PLN Electricity", iconName: "lightbulb")),
        .menuItem(GridMenuItem(title: "PDAM", iconName: "drop")),
        .menuItem(GridMenuItem(title: "Credit Card", iconName: "creditcard")),
        .menuItem(GridMenuItem(title: "Installment", iconName: "creditcard", isNewFeature: true)),
        .add
    ]
    
    // MARK: - Promos
    public static let promoItems: [PromoItem] = [
        PromoItem(imageName: "promo_placeholder"),
        PromoItem(imageName: "promo_placeholder"),
        PromoItem(imageName: "promo_placeholder")
    ]
    
    // MARK: - Transaction Sections
    public static let transactionSections: [TransactionSection] = [
        TransactionSection(
            title: "Transfer",
            columnsCount: 4,
            items: [
                GridMenuItem(title: "Transfer Same Bank", iconName: "arrow.up"),
                GridMenuItem(title: "Transfer Other Bank", iconName: "building.columns"),
                GridMenuItem(title: "Virtual Account", iconName: "banknote"),
                GridMenuItem(title: "Proxy Address", iconName: "globe", isNewFeature: true),
                GridMenuItem(title: "QRIS Payment", iconName: "qrcode"),
                GridMenuItem(title: "Cardless Withdrawal", iconName: "square.and.arrow.down"),
                GridMenuItem(title: "Split Bill", iconName: "person.2"),
                GridMenuItem(title: "International", iconName: "dollarsign.arrow.circlepath")
            ]
        ),
        TransactionSection(
            title: "Mobile",
            columnsCount: 4,
            items: [
                GridMenuItem(title: "Mobile Data", iconName: "iphone"),
                GridMenuItem(title: "Phone Credit", iconName: "phone.arrow.up.right"),
                GridMenuItem(title: "Post Paid", iconName: "iphone.badge.exclamationmark"),
                GridMenuItem(title: "Roaming Packages", iconName: "antenna.radiowaves.left.and.right", isNewFeature: true)
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
                GridMenuItem(title: "MPN", iconName: "building.columns"),
                GridMenuItem(title: "Cable TV & Internet", iconName: "tv"),
                GridMenuItem(title: "Education Fees", iconName: "graduationcap"),
                GridMenuItem(title: "Gas Utility", iconName: "flame"),
                GridMenuItem(title: "Zakat & Alms", iconName: "heart")
            ]
        ),
        TransactionSection(
            title: "Top-Up",
            columnsCount: 4,
            items: [
                GridMenuItem(title: "E-Money", iconName: "wallet.pass"),
                GridMenuItem(title: "Mobile Legends", iconName: "gamecontroller"),
                GridMenuItem(title: "Genshin Impact", iconName: "gamecontroller", isNewFeature: true),
                GridMenuItem(title: "Steam Wallet", iconName: "gamecontroller"),
                GridMenuItem(title: "PlayStation Network", iconName: "gamecontroller"),
                GridMenuItem(title: "App Store & iTunes", iconName: "apple.logo"),
                GridMenuItem(title: "Google Play", iconName: "play.circle")
            ]
        ),
        TransactionSection(
            title: "Investment & Wealth",
            columnsCount: 4,
            items: [
                GridMenuItem(title: "Mutual Funds", iconName: "chart.bar"),
                GridMenuItem(title: "Gold Savings", iconName: "sparkles", isNewFeature: true),
                GridMenuItem(title: "Government Bonds", iconName: "doc.text"),
                GridMenuItem(title: "Stocks", iconName: "chart.line.uptrend.xyaxis")
            ]
        ),
        TransactionSection(
            title: "Travel & Leisure",
            columnsCount: 4,
            items: [
                GridMenuItem(title: "Flight Tickets", iconName: "airplane"),
                GridMenuItem(title: "Train Tickets", iconName: "tram"),
                GridMenuItem(title: "Hotel Booking", iconName: "bed.double"),
                GridMenuItem(title: "Movie Tickets", iconName: "ticket", isNewFeature: true)
            ]
        )
    ]
}
