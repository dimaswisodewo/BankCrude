//
//  DashboardView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

struct DashboardView: View {
    @State private var activeCardIndex: Int = 0
    
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
    
    var body: some View {
        VStack(spacing: 0) {
            // Header Section
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Welcome Back,")
                        .typography(.caption, weight: .regular)
                        .foregroundColor(.textSecondary)
                    Text("John Doe")
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
            .padding(.bottom, 24)
            
            // Carousel & Indicator Container
            VStack(spacing: 16) {
                CardCarouselView(
                    items: mockCards,
                    activeIndex: $activeCardIndex,
                    itemWidth: 325,
                    spacing: 16
                ) { card in
                    CardView(item: card) {
                        print("Tapped detail for \(card.accountType)")
                    }
                }
                .frame(height: 220) // Frame allows card shadow to render without clipping
                
                DotPageIndicator(
                    totalCount: mockCards.count,
                    currentIndex: $activeCardIndex
                )
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundWhite)
    }
}

#Preview {
    DashboardView()
}
