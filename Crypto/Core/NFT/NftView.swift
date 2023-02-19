//
//  NftView.swift
//  Crypto
//
//  Created by qwotic on 15.02.2023.
//

import RiveRuntime
import SwiftUI
import SDWebImageSwiftUI

struct NftView: View {
    @ObservedObject private var nftVM: NftDataService = NftDataService()
    
    @AppStorage("userBalance") var userBalance = DefaultSettings.balance
    
    @State private var currentCurrency: Bool = false
    @State private var columns: Int = 1
    
    var background: some View {
        RiveViewModel(fileName: "shapes").view()
            .ignoresSafeArea()
            .blur(radius: 100)
            .background{
                LinearGradient(colors: [Color("Blue"), Color("Purple"), Color("Pink")], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
            .scaleEffect(1.5)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                
                CustomGrid(columns: columns) {
                    ForEach(nftVM.nfts) { nft in
                        NavigationLink(destination: DetailNftView(nft: nft)) {
                            ZStack(alignment: .bottom) {
                                AnimatedImage(url: URL(string: nft.image)!)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(20)
                                    .padding(.horizontal, 20)
                                
                                if columns == 1 {
                                    HStack {
                                        Image(systemName: "")
                                        
                                        VStack(alignment: .leading){
                                            Text("Price")
                                                .foregroundColor(.secondary)
                                            
                                            Text("\(nft.price) AAC")
                                                .font(.system(size: 17, weight: .bold ,design: .rounded))
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: "arrow.right")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.white)
                                            .frame(width: 20)
                                            .padding()
                                            .background{ Circle().opacity(0.25) }
                                    }
                                    .padding(5)
                                    .padding(.leading, 10)
                                    .background(.ultraThinMaterial, in: Capsule())
                                    .padding(.horizontal, 30)
                                    .padding(.bottom, 10)
                                }
                            }
                        }
                    }
                }
                .refreshable {
                    nftVM.fecthNFTData()
                }
                .onAppear(perform: nftVM.fecthNFTData)
                .navigationTitle("NFT's")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button {
                                withAnimation(.spring()) {
                                    columns -= 1
                                }
                            } label: {
                                Image(systemName: "minus.magnifyingglass")
                                    .resizable()
                                    .scaledToFit()
                                    .bold()
                                    .frame(width: 20)
                            }
                            .disabled(columns == 1)
                            
                            Button {
                                withAnimation(.spring()) {
                                    columns += 1
                                }
                            } label: {
                                Image(systemName: "plus.magnifyingglass")
                                    .resizable()
                                    .scaledToFit()
                                    .bold()
                                    .frame(width: 20)
                            }
                            .disabled(columns == 3)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text(currentCurrency ? "\(calculateCurrency(), specifier: "%.2f") USD" : "\(calculateCurrency(), specifier: "%.2f") AAC")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .onTapGesture {
                                currentCurrency.toggle()
                            }
                    }
                }
            }
        }
    }
    
    private func calculateCurrency() -> Double {
        let usd = 1.32
        let aac = 1.0
        
        if currentCurrency {
            return userBalance * usd
        } else {
            return userBalance * aac
        }
    }
}

struct NftView_Previews: PreviewProvider {
    static var previews: some View {
        NftView()
    }
}


