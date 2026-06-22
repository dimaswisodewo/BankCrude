//
//  CustomTabBarView.swift
//  BankCrude
//
//  Created by Meynabel Dimas Wisodewo on 18/06/26.
//

import SwiftUI

struct CustomTabBarView: View {
    @Environment(NavigationRouter.self) private var router
    
    var body: some View {
        HStack {
            Spacer()
            ForEach(AppTab.allCases) { tab in
                tabItem(for: tab)
                Spacer()
            }
        }
        .padding(.vertical, 12)
        .background(
            Color.backgroundWhite
                .overlay(
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.white.opacity(0.1)),
                    alignment: .top
                )
        )
    }
    
    private func tabItem(for tab: AppTab) -> some View {
        let isSelected = router.selectedTab == tab
        
        return Button {
            if isSelected {
                router.popToRoot()
            } else {
                router.selectedTab = tab
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: isSelected ? tab.iconFill : tab.icon)
                    .typography(size: 22)
                
                Text(tab.title)
                    .typography(size: 11)
            }
            .foregroundColor(
                isSelected ? .red : .textPrimary
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CustomTabBarView()
        .environment(NavigationRouter())
}
