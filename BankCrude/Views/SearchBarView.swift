//
//  SearchBarView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

/// A reusable search bar component with a built-in debouncer.
/// Follows SOLID principles: manages its own debouncing logic and offers immediate text feedback via binding
/// while dispatching debounced callbacks for heavy tasks (like network calls or filtering).
public struct SearchBarView: View {
    @Binding public var text: String
    public let placeholder: String
    public let debounceDelay: TimeInterval
    public let onSearchDebounced: (String) -> Void
    
    @State private var debouncer: Debouncer
    
    /// Initializes a new SearchBarView.
    /// - Parameters:
    ///   - text: A binding to the raw search text (updates immediately).
    ///   - placeholder: The placeholder text. Defaults to "Search".
    ///   - delay: The debounce delay in seconds. Defaults to 0.35.
    ///   - onSearchDebounced: A closure triggered with the search term after the debounce delay.
    public init(
        text: Binding<String>,
        placeholder: String = "Search",
        delay: TimeInterval = 0.35,
        onSearchDebounced: @escaping (String) -> Void
    ) {
        self._text = text
        self.placeholder = placeholder
        self.debounceDelay = delay
        self.onSearchDebounced = onSearchDebounced
        self._debouncer = State(initialValue: Debouncer(delay: delay))
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.textPrimary)
            
            TextField("", text: $text, prompt: Text(placeholder))
                .typography(.body, weight: .regular)
                .foregroundColor(.textPrimary)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .frame(height: 44)
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                    // Immediately trigger empty search callback for responsive UX
                    debouncer.cancel()
                    onSearchDebounced("")
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.textSecondary)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 16)
        .background(Color(hex: "EDEDED"))
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.primaryBlack, lineWidth: 1.2)
        )
        .onChange(of: text) { _, newValue in
            debouncer.debounce {
                onSearchDebounced(newValue)
            }
        }
    }
}

#Preview {
    @Previewable @State var searchText = ""
    @Previewable @State var debouncedSearchText = ""
    
    return VStack(spacing: 24) {
        SearchBarView(
            text: $searchText,
            placeholder: "Search transactions...",
            delay: 0.5
        ) { debouncedVal in
            debouncedSearchText = debouncedVal
        }
        
        VStack(alignment: .leading, spacing: 4) {
            Text("Immediate text: \(searchText)")
            Text("Debounced text: \(debouncedSearchText)")
        }
        .typography(.body, weight: .medium)
        
        Spacer()
    }
    .padding(24)
    .background(Color.backgroundWhite)
}
