//
//  SectionHeaderView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

public struct SectionHeaderView: View {
    public let title: String
    public let buttonTitle: String?
    public let buttonAction: (() -> Void)?
    
    public init(
        _ title: String,
        buttonTitle: String? = nil,
        buttonAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
    
    public var body: some View {
        HStack {
            Text(title)
                .typography(.title3, weight: .bold)
                .foregroundColor(.textPrimary)
            
            Spacer()
            
            if let buttonTitle, let buttonAction {
                Button(action: buttonAction) {
                    Text(buttonTitle)
                        .typography(.subheadline, weight: .semibold)
                        .foregroundColor(.primaryRed)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        SectionHeaderView("Transaction History", buttonTitle: "See All") {
            print("Tapped See All")
        }
        .padding(.horizontal, 24)
        
        SectionHeaderView("Accounts")
            .padding(.horizontal, 24)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.backgroundWhite)
}
