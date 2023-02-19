//
//  DetailCoinView.swift
//  Crypto
//
//  Created by qwotic on 11.02.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailCoinView: View {
    
    @ObservedObject private var coinMarketVM: CryptoDataService = CryptoDataService()
    
    var coin: CryptoCoinModel
    
    @State private var isFavourite: Bool = false
    
    var body: some View {
        VStack{
            HStack(spacing: 15){
                AnimatedImage(url: URL(string: coin.image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 5){
                    Text(coin.name)
                        .font(.callout)
                    Text(coin.symbol.uppercased())
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 8){
                Text(coin.current_price.convertToCurency())
                    .font(.largeTitle.bold())
                
                Text("\(coin.price_change > 0 ? "+" : "")\(String(format: "%.2f", coin.price_change))%")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(coin.price_change > 0 ? Color("ProfitChangePrice") : .red)
                    .padding(.horizontal,10)
                    .padding(.vertical,5)
                    .background{
                        Capsule()
                            .stroke(coin.price_change > 0 ? Color("ProfitChangePrice") : .red)
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            GraphView(coin: coin)
            
            BottomButtons()
            
        }
        .refreshable {
            coinMarketVM.fetchCoins()
        }
        .padding()
    }
    
    @ViewBuilder
    func GraphView(coin: CryptoCoinModel) -> some View {
        GeometryReader{ _ in
            LineGraph(data: coin.last_7days_price.price, profit: coin.price_change > 0)
        }
        .padding(.vertical, 30)
        .padding(.bottom, 20)
    }
    
    @ViewBuilder
    func BottomButtons() -> some View {
        HStack(spacing: 20){
            Button {
                HapticManager.playImpactHaptic(.medium)
            } label: {
                Text("Buy")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(.white)
                    }
            }

            Button {
                HapticManager.playImpactHaptic(.medium)
            } label: {
                Text("Sell")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.white)
                    }
            }
        }
    }
}

