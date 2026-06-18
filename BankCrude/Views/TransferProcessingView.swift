//
//  TransferProcessingView.swift
//  BankCrude
//
//  Created by Antigravity on 18/06/26.
//

import SwiftUI

struct TransferProcessingView: View {
    @Environment(NavigationRouter.self) private var router
    let transaction: TransactionItem
    
    @State private var rotationAngle: Double = 0.0
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            // Custom Spinner Animation
            ZStack {
                Circle()
                    .stroke(Color.primaryRed.opacity(0.1), lineWidth: 6)
                    .frame(width: 80, height: 80)
                
                Circle()
                    .trim(from: 0.0, to: 0.3)
                    .stroke(Color.primaryRed, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .frame(width: 80, height: 80)
                    .rotationEffect(Angle(degrees: rotationAngle))
                    .onAppear {
                        withAnimation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false)) {
                            rotationAngle = 360.0
                        }
                    }
            }
            
            VStack(spacing: 12) {
                Text("Processing Transfer")
                    .typography(.title3, weight: .bold)
                    .foregroundColor(.textPrimary)
                
                Text("Please wait while we clear your transaction with the destination bank.")
                    .typography(.footnote, weight: .regular)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 48)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundWhite)
        .navigationBarBackButtonHidden(true) // Prevent going back during processing
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                // Safely replace the processing route with the transaction receipt view
                router.replace(.transferProcessing(transaction), with: .transactionReceipt(transaction, isFromTransfer: true))
            }
        }
    }
}

#Preview {
    PreviewRouterWrapper {
        NavigationStack {
            TransferProcessingView(
                transaction: TransactionItem(
                    date: Date(),
                    title: "Radhita Salsabila",
                    subtitle: "Transfer to Bank Crude (0342039298)",
                    amount: 250000.00,
                    type: .outflow,
                    status: .success
                )
            )
        }
    }
}
