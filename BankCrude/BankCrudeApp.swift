//
//  BankCrudeApp.swift
//  BankCrude
//
//  Created by Meynabel Dimas Wisodewo on 18/06/26.
//

import SwiftUI

@main
struct BankCrudeApp: App {
    @State private var router = NavigationRouter()
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environment(router)
        }
    }
}
