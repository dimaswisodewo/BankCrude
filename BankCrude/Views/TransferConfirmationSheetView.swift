//
//  TransferConfirmationSheetView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

struct TransferConfirmationSheetView: View {
    @Environment(NavigationRouter.self) private var router
    
    let bank: String
    let accountNumber: String
    let amount: Decimal
    let note: String?
    
    private var recipientName: String {
        // Simple mock lookup based on our saved accounts list
        switch accountNumber {
        case "0342039298": return "Radhita Salsabila"
        case "1293840291": return "Agus Subagja"
        case "9038481234": return "Dewi Lestari"
        case "0192840294": return "Budi Santoso"
        case "7283940192": return "Siti Rahma"
        case "8293849102": return "Aditya Pratama"
        default: return "Aditya Pratama" // Default fallback name
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 36)
            
            Text("Transfer Confirmation")
                .typography(.title3, weight: .bold)
                .foregroundColor(.textPrimary)
                .padding(.bottom, 24)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Recipient Section Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recipient")
                            .typography(.footnote, weight: .bold)
                            .foregroundColor(.textSecondary)
                        
                        HStack(spacing: 16) {
                            Circle()
                                .fill(Color(hex: "EDEDED"))
                                .frame(width: 48, height: 48)
                                .overlay(
                                    Text(String(recipientName.prefix(2)).uppercased())
                                        .typography(.body, weight: .bold)
                                        .foregroundColor(.textPrimary)
                                )
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(recipientName)
                                    .typography(.body, weight: .semibold)
                                    .foregroundColor(.textPrimary)
                                Text("\(bank) • \(accountNumber)")
                                    .typography(.footnote, weight: .regular)
                                    .foregroundColor(.textSecondary)
                            }
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black.opacity(0.05), lineWidth: 1)
                    )
                    
                    // Transaction Breakdown Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Transaction Details")
                            .typography(.footnote, weight: .bold)
                            .foregroundColor(.textSecondary)
                        
                        detailRow(label: "Source Account", value: "Saving Account")
                        detailRow(label: "Amount", value: amount.formattedAsRupiah())
                        detailRow(label: "Transfer Fee", value: "Rp 0,00")
                        
                        if let note = note, !note.isEmpty {
                            detailRow(label: "Note", value: note)
                        }
                        
                        Divider()
                            .background(Color.black.opacity(0.06))
                            .padding(.vertical, 4)
                        
                        HStack {
                            Text("Total")
                                .typography(.body, weight: .bold)
                                .foregroundColor(.textPrimary)
                            Spacer()
                            Text(amount.formattedAsRupiah())
                                .typography(.body, weight: .bold)
                                .foregroundColor(.textPrimary)
                        }
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black.opacity(0.05), lineWidth: 1)
                    )
                }
                .padding(.horizontal, 24)
            }
            
            // Bottom Confirm Button
            VStack {
                PrimaryButton(title: "Confirm & Send") {
                    // Create transaction item
                    let transaction = TransactionItem(
                        date: Date(),
                        title: recipientName,
                        subtitle: "Transfer to \(bank) Account (\(accountNumber))",
                        amount: amount,
                        type: .outflow,
                        status: .success
                    )
                    
                    // Dismiss confirmation sheet
                    router.dismissSheet()
                    
                    // Push processing screen
                    router.push(.transferProcessing(transaction))
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .buttonStyle(ScaleButtonStyle())
            }
            .background(Color.backgroundWhite)
        }
        .background(Color.backgroundWhite)
        .presentationDetents([.medium])
    }
    
    private func detailRow(label: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text(label)
                .typography(.footnote, weight: .regular)
                .foregroundColor(.textSecondary)
            Spacer()
            Text(value)
                .typography(.footnote, weight: .semibold)
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    TransferConfirmationSheetView(
        bank: "Bank Crude",
        accountNumber: "0342039298",
        amount: 250000.00,
        note: "Dinner contribution"
    )
    .environment(NavigationRouter())
}
