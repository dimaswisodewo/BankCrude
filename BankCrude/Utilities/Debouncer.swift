//
//  Debouncer.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import Foundation

/// A MainActor-isolated utility class to debounce actions.
/// Designed for UI-bound debouncing (like search inputs and button taps).
@MainActor
public final class Debouncer: Sendable {
    private let delay: TimeInterval
    private var workItem: DispatchWorkItem?
    
    /// Initializes the debouncer with a delay.
    /// - Parameter delay: The time interval in seconds to wait before executing the action.
    public init(delay: TimeInterval) {
        self.delay = delay
    }
    
    /// Cancels any pending action and schedules the new action.
    /// - Parameter action: The closure to execute on the Main Actor.
    public func debounce(action: @escaping @MainActor @Sendable () -> Void) {
        // Cancel the current pending work item
        workItem?.cancel()
        
        let newWorkItem = DispatchWorkItem {
            Task { @MainActor in
                action()
            }
        }
        workItem = newWorkItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: newWorkItem)
    }
    
    /// Cancels the current pending action.
    public func cancel() {
        workItem?.cancel()
        workItem = nil
    }
}

/// A helper function to create a debounced version of a parameterless closure on the Main Actor.
/// - Parameters:
///   - delay: The time interval in seconds to wait before executing the action.
///   - action: The closure to execute on the Main Actor.
/// - Returns: A parameterless closure that debounces the calls to the action.
public func debounce(
    delay: TimeInterval,
    action: @escaping @MainActor @Sendable () -> Void
) -> @Sendable () -> Void {
    let debouncer = Debouncer(delay: delay)
    return {
        Task { @MainActor in
            debouncer.debounce(action: action)
        }
    }
}

/// A helper function to create a debounced version of a closure that accepts one parameter.
/// - Parameters:
///   - delay: The time interval in seconds to wait before executing the action.
///   - action: The closure to execute on the Main Actor, receiving the parameter.
/// - Returns: A closure accepting a parameter that debounces the calls to the action.
public func debounce<T: Sendable>(
    delay: TimeInterval,
    action: @escaping @MainActor @Sendable (T) -> Void
) -> @Sendable (T) -> Void {
    let debouncer = Debouncer(delay: delay)
    return { value in
        Task { @MainActor in
            debouncer.debounce {
                action(value)
            }
        }
    }
}
