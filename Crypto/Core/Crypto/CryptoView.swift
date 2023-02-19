//
//  CryptoView.swift
//  Crypto
//
//  Created by qwotic on 11.02.2023.
//

import RiveRuntime
import SwiftUI

struct CryptoView: View {
    
    @State private var showView: Bool = false
    @State private var currentSelection: Int = 0
    
    var body: some View {
        PagerTabView(tint: .white, selection: $currentSelection){
            
            Text("News")
                .font(.headline)
                .foregroundColor(currentSelection == 0 ? .white : .gray.opacity(0.5))
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("Markets")
                .foregroundColor(currentSelection == 1 ? .white : .gray.opacity(0.5))
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            
            
        } content: {
            
            CryptoNewsView()
                .padding(.top, 10)
                .pageView(ignoreSafeArea: true, edges: .bottom)
            
            CoinMarketView()
                .padding(.top, 10)
                .pageView(ignoreSafeArea: true, edges: .bottom)

        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showView = true
            }
        }
        .overlay {
            if !showView {
                ZStack {
                    Color.black
                    
                    RiveViewModel(fileName: "loader").view()
                        .ignoresSafeArea()
                }
            }
        }
    }
}

struct CryptoView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoView()
    }
}

