//
//  CardView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

public struct CardItem: Identifiable, Equatable {
    public let id: UUID
    public let accountType: String
    public let accountNumber: String
    public let balance: Decimal
    public let gradientColors: [Color]
    
    public init(
        id: UUID = UUID(),
        accountType: String,
        accountNumber: String,
        balance: Decimal,
        gradientColors: [Color] = [Color.primaryRed, Color(hex: "C21109")]
    ) {
        self.id = id
        self.accountType = accountType
        self.accountNumber = accountNumber
        self.balance = balance
        self.gradientColors = gradientColors
    }
}

public struct CardView: View {
    let item: CardItem
    let onNavigate: (() -> Void)?
    
    @State private var isBalanceHidden: Bool = false
    @State private var isCopied: Bool = false
    
    public init(item: CardItem, onNavigate: (() -> Void)? = nil) {
        self.item = item
        self.onNavigate = onNavigate
    }
    
    private var formattedBalance: String {
        item.balance.formattedAsRupiah()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top Row
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.accountType)
                        .typography(.headline, weight: .semibold)
                        .foregroundColor(.white)
                    
                    HStack(spacing: 8) {
                        Text(item.accountNumber)
                            .typography(.footnote, weight: .regular)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Button {
                            UIPasteboard.general.string = item.accountNumber
                            withAnimation(.easeIn(duration: 0.1)) {
                                isCopied = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    isCopied = false
                                }
                            }
                        } label: {
                            Image(systemName: isCopied ? "checkmark" : "doc.on.doc")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                Spacer()
                
                if let onNavigate = onNavigate {
                    Button {
                        onNavigate()
                    } label: {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.plain)
                } else {
                    // Default arrow if action not provided but arrow shown for visual match
                    Image(systemName: "arrow.right")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
            
            // Bottom Row
            HStack {
                Spacer()
                
                VStack(alignment: .trailing, spacing: 6) {
                    Button {
                        isBalanceHidden.toggle()
                    } label: {
                        Image(systemName: isBalanceHidden ? "eye.slash" : "eye")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.plain)
                    
                    Text(isBalanceHidden ? "Rp •••••••••" : formattedBalance)
                        .typography(size: 28, weight: .bold, relativeTo: .title)
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
            }
        }
        .padding(24)
        .frame(height: 200)
        .background(
            LinearGradient(
                colors: item.gradientColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 6)
    }
}

#Preview {
    CardView(
        item: CardItem(
            accountType: "Saving Account",
            accountNumber: "0342039298",
            balance: 9999999999.00
        )
    )
    .padding()
}
