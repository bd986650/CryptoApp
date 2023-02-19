//
//  BuyWalletView.swift
//  Crypto
//
//  Created by qwotic on 14.02.2023.
//

import RiveRuntime
import SwiftUI

struct BuyWalletView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var balance: Double
    
    @State private var amount: String = ""
    @State private var currentCurrency: Bool = false
    @State private var showView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            Text("You buy")
                .font(.system(size: 18).bold())
            
            HStack(alignment: .center){
                TextField("0", text: $amount)
                    .font(.system(size: 85))
                    .keyboardType(.numberPad)
                    .frame(height: 100)
                
                Spacer()
                
                Button {
                    currentCurrency.toggle()
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .bold()
                        .padding(15)
                        .background{
                            Circle()
                                .foregroundColor(Color("Gray"))
                                .opacity(0.15)
                        }
                }
            }
            
            Text(currentCurrency ? "AAC" : "USD")
                .font(.system(size: 60).bold())
                .foregroundColor(.white.opacity(0.5))
            
            if amount == "" {
                Text("1 AAC ≈ 1.32 USD")
                    .font(.system(size: 18).bold())
                    .foregroundColor(.white.opacity(0.5))
            } else {
                Text("≈ \(calculateCurrency(), specifier: "%.2f")")
                    .font(.system(size: 18).bold())
                    .foregroundColor(.white.opacity(0.5)) +
                
                Text(currentCurrency ? " USD": " AAC")
                    .font(.system(size: 18).bold())
                    .foregroundColor(.white.opacity(0.5))
            }
            
            Spacer()
            
            HStack(spacing: 10){
                Image(systemName: "creditcard.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45)
                
                VStack(alignment: .leading){
                    Text("Payment method")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .opacity(0.5)
                    
                    Text("Credit card")
                        .font(.title3.bold())
                }
            }
            
        }
        .padding(20)
        .navigationTitle("Wallet")
        .navigationBarTitleDisplayMode(.inline)
        .overlay {
            if showView {
                ZStack {
                    Color.black
                    
                    RiveViewModel(fileName: "loader").view()
                        .ignoresSafeArea()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                    HapticManager.playImpactHaptic(.light)
                } label: {
                    Text("Exit")
                }
            }
            
            ToolbarItem(placement: .keyboard) {
                Button {
                    showView = true
                    HapticManager.playImpactHaptic(.soft)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.presentationMode.wrappedValue.dismiss()
                        if let send = Double(self.amount) {
                            self.balance += send
                        }
                    }
                } label: {
                    Text(currentCurrency ? "BUY AAC" : "BUY USD")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(checkAvailable() ? .white : .gray)
                        .background {
                            Rectangle()
                                .foregroundColor(checkAvailable() ? .green : .clear)
                                .frame(width: UIScreen.main.bounds.width, height: 55)
                        }
                }
                .disabled(!checkAvailable())
                
            }
        }
    }
    
    private func checkAvailable() -> Bool {
        if currentCurrency {
            return Double(amount) ?? 0 >= 5.0
        } else {
            return Double(amount) ?? 0 >= 6.6
        }
    }
    
    private func calculateCurrency() -> Double {
        let inputValue = Double(amount) ?? 0
        let usd = 1.32
        
        if currentCurrency {
            return inputValue * usd
        } else {
            return inputValue / usd
        }
    }
}
