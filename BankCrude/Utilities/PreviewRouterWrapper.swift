//
//  PreviewRouterWrapper.swift
//  BankCrude
//
//  Created by Meynabel Dimas Wisodewo on 18/06/26.
//

import SwiftUI

/// A wrapper view for SwiftUI Previews that provides a functional NavigationRouter.
struct PreviewRouterWrapper<Content: View>: View {
    @State private var router = NavigationRouter()
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        content()
            .withAppRouter()
            .environment(router)
    }
}
