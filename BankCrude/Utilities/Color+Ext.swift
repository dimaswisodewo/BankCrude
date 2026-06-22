//
//  Color+Ext.swift
//  BankCrude
//
//  Created by Meynabel Dimas Wisodewo on 18/06/26.
//

import SwiftUI

public extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

    static let primaryBlack = Color(hex: "010400")
    static let primaryRed = Color(hex: "E9190F")
    
    static let priceRed = Color(hex: "DD6228")
    static let priceGreen = Color(hex: "CA3F16")
    
    static let backgroundWhite = Color(hex: "FAFAFA")
    
    static let textPrimary = Color(hex: "010400")
    static let textSecondary = Color(hex: "808080")
    
    // Transaction & Status colors
    static let transactionGreen = Color(hex: "1B873F")
    static let transactionRed = Color(hex: "E9190F")
    static let successGreen = Color(hex: "1B873F")
    static let successGreenBg = Color(hex: "E8F5E9")
    static let failedRed = Color(hex: "E9190F")
    static let failedRedBg = Color(hex: "FFEBEE")
    static let toastBlue = Color(hex: "0A7EFA")
}
