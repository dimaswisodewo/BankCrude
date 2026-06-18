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
        let date = calendar.date(from: DateComponents(year: 2026, month: 6, day: 16)) ?? Date()
        
        return [
            NotificationItem(
                date: date,
                title: "Cashflow - Spending",
                amount: 50000.00,
                type: .spending,
                detail: "to Meynabel Dimas Wisodewo - Bank Jago at Investment Category"
            ),
            NotificationItem(
                date: date,
                title: "Cashflow - Spending",
                amount: 10050000.00,
                type: .spending,
                detail: "at Shopping"
            ),
            NotificationItem(
                date: date,
                title: "Cashflow - Income",
                amount: 2150000.00,
                type: .income,
                detail: "from Meynabel Dimas Wisodewo at Shopping Category"
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
