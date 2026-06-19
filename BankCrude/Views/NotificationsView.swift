//
//  NotificationsView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

enum NotificationCategory: String, CaseIterable, Identifiable {
    case all = "All"
    case transactions = "Transactions"
    case others = "Others"
    
    var id: String { rawValue }
}

struct NotificationsView: View {
    @State private var selectedCategory: NotificationCategory = .all
    
    private var mockNotifications: [NotificationItem] {
        MockData.notifications
    }
    
    private var filteredNotifications: [NotificationItem] {
        switch selectedCategory {
        case .all:
            return mockNotifications
        case .transactions:
            return mockNotifications.filter { $0.type == .spending || $0.type == .income }
        case .others:
            return mockNotifications.filter { $0.type == .general }
        }
    }
    
    var body: some View {
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
            .padding(.bottom, 12)
            
            // Filter Pills Segmented Control
            SegmentedPillControl(
                selection: $selectedCategory,
                items: NotificationCategory.allCases,
                titleMapper: { $0.rawValue }
            )
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
            
            // Notifications List
            ScrollView(.vertical, showsIndicators: false) {
                if filteredNotifications.isEmpty {
                    VStack(spacing: 12) {
                        Spacer(minLength: 60)
                        Image(systemName: "bell.slash")
                            .font(.system(size: 48))
                            .foregroundColor(.textSecondary.opacity(0.6))
                        
                        Text("No notifications found")
                            .typography(.body, weight: .semibold)
                            .foregroundColor(.textPrimary)
                        
                        Text("There are no notifications in this category.")
                            .typography(.footnote, weight: .regular)
                            .foregroundColor(.textSecondary)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 24)
                } else {
                    VStack(spacing: 0) {
                        ForEach(filteredNotifications) { item in
                            NotificationRowView(notification: item)
                            
                            if item.id != filteredNotifications.last?.id {
                                Divider()
                                    .background(Color.black.opacity(0.06).opacity(0.5))
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
