//
//  AppTab.swift
//  BankCrude
//
//  Created by Meynabel Dimas Wisodewo on 18/06/26.
//

import Foundation

enum AppTab: String, CaseIterable, Identifiable, Hashable {
    case dashboard
    case transactions
    case notifications
    case accounts
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .dashboard: return "Home"
        case .transactions: return "Transactions"
        case .notifications: return "Notifications"
        case .accounts: return "Accounts"
        }
    }
    
    var icon: String {
        switch self {
        case .dashboard: return "house"
        case .transactions: return "arrow.up.arrow.down"
        case .notifications: return "bell"
        case .accounts: return "person"
        }
    }
    
    var iconFill: String {
        switch self {
        case .dashboard: return "house.fill"
        case .transactions: return "arrow.up.arrow.down"
        case .notifications: return "bell.fill"
        case .accounts: return "person.fill"
        }
    }
}
