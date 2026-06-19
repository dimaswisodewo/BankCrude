//
//  DashboardView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

struct DashboardView: View {
    @Environment(NavigationRouter.self) private var router
    @State private var activeCardIndex: Int = 0
    @State private var selectedItemMessage: String? = nil
    
    // Layout Constants
    private let sectionSpacing: CGFloat = 32
    
    let mockCards = [
        CardItem(
            accountType: "Saving Account",
            accountNumber: "0342039298",
            balance: 9999999999.00,
            gradientColors: [Color.primaryRed, Color(hex: "C21109")]
        ),
        CardItem(
            accountType: "Secondary Account",
            accountNumber: "0293049102",
            balance: 24500000.00,
            gradientColors: [Color(hex: "1A1D1A"), Color(hex: "343A34")]
        ),
        CardItem(
            accountType: "Investment Account",
            accountNumber: "0938491823",
            balance: 1200000000.00,
            gradientColors: [Color(hex: "0C58A6"), Color(hex: "083E75")]
        )
    ]
    
    private var mockTransactions: [TransactionItem] {
        let calendar = Calendar.current
        let baseDate = calendar.date(from: DateComponents(year: 2026, month: 6, day: 24)) ?? Date()
        
        return [
            TransactionItem(
                date: baseDate,
                title: "Aditya Pratama",
                subtitle: "Transfer to BCA Account (0342039298)",
                amount: 50000.00,
                type: .outflow,
                status: .success,
                note: "Weekly coffee share ☕️",
                sourceAccountName: "Saving Account",
                sourceAccountNumber: "0342039298"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -2, to: baseDate) ?? baseDate,
                title: "Radhita Salsabila",
                subtitle: "Received from CIMB Account",
                amount: 99000000.00,
                type: .inflow,
                status: nil,
                sourceAccountName: "Saving Account",
                sourceAccountNumber: "0342039298"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -3, to: baseDate) ?? baseDate,
                title: "Agus Subagja",
                subtitle: "Transfer to Bank Jago Account",
                amount: 2000000.00,
                type: .outflow,
                status: .failed,
                note: "Freelance down payment",
                sourceAccountName: "Secondary Account",
                sourceAccountNumber: "0293049102"
            ),
            TransactionItem(
                date: calendar.date(byAdding: .day, value: -4, to: baseDate) ?? baseDate,
                title: "Tokopedia",
                subtitle: "Virtual Account BCA Payment",
                amount: 250000.00,
                type: .outflow,
                status: .success,
                sourceAccountName: "Secondary Account",
                sourceAccountNumber: "0293049102"
            )
        ]
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                // Header Section
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome Back,")
                            .typography(.caption, weight: .regular)
                            .foregroundColor(.textSecondary)
                        Text("Meynabel Dimas Wisodewo")
                            .typography(.headline, weight: .semibold)
                            .foregroundColor(.textPrimary)
                    }
                    Spacer()
                    
                    Button {
                        // Profile/Account action
                    } label: {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.textSecondary)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 16) // Visual grouping: closer to the Card Carousel
                
                // Carousel & Indicator Container
                VStack(spacing: 12) { // Slightly tighter spacing to keep dot indicators grouped
                    CardCarouselView(
                        items: mockCards,
                        activeIndex: $activeCardIndex,
                        spacing: 8
                    ) { card in
                        CardView(item: card) {
                            print("Tapped detail for \(card.accountType)")
                        }
                    }
                    .frame(height: 270) // Frame allows card shadow to render without clipping
                    
                    DotPageIndicator(
                        totalCount: mockCards.count,
                        currentIndex: $activeCardIndex
                    )
                }
                
                // Primary Action Buttons (Transfer & QRIS)
                HStack(spacing: 12) {
                    PrimaryButton(
                        title: "Transfer",
                        systemImageName: "arrowshape.turn.up.left"
                    ) {
                        router.push(.transferDestinationSelect)
                    }
                    
                    PrimaryButton(
                        title: "QRIS",
                        systemImageName: "qrcode"
                    ) {
                        selectedItemMessage = "Tapped QRIS"
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, sectionSpacing)
                
                // Quick Access Section
                QuickAccessView(
                    onItemTap: { item in
                        selectedItemMessage = "Tapped: \(item.title)"
                    },
                    onEditTap: {
                        selectedItemMessage = "Tapped Edit Quick Access"
                    },
                    onAddTap: {
                        selectedItemMessage = "Tapped Add Quick Access"
                    }
                )
                .padding(.horizontal, 24)
                .padding(.top, sectionSpacing)
                
                // Promo Section
                PromoCarouselView()
                    .padding(.top, sectionSpacing)
                
                // Transaction History Section
                VStack(alignment: .leading, spacing: 0) {
                    SectionHeaderView("Transaction History", buttonTitle: "See All") {
                        router.push(.allTransactions)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 8)
                    
                    VStack(spacing: 0) {
                        ForEach(mockTransactions) { transaction in
                            TransactionRowView(
                                transaction: transaction,
                                onTap: {
                                    router.push(.transactionReceipt(transaction, isFromTransfer: false))
                                }
                            )
                            
                            if transaction.id != mockTransactions.last?.id {
                                Divider()
                                    .background(Color.black.opacity(0.06))
                                    .padding(.horizontal, 24)
                            }
                        }
                    }
                }
                .padding(.top, sectionSpacing)
                .padding(.bottom, 40) // Generous bottom padding for better scroll feel
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundWhite)
        .toast(message: $selectedItemMessage)
    }
}

#Preview {
    PreviewRouterWrapper {
        NavigationStack {
            DashboardView()
        }
    }
}
