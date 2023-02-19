//
//  SendWalletView.swift
//  Crypto
//
//  Created by qwotic on 14.02.2023.
//

import RiveRuntime
import SwiftUI

struct SendWalletView: View {
    
    @AppStorage("userBalance") var userBalance = DefaultSettings.balance
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var balance: Double
    
    @State private var walletAdress: String = ""
    @State private var amount: String = ""
    @State private var description: String = ""
    @State private var currentCurrency: Bool = false
    @State private var showView: Bool = false
    
    var body: some View {
        VStack(alignment: .center){
            HStack {
                VStack(alignment: .leading){
                    Text("\(calculateUserBalance(), specifier: "%.2f")")
                        .font(.system(size: 50).bold())
                        .padding(.horizontal, 10)
                    
                    Text(currentCurrency ? "balance (AAC)" : "balance (USD)")
                        .font(.system(size: 20).bold())
                        .foregroundColor(.white.opacity(0.5))
                        .padding(.horizontal, 10)
                }
                
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
            .padding(.horizontal, 20)
            
            Form {
                Section {
                    TextField("Enter wallet adress...", text: $walletAdress)
                        .foregroundColor(.white)
                }
                
                Section {
                    TextField("0", text: $amount)
                        .font(.system(size: 45))
                        .foregroundColor(.white)
                        .keyboardType(.numberPad)
                } header: {
                    Text("Amount")
                }
                
                Section {
                    TextField("Optional description of the payment", text: $description)
                        .foregroundColor(.white)
                } header: {
                    Text("Description")
                }
            }
            
            Spacer()
            
            Button {
                showView = true
                HapticManager.playImpactHaptic(.soft)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.presentationMode.wrappedValue.dismiss()
                    if let send = Double(self.amount) {
                        self.balance -= send
                    }
                }
            } label: {
                Text("SEND")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(checkAvailable() ? .white : .gray)
                    .padding(4)
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(checkAvailable() ? .green : .gray.opacity(0.2))
                    .cornerRadius(10)
            }
            .disabled(!checkAvailable())
            
        }
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
        }
    }
    
    private func checkAvailable() -> Bool {
        if currentCurrency {
            return Double(amount) ?? 0 >= 1.0
        } else {
            return Double(amount) ?? 0 >= 1.32
        }
    }
    
    private func calculateUserBalance() -> Double {
        let usd = 1.32
        let aac = 1.0
        
        if currentCurrency {
            return userBalance * usd
        } else {
            return userBalance * aac
        }
    }
    
    private func calculateCurrency() -> Double {
        let inputValue = Double(amount) ?? 0
        let usd = 1.32
        let aac = 1.0
        
        if currentCurrency {
            return inputValue * usd
        } else {
            return inputValue * aac
        }
    }
}
