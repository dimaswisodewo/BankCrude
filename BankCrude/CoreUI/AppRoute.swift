//
//  AppRoute.swift
//  Slipi
//
//  Created by Meynabel Dimas Wisodewo on 17/05/26.
//

import Foundation
import SwiftUI

/// Represents the navigation destinations within the app.
enum AppRoute: Hashable, Identifiable {
    /// View showing all transaction history.
    case allTransactions
    
    var id: Self { self }
}

/// A centralized router that manages navigation state, including path stacks, presented sheets, and full-screen covers.
@Observable
class NavigationRouter {
    // MARK: - State Properties
    
    /// The currently selected tab in the main tab bar.
    var selectedTab: AppTab = .dashboard
    
    /// Navigation path for the entire app.
    var path: [AppRoute] = []
    
    /// A stack of presented sheets. Supports multiple stacked sheets.
    var presentedSheets: [AppRoute] = []
    
    /// A stack of presented full-screen covers.
    var presentedFullScreenCovers: [AppRoute] = []
    
    // MARK: - Computed Properties
    
    /// A convenience property to access or set the primary (first) presented sheet.
    /// - Setting to a new value appends it to the stack if not already present.
    /// - Setting to `nil` clears all presented sheets.
    var presentedSheet: AppRoute? {
        get { presentedSheets.first }
        set {
            if let newValue = newValue {
                if !presentedSheets.contains(newValue) {
                    presentedSheets.append(newValue)
                }
            } else {
                presentedSheets.removeAll()
            }
        }
    }
    
    // MARK: - Navigation Methods
    
    /// Pushes a new route onto the navigation path.
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    /// Removes the last route from the navigation path.
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    /// Clears the navigation path, returning to the root view.
    func popToRoot() {
        path.removeAll()
    }
    
    // MARK: - Presentation Methods
    
    /// Presents a sheet by adding a route to the stack.
    func presentSheet(_ route: AppRoute) {
        presentedSheets.append(route)
    }
    
    /// Presents a full-screen cover by adding a route to the stack.
    func presentFullScreenCover(_ route: AppRoute) {
        presentedFullScreenCovers.append(route)
    }
    
    /// Dismisses the top-most presented sheet.
    func dismissSheet() {
        if !presentedSheets.isEmpty {
            presentedSheets.removeLast()
        }
    }
    
    /// Dismisses the top-most presented full-screen cover.
    func dismissFullScreenCover() {
        if !presentedFullScreenCovers.isEmpty {
            presentedFullScreenCovers.removeLast()
        }
    }
    
    /// Dismisses all presented sheets and full-screen covers.
    func dismiss() {
        presentedSheets.removeAll()
        presentedFullScreenCovers.removeAll()
    }
}
