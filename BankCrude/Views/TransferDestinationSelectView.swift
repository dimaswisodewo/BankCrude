//
//  TransferDestinationSelectView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

struct SavedAccount: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let bank: String
    let accountNumber: String
    let initials: String
}

struct TransferDestinationSelectView: View {
    @Environment(NavigationRouter.self) private var router
    @State private var searchText = ""
    @State private var debouncedSearchText = ""
    
    private let mockSavedAccounts = [
        SavedAccount(name: "Radhita Salsabila", bank: "Bank Crude", accountNumber: "0342039298", initials: "RS"),
        SavedAccount(name: "Agus Subagja", bank: "Bank Mandiri", accountNumber: "1293840291", initials: "AS"),
        SavedAccount(name: "Dewi Lestari", bank: "Bank Jago", accountNumber: "9038481234", initials: "DL"),
        SavedAccount(name: "Budi Santoso", bank: "BRI", accountNumber: "0192840294", initials: "BS"),
        SavedAccount(name: "Siti Rahma", bank: "BNI", accountNumber: "7283940192", initials: "SR"),
        SavedAccount(name: "Aditya Pratama", bank: "BCA", accountNumber: "8293849102", initials: "AP")
    ]
    
    private var filteredAccounts: [SavedAccount] {
        if debouncedSearchText.isEmpty {
            return mockSavedAccounts
        } else {
            return mockSavedAccounts.filter { account in
                account.name.localizedCaseInsensitiveContains(debouncedSearchText) ||
                account.bank.localizedCaseInsensitiveContains(debouncedSearchText) ||
                account.accountNumber.contains(debouncedSearchText)
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Search Bar Area
            VStack(spacing: 16) {
                SearchBarView(
                    text: $searchText,
                    placeholder: "Search name, bank, or account number...",
                    delay: 0.25
                ) { debouncedVal in
                    debouncedSearchText = debouncedVal
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 16)
            .background(Color.backgroundWhite)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // New Beneficiary Button Card
                    Button(action: {
                        router.push(.transferInput(bank: nil, accountNumber: nil))
                    }) {
                        HStack(spacing: 16) {
                            Circle()
                                .fill(Color.primaryRed.opacity(0.1))
                                .frame(width: 48, height: 48)
                                .overlay(
                                    Image(systemName: "plus")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.primaryRed)
                                )
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("New Beneficiary")
                                    .typography(.body, weight: .semibold)
                                    .foregroundColor(.textPrimary)
                                Text("Transfer to a new account number")
                                    .typography(.footnote, weight: .regular)
                                    .foregroundColor(.textSecondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.textSecondary)
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.black.opacity(0.05), lineWidth: 1)
                                )
                        )
                        .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // Saved Accounts List
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Saved Accounts")
                            .typography(.subheadline, weight: .bold)
                            .foregroundColor(.textPrimary)
                            .padding(.horizontal, 4)
                        
                        if filteredAccounts.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "person.crop.circle.badge.questionmark")
                                    .font(.system(size: 40))
                                    .foregroundColor(.textSecondary.opacity(0.6))
                                Text("No saved accounts found")
                                    .typography(.body, weight: .medium)
                                    .foregroundColor(.textSecondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 48)
                        } else {
                            VStack(spacing: 0) {
                                ForEach(filteredAccounts) { account in
                                    Button(action: {
                                        router.push(.transferInput(bank: account.bank, accountNumber: account.accountNumber))
                                    }) {
                                        HStack(spacing: 16) {
                                            Circle()
                                                .fill(Color(hex: "EDEDED"))
                                                .frame(width: 48, height: 48)
                                                .overlay(
                                                    Text(account.initials)
                                                        .typography(.body, weight: .bold)
                                                        .foregroundColor(.textPrimary)
                                                )
                                            
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(account.name)
                                                    .typography(.body, weight: .semibold)
                                                    .foregroundColor(.textPrimary)
                                                Text("\(account.bank) • \(account.accountNumber)")
                                                    .typography(.footnote, weight: .regular)
                                                    .foregroundColor(.textSecondary)
                                            }
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .font(.system(size: 14, weight: .medium))
                                                .foregroundColor(.textSecondary.opacity(0.6))
                                        }
                                        .padding(.vertical, 14)
                                        .padding(.horizontal, 16)
                                        .background(Color.white)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    if account.id != filteredAccounts.last?.id {
                                        Divider()
                                            .background(Color.black.opacity(0.06))
                                            .padding(.leading, 80)
                                    }
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.black.opacity(0.05), lineWidth: 1)
                                    )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundWhite)
        .navigationTitle("Transfer Destination")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PreviewRouterWrapper {
        NavigationStack {
            TransferDestinationSelectView()
        }
    }
}
