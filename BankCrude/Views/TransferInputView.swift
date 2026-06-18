//
//  TransferInputView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

struct TransferInputView: View {
    @Environment(NavigationRouter.self) private var router
    let prefilledBank: String?
    let prefilledAccountNumber: String?
    
    @State private var selectedBank: String
    @State private var accountNumber: String
    @State private var rawAmountString: String = ""
    @State private var note: String = ""
    // Quick amount options
    private let quickAmounts = [50000, 100000, 200000, 500000, 1000000]
    
    private let banks = [
        "Bank Crude",
        "BCA",
        "Bank Mandiri",
        "BRI",
        "BNI",
        "BSI (Bank Syariah Indonesia)",
        "CIMB Niaga",
        "Bank Jago",
        "Permata Bank",
        "Jenius (BTPN)",
        "OCBC NISP",
        "Danamon",
        "Allo Bank",
        "Maybank Indonesia",
        "Panin Bank"
    ]
    
    init(prefilledBank: String?, prefilledAccountNumber: String?) {
        self.prefilledBank = prefilledBank
        self.prefilledAccountNumber = prefilledAccountNumber
        self._selectedBank = State(initialValue: prefilledBank ?? "Bank Crude")
        self._accountNumber = State(initialValue: prefilledAccountNumber ?? "")
    }
    
    private var amountDecimal: Decimal {
        Decimal(string: rawAmountString) ?? 0
    }
    
    private var isFormValid: Bool {
        !selectedBank.isEmpty &&
        accountNumber.count >= 5 &&
        amountDecimal >= 10000
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Form Fields Card
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Destination Details")
                            .typography(.subheadline, weight: .bold)
                            .foregroundColor(.textPrimary)
                        
                        // Bank Selection Row
                        Button(action: { router.presentSheet(
                            .bankSelection(
                                currentBank: selectedBank,
                                banksSelection: banks,
                                callback: NavigationCallback { bank in
                                    selectedBank = bank
                                }
                            ))
                        }) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Destination Bank")
                                        .typography(.caption, weight: .regular)
                                        .foregroundColor(.textSecondary)
                                    
                                    HStack(spacing: 8) {
                                        Image(systemName: "building.2.fill")
                                            .foregroundColor(.primaryRed)
                                        Text(selectedBank)
                                            .typography(.body, weight: .semibold)
                                            .foregroundColor(.textPrimary)
                                    }
                                }
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.textSecondary)
                            }
                            .padding(14)
                            .background(Color(hex: "FAFAFA"))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.black.opacity(0.06), lineWidth: 1)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        // Account Number Row
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Account Number")
                                .typography(.caption, weight: .regular)
                                .foregroundColor(.textSecondary)
                            
                            HStack {
                                Image(systemName: "creditcard.fill")
                                    .foregroundColor(.textSecondary)
                                
                                TextField("Enter beneficiary account number", text: $accountNumber)
                                    .typography(.body, weight: .semibold)
                                    .foregroundColor(.textPrimary)
                                    .keyboardType(.numberPad)
                                    .onChange(of: accountNumber) { _, newValue in
                                        // Allow digits only
                                        let filtered = newValue.filter { $0.isNumber }
                                        if filtered != newValue {
                                            accountNumber = filtered
                                        }
                                    }
                            }
                            .padding(14)
                            .background(Color(hex: "FAFAFA"))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.black.opacity(0.06), lineWidth: 1)
                            )
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.black.opacity(0.05), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.01), radius: 6, x: 0, y: 3)
                    
                    // Amount Selection Card
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Transfer Amount")
                            .typography(.subheadline, weight: .bold)
                            .foregroundColor(.textPrimary)
                        
                        // Currency Input Field
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Amount")
                                .typography(.caption, weight: .regular)
                                .foregroundColor(.textSecondary)
                            
                            HStack {
                                Text("Rp")
                                    .typography(.title, weight: .bold)
                                    .foregroundColor(.textPrimary)
                                
                                TextField("0", text: $rawAmountString)
                                    .typography(.title, weight: .bold)
                                    .foregroundColor(.textPrimary)
                                    .keyboardType(.numberPad)
                                    .onChange(of: rawAmountString) { _, newValue in
                                        let filtered = newValue.filter { $0.isNumber }
                                        if filtered != newValue {
                                            rawAmountString = filtered
                                        }
                                    }
                            }
                            .padding(.vertical, 8)
                            
                            Divider()
                                .background(Color.black.opacity(0.06))
                        }
                        
                        // Quick Amounts Grid
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Quick Select")
                                .typography(.footnote, weight: .medium)
                                .foregroundColor(.textSecondary)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(quickAmounts, id: \.self) { amount in
                                        Button(action: {
                                            rawAmountString = String(amount)
                                        }) {
                                            Text(Decimal(amount).formattedAsRupiah().replacingOccurrences(of: ".00", with: ""))
                                                .typography(.footnote, weight: .semibold)
                                                .foregroundColor(rawAmountString == String(amount) ? .white : .textPrimary)
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 10)
                                                .background(rawAmountString == String(amount) ? Color.primaryBlack : Color(hex: "EDEDED"))
                                                .cornerRadius(20)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                        }
                        
                        // Note Row
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Note (Optional)")
                                .typography(.caption, weight: .regular)
                                .foregroundColor(.textSecondary)
                            
                            TextField("E.g., Dinner, Shared bill, etc.", text: $note)
                                .typography(.body, weight: .regular)
                                .foregroundColor(.textPrimary)
                                .padding(14)
                                .background(Color(hex: "FAFAFA"))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.black.opacity(0.06), lineWidth: 1)
                                )
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.black.opacity(0.05), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.01), radius: 6, x: 0, y: 3)
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 24)
            }
            
            // Bottom Continue Area
            VStack {
                PrimaryButton(title: "Continue") {
                    router.presentSheet(.transferConfirmation(
                        bank: selectedBank,
                        accountNumber: accountNumber,
                        amount: amountDecimal,
                        note: note.isEmpty ? nil : note
                    ))
                }
                .disabled(!isFormValid)
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
            }
            .background(Color.backgroundWhite)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundWhite)
        .navigationTitle("Transfer Form")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Bank Selection Sheet
struct BankSelectionSheet: View {
    @Environment(NavigationRouter.self) private var router
    let selectedBank: String
    let banks: [String]
    let callback: NavigationCallback<String>
    
    @State private var searchText = ""
    @State private var debouncedSearchText = ""
    
    private var filteredBanks: [String] {
        if debouncedSearchText.isEmpty {
            return banks
        } else {
            return banks.filter { $0.localizedCaseInsensitiveContains(debouncedSearchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search Bar
                VStack(spacing: 16) {
                    SearchBarView(
                        text: $searchText,
                        placeholder: "Search bank name...",
                        delay: 0.2
                    ) { debouncedVal in
                        debouncedSearchText = debouncedVal
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                
                // Bank List
                List {
                    ForEach(filteredBanks, id: \.self) { bank in
                        Button(action: {
                            callback.action(bank)
                            router.dismissSheet()
                        }) {
                            HStack {
                                Text(bank)
                                    .typography(.body, weight: .semibold)
                                    .foregroundColor(.textPrimary)
                                Spacer()
                                if selectedBank == bank {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.primaryRed)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Select Bank")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        router.dismissSheet()
                    }
                    .typography(.body, weight: .bold)
                    .foregroundColor(.primaryRed)
                }
            }
        }
        .presentationDetents([.large])
    }
}

#Preview {
    PreviewRouterWrapper {
        NavigationStack {
            TransferInputView(prefilledBank: nil, prefilledAccountNumber: nil)
        }
    }
}
