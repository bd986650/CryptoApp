//
//  WalletView.swift
//  Crypto
//
//  Created by qwotic on 12.02.2023.
//

import SwiftUI

struct WalletView: View {
    
    @State private var alertTitle: String = "Do you want delete wallet?"
    
    @State private var showSendSheet: Bool = false
    @State private var showBuySheet: Bool = false
    @State private var showDeleteWalletAlert: Bool = false
    @State private var currentCurrency: Bool = false
    
    @AppStorage("userBalance") var userBalance = DefaultSettings.balance
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("\(calculateCurrency(), specifier: "%.2f")")
                .font(.system(size: 50).bold())
            
            Text(currentCurrency ? "USD" : "AAC")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding(.bottom, 5)
            
            Text("your balance")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundColor(.white.opacity(0.5))
            
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
            
            Spacer()
            
            HStack {
                Button {
                    showSendSheet = true
                } label: {
                    HStack {
                        Text("Send")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                        
                        Image(systemName: "arrow.down.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .bold()
                    }
                    .padding(20)
                    .padding(.horizontal, 5)
                    .background(Color("Gray").opacity(0.15))
                    .cornerRadius(15)
                }
                
                Button {
                    showBuySheet = true
                } label: {
                    HStack {
                        Text("Buy")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                        
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .bold()
                    }
                    .padding(20)
                    .padding(.horizontal, 10)
                    .background(Color("Gray").opacity(0.15))
                    .cornerRadius(15)
                }
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Wallet")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showDeleteWalletAlert = true
                    HapticManager.playNotificationHaptic(.warning)
                } label: {
                    Text("Delete")
                }
            }
        }
        .alert(Text(alertTitle), isPresented: $showDeleteWalletAlert, actions: {
            Button("Delete") {
                userBalance = DefaultSettings.balance
            }
            Button("Cancel", role: .cancel) { }
        })
        .fullScreenCover(isPresented: $showSendSheet) {
            NavigationStack {
                SendWalletView(balance: $userBalance)
            }
        }
        .fullScreenCover(isPresented: $showBuySheet) {
            NavigationStack {
                BuyWalletView(balance: $userBalance)
            }
        }
    }
    
    private func calculateCurrency() -> Double {
        let usd = 1.32
        let acc = 1.0
        
        if currentCurrency {
            return userBalance * usd
        } else {
            return userBalance * acc
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}

