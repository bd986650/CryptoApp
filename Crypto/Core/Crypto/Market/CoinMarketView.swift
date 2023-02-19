//
//  CoinMarketView.swift
//  Crypto
//
//  Created by qwotic on 11.02.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CoinMarketView: View {
    
    @ObservedObject private var cryptoVM: CryptoDataService = CryptoDataService()

    @State private var searchCoin: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18)
                        .foregroundColor(.white)
                    
                    TextField("Search", text: $searchCoin)
                        .accentColor(.white)
                        .textInputAutocapitalization(.words)
                    
                    Button {
                        searchCoin = ""
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12)
                            .foregroundColor(searchCoin == "" ? .gray.opacity(0.2) : .white)
                    }
                }
                .padding(12)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal, 10)
                
                ListCoins(coins: cryptoVM.coinMarkets)
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: cryptoVM.fetchCoins)
            .refreshable {
                cryptoVM.fetchCoins()
            }
        }
    }

    @ViewBuilder
    func ListCoins(coins: [CryptoCoinModel]) -> some View {
        List(coins.filter({ searchCoin.isEmpty ? true : $0.name.contains(searchCoin) })) { coin in
            NavigationLink(destination: DetailCoinView(coin: coin)) {
                HStack(spacing: 15){
                    AnimatedImage(url: URL(string: coin.image))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text(coin.name)
                            .font(.callout)
                        Text(coin.symbol.uppercased())
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing){
                        Text(coin.current_price.convertToCurency())
                            .fontWeight(.semibold)
                        
                        Text("\(coin.price_change > 0 ? "+" : "")\(String(format: "%.2f", coin.price_change))%")
                            .foregroundColor(coin.price_change > 0 ? Color("ProfitChangePrice") : .red)
                            .font(.system(size: 12))
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct CoinMarketView_Previews: PreviewProvider {
    static var previews: some View {
        CoinMarketView()
    }
}

