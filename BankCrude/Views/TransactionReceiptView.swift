//
//  TransactionReceiptView.swift
//  BankCrude
//
//  Created by Meynabel Dimas Wisodewo on 18/06/26.
//

import SwiftUI

struct TransactionReceiptView: View {
    @Environment(NavigationRouter.self) private var router
    let transaction: TransactionItem
    let isFromTransfer: Bool
    
    @State private var isDestinationSaved: Bool
    @State private var toastMessage: String? = nil
    
    init(transaction: TransactionItem, isFromTransfer: Bool = false) {
        self.transaction = transaction
        self.isFromTransfer = isFromTransfer
        
        let savedNames = ["Radhita Salsabila", "Agus Subagja", "Dewi Lestari", "Budi Santoso", "Siti Rahma", "Aditya Pratama", "Joe Cowy", "Geeb Run"]
        self._isDestinationSaved = State(initialValue: savedNames.contains(transaction.title))
    }
    
    private var status: TransactionStatus {
        transaction.status ?? .success
    }
    
    private var statusTitle: String {
        switch status {
        case .success:
            return "Successful"
        case .pending:
            return "Pending"
        case .failed:
            return "Failed"
        }
    }
    
    private var statusColor: Color {
        switch status {
        case .success:
            return .successGreen
        case .pending:
            return Color(hex: "F57C00")
        case .failed:
            return .failedRed
        }
    }
    
    private var statusBgColor: Color {
        switch status {
        case .success:
            return .successGreenBg
        case .pending:
            return Color(hex: "FFF3E0")
        case .failed:
            return .failedRedBg
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy, HH:mm"
        return formatter.string(from: transaction.date)
    }
    
    private var referenceNumber: String {
        let idString = transaction.id.uuidString.replacingOccurrences(of: "-", with: "")
        return "TXN" + idString.prefix(10).uppercased()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    // Status Badge & Title Area
                    VStack(spacing: 12) {
                        Text(statusTitle)
                            .typography(.caption, weight: .bold)
                            .foregroundColor(statusColor)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(statusBgColor)
                            .clipShape(Capsule())
                        
                        Text(transaction.amountString)
                            .typography(.largeTitle, weight: .bold)
                            .foregroundColor(.textPrimary)
                        
                        Text("Transaction Amount")
                            .typography(.footnote, weight: .regular)
                            .foregroundColor(.textSecondary)
                    }
                    .padding(.top, 24)
                    
                    // Details Section
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Transaction Details")
                            .typography(.subheadline, weight: .bold)
                            .foregroundColor(.textPrimary)
                            .padding(.bottom, 4)
                        
                        Group {
                            detailRow(label: "Recipient/Sender", value: transaction.title)
                            detailRow(label: "Description/Account", value: transaction.subtitle)
                            if let sourceAccount = transaction.sourceAccountName {
                                let displayVal = transaction.sourceAccountNumber.map { "\(sourceAccount)\n\($0)" } ?? sourceAccount
                                detailRow(label: "Source Account", value: displayVal)
                            }
                            detailRow(label: "Date & Time", value: formattedDate)
                            detailRow(label: "Reference ID", value: referenceNumber)
                            detailRow(label: "Type", value: transaction.type == .inflow ? "Inflow" : "Outflow")
                            if let note = transaction.note, !note.isEmpty {
                                detailRow(label: "Notes", value: note)
                            }
                            detailRow(label: "Admin Fee", value: "Rp 0,00")
                        }
                        
                        Divider()
                            .background(Color.black.opacity(0.06))
                            .padding(.vertical, 8)
                        
                        // Total Paid/Received Row
                        HStack {
                            Text("Total")
                                .typography(.body, weight: .bold)
                                .foregroundColor(.textPrimary)
                            Spacer()
                            Text(transaction.amountString)
                                .typography(.body, weight: .bold)
                                .foregroundColor(transaction.type == .inflow ? .transactionGreen : .textPrimary)
                        }
                    }
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.black.opacity(0.05), lineWidth: 1)
                            )
                    )
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            
            // Save Destination Card
            if transaction.type == .outflow {
                HStack(spacing: 12) {
                    Image(systemName: isDestinationSaved ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(isDestinationSaved ? .primaryRed : .textSecondary)
                        .frame(width: 20, height: 20)
                        .contentTransition(.symbolEffect(.replace))
                    
                    Text(isDestinationSaved ? "Destination Saved" : "Save Destination")
                        .typography(.footnote, weight: .semibold)
                        .foregroundColor(.textPrimary)
                    
                    Spacer()
                    
                    Toggle("", isOn: Binding(
                        get: { isDestinationSaved },
                        set: { newValue in
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                isDestinationSaved = newValue
                                toastMessage = newValue ? "Destination saved successfully" : "Destination unsaved"
                            }
                        }
                    ))
                    .tint(.primaryRed)
                    .labelsHidden()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black.opacity(0.05), lineWidth: 1)
                )
                .padding(.horizontal, 24)
                .padding(.bottom, 12)
            }
            
            // Bottom Action Area
            VStack {
                PrimaryButton(title: "Back to Home") {
                    router.popToRoot()
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
                .buttonStyle(ScaleButtonStyle())
            }
            .background(Color.backgroundWhite)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundWhite)
        .navigationTitle("Receipt")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(isFromTransfer)
        .toast(message: $toastMessage, backgroundColor: .toastBlue)
    }
    
    private func detailRow(label: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 16) {
            Text(label)
                .typography(.footnote, weight: .regular)
                .foregroundColor(.textSecondary)
                .frame(width: 110, alignment: .leading)
            
            Spacer()
            
            Text(value)
                .typography(.footnote, weight: .semibold)
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

#Preview("With Source Account and Notes") {
    PreviewRouterWrapper {
        NavigationStack {
            TransactionReceiptView(
                transaction: TransactionItem(
                    date: Date(),
                    title: "Aditya Pratama",
                    subtitle: "Transfer to BCA Account (0342039298)",
                    amount: 50000.00,
                    type: .outflow,
                    status: .success,
                    note: "Shared lunch bill 🍔",
                    sourceAccountName: "Saving Account",
                    sourceAccountNumber: "0342039298"
                )
            )
        }
    }
}

#Preview("With Source Account Only") {
    PreviewRouterWrapper {
        NavigationStack {
            TransactionReceiptView(
                transaction: TransactionItem(
                    date: Date(),
                    title: "Aditya Pratama",
                    subtitle: "Transfer to BCA Account (0342039298)",
                    amount: 50000.00,
                    type: .outflow,
                    status: .success,
                    sourceAccountName: "Saving Account",
                    sourceAccountNumber: "0342039298"
                )
            )
        }
    }
}
