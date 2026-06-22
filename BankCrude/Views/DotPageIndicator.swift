//
//  DotPageIndicator.swift
//  BankCrude
//
//  Created by Meynabel Dimas Wisodewo on 18/06/26.
//

import SwiftUI

public struct DotPageIndicator: View {
    let totalCount: Int
    @Binding var currentIndex: Int
    
    let activeColor: Color
    let inactiveColor: Color
    let dotSize: CGFloat
    let spacing: CGFloat
    
    public init(
        totalCount: Int,
        currentIndex: Binding<Int>,
        activeColor: Color = .primaryBlack,
        inactiveColor: Color = Color(hex: "D9D9D9"),
        dotSize: CGFloat = 8,
        spacing: CGFloat = 8
    ) {
        self.totalCount = totalCount
        self._currentIndex = currentIndex
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
        self.dotSize = dotSize
        self.spacing = spacing
    }
    
    public var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<totalCount, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex ? activeColor : inactiveColor)
                    .frame(width: dotSize, height: dotSize)
                    .scaleEffect(index == currentIndex ? 1.25 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: currentIndex)
                    .onTapGesture {
                        currentIndex = index
                    }
            }
        }
    }
}

#Preview {
    DotPageIndicator(totalCount: 3, currentIndex: .constant(0))
}
