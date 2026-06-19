//
//  PromoCarouselView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

public struct PromoItem: Identifiable, Equatable {
    public let id: UUID
    public let imageName: String?
    
    public init(id: UUID = UUID(), imageName: String? = nil) {
        self.id = id
        self.imageName = imageName
    }
}

public struct PromoCarouselView: View {
    public let items: [PromoItem]
    public let itemWidth: CGFloat
    @State private var activeIndex: Int = 0
    
    public init(
        items: [PromoItem] = [
            PromoItem(imageName: "promo_placeholder"),
            PromoItem(imageName: "promo_placeholder"),
            PromoItem(imageName: "promo_placeholder")
        ],
        itemWidth: CGFloat = UIScreen.main.bounds.width - 32
    ) {
        self.items = items
        self.itemWidth = itemWidth
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionHeaderView("Promo")
                .padding(.horizontal, 24)
                .padding(.bottom, 12)
            
            VStack(spacing: 16) {
                CardCarouselView(
                    items: items,
                    activeIndex: $activeIndex,
                    itemWidth: itemWidth,
                    spacing: 8
                ) { item in
                    PromoCardView(item: item)
                }
                .frame(height: 130) // Extra padding to prevent clipping of shadows or borders
                
                DotPageIndicator(
                    totalCount: items.count,
                    currentIndex: $activeIndex
                )
            }
        }
    }
}

public struct PromoCardView: View {
    let item: PromoItem
    
    public var body: some View {
        if let imageName = item.imageName, !imageName.isEmpty {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.primaryBlack, lineWidth: 1.5)
                )
        } else {
            // Beautiful SwiftUI custom fallback placeholder
            ZStack {
                Color(hex: "FED36A")
                
                HStack {
                    Spacer()
                    Image(systemName: "hanger")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.primaryBlack)
                        .opacity(0.15)
                        .padding(.trailing, 40)
                }
                
                // Spiky Badge on the left
                HStack {
                    ZStack {
                        ForEach(0..<4) { i in
                            Rectangle()
                                .fill(Color.primaryBlack)
                                .frame(width: 60, height: 60)
                                .rotationEffect(.degrees(Double(i) * 22.5))
                        }
                        VStack(spacing: -2) {
                            Text("BIG")
                                .typography(size: 11, weight: .bold)
                                .foregroundColor(.white)
                            Text("SALE")
                                .typography(size: 11, weight: .bold)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.leading, 24)
                    
                    Spacer()
                }
                
                // Promo Text
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("50% OFF")
                            .typography(.title3, weight: .bold)
                            .foregroundColor(.primaryRed)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.white)
                            .cornerRadius(8)
                            .rotationEffect(.degrees(-5))
                    }
                    .padding(.trailing, 24)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.primaryBlack, lineWidth: 1.5)
            )
        }
    }
}

#Preview {
    PromoCarouselView()
        .background(Color.backgroundWhite)
}
