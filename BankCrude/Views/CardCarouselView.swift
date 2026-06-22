//
//  CardCarouselView.swift
//  BankCrude
//
//  Created by Meynabel Dimas Wisodewo on 18/06/26.
//

import SwiftUI

public struct CardCarouselView<Item: Identifiable & Equatable, Content: View>: View {
    let items: [Item]
    @Binding var activeIndex: Int
    let itemWidth: CGFloat
    let spacing: CGFloat
    let content: (Item) -> Content
    
    @State private var scrolledID: Item.ID?
    
    public init(
        items: [Item],
        activeIndex: Binding<Int>,
        itemWidth: CGFloat = UIScreen.main.bounds.width - 32,
        spacing: CGFloat = 16,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.items = items
        self._activeIndex = activeIndex
        self.itemWidth = itemWidth
        self.spacing = spacing
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let horizontalPadding = max(0, (totalWidth - itemWidth) / 2)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: spacing) {
                    ForEach(items) { item in
                        content(item)
                            .frame(width: itemWidth)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .safeAreaPadding(.horizontal, horizontalPadding)
            .scrollPosition(id: $scrolledID)
            .onChange(of: scrolledID) { _, newValue in
                if let newValue, let index = items.firstIndex(where: { $0.id == newValue }) {
                    activeIndex = index
                }
            }
            .onChange(of: activeIndex) { _, newValue in
                if newValue >= 0 && newValue < items.count {
                    let targetID = items[newValue].id
                    if scrolledID != targetID {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            scrolledID = targetID
                        }
                    }
                }
            }
            .onAppear {
                if activeIndex >= 0 && activeIndex < items.count {
                    scrolledID = items[activeIndex].id
                }
            }
        }
    }
}
