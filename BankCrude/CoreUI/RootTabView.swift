//
//  RootTabView.swift
//  Slipi
//

import SwiftUI
import SwiftData

struct RootTabView: View {
    @Environment(NavigationRouter.self) private var router
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ForEach(AppTab.allCases) { tab in
                tabContentView(for: tab)
                    .opacity(router.selectedTab == tab ? 1 : 0)
                    .allowsHitTesting(router.selectedTab == tab)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            VStack(spacing: 0) {
                CustomTabBarView()
            }
            .background(
                Color.backgroundWhite
                    .ignoresSafeArea(edges: .bottom)
                    .shadow(
                        color: .black.opacity(0.25),
                        radius: 2
                    )
            )
        }
        .ignoresSafeArea(.keyboard)
        .withAppRouter()
    }
    
    @ViewBuilder
    private func tabContentView(for tab: AppTab) -> some View {
        switch tab {
        case .dashboard:
            DashboardView()
        default:
            EmptyView()
        }
    }
}

#Preview {
    PreviewRouterWrapper {
        RootTabView()
    }
}
