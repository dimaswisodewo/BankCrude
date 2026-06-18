//
//  NotificationsView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

struct NotificationsView: View {
    private var mockNotifications: [NotificationItem] {
        let calendar = Calendar.current
        let dateJune16 = calendar.date(from: DateComponents(year: 2026, month: 6, day: 16)) ?? Date()
        let dateJune15 = calendar.date(from: DateComponents(year: 2026, month: 6, day: 15)) ?? Date()
        let dateJune14 = calendar.date(from: DateComponents(year: 2026, month: 6, day: 14)) ?? Date()
        let dateJune12 = calendar.date(from: DateComponents(year: 2026, month: 6, day: 12)) ?? Date()
        let dateJune10 = calendar.date(from: DateComponents(year: 2026, month: 6, day: 10)) ?? Date()
        
        return [
            // June 16
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
            
            // June 15
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
            
            // June 14
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
                detail: "BankCrude systems will undergo scheduled maintenance on 21 June 2026, 01:00 - 04:00 WIB. Some services may be temporarily unavailable.",
                isUnread: false
            ),
            
            // June 12
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
            
            // June 10
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
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                // Header (aligned with DashboardView header typography and spacing)
                HStack {
                    Text("Notifications")
                        .typography(.title2, weight: .bold)
                        .foregroundColor(.textPrimary)
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 16)
                
                // Notifications List
                if mockNotifications.isEmpty {
                    VStack {
                        Spacer()
                        Text("No notifications yet")
                            .typography(.body, weight: .regular)
                            .foregroundColor(.textSecondary)
                        Spacer()
                    }
                    .frame(minHeight: 300)
                } else {
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
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundWhite)
    }
}

#Preview {
    NotificationsView()
}
