//
//  CurrencyFormatter.swift
//  BankCrude
//
//  Created by Meynabel Dimas Wisodewo on 18/06/26.
//

import Foundation

public extension Decimal {
    /// Formats the number as an Indonesian Rupiah currency string (e.g., Rp9,999,999,999.00).
    /// Grouping separator is a comma (`,`) and decimal separator is a dot (`.`).
    func formattedAsRupiah() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        let formattedString = formatter.string(from: self as NSDecimalNumber) ?? "0.00"
        return "Rp\(formattedString)"
    }
}
