//
//  DetailNftView.swift
//  Crypto
//
//  Created by qwotic on 16.02.2023.
//

import RiveRuntime
import SwiftUI
import SDWebImageSwiftUI

struct DetailNftView: View {
    
    @AppStorage("userBalance") var userBalance = DefaultSettings.balance

    var nft: NftModel
    private let timer = Calendar.current.date(byAdding: .hour, value: 12 ,to: Date())!
    
    @State private var opacity: Double = 1.0
    @State private var transactionTimerRemaining = 5.0
    @State private var transactionTimer: Timer?
    @State private var isCancelTransactionTimerRunning: Bool = false
    @State private var isSuccessTransaction: Bool = false
    @State private var isLike: Bool = false
    @State private var isFullScreenNft: Bool = false
    
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
        ZStack {
            background
            
            ScrollView(showsIndicators: false){
                VStack {
                    Spacer()
                    
                    if isFullScreenNft {
                        AnimatedImage(url: URL(string: nft.image))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 30, height: 500)
                            .cornerRadius(20)
                    } else {
                        AnimatedImage(url: URL(string: nft.image))
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .cornerRadius(20)
                            .padding(5)
                    }
                    
                    HStack {
                        Text(nft.name)
                            .lineLimit(2)
                            .font(.system(size: 20, weight: .bold ,design: .rounded))
                        
                        Spacer()
                        
                        if !isFullScreenNft {
                            Button {
                                withAnimation(.spring()) {
                                    isLike.toggle()
                                }
                            } label: {
                                Image(systemName: isLike ? "heart.fill" : "heart")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(isLike ? .red : .black)
                                    .frame(width: 20)
                                    .padding(10)
                                    .background{ Capsule().fill(Color.white).shadow(radius: 40) }
                            }
                            
                            NavigationLink(destination: WebView(title: nft.contractAdress, link: "https://etherscan.io/address/\(nft.contractAdress)")) {
                                Image(systemName: "link")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.black)
                                    .frame(width: 20)
                                    .padding(10)
                                    .background{ Capsule().fill(Color.white).shadow(radius: 40) }
                            }
                        }
                    }
                    .padding()
                    .background{ RoundedRectangle(cornerRadius: 20).opacity(0.25) }
                        
                    if !isFullScreenNft {
                        
                        if nft.description != "" {
                            HStack {
                                Spacer()
                                
                                Text(nft.description)
                                    .font(.system(size: 16, design: .rounded))
                                 
                                Spacer()
                            }
                            .padding()
                            .background{ RoundedRectangle(cornerRadius: 20).opacity(0.25) }
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 5){
                                Text("Last bid")
                                    .font(.system(size: 16, design: .rounded))
                                    .opacity(0.5)
                                
                                Text("\(nft.price) AAC")
                                    .font(.system(size: 20, weight: .bold ,design: .rounded))
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 5){
                                Text("Auction ending in:")
                                    .font(.system(size: 16, design: .rounded))
                                    .opacity(0.5)
                                
                                TimerView(setDate: timer)
                                    .font(.system(size: 20, weight: .bold ,design: .rounded))
                            }
                        }
                        .padding()
                        .background{ RoundedRectangle(cornerRadius: 20).opacity(0.25) }
                    }
                    
                    if isSuccessTransaction {
                        HStack {
                            Spacer()
                            
                            Text("Success")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .padding(10)
                                
                            Spacer()
                        }
                        .frame(height: 50)
                        .background{ RoundedRectangle(cornerRadius: 14).opacity(0.25) }
                            
                    } else {
                        Button {
                            transactionButtonAction()
                        } label: {
                            ZStack(alignment: .trailing) {
                                Rectangle()
                                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                                    .foregroundColor(.white.opacity(0.25))
                                    .animation(.linear, value: transactionTimerRemaining)
                                    .overlay {
                                        Text(isCancelTransactionTimerRunning ? "Cancel" : "Place a bid")
                                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                                            .foregroundColor(.white)
                                            
                                    }
                                
                                RoundedCorners(tl: 5, bl: 5)
                                    .frame(width: getTransactionButtonWidth(), height: 50)
                                    .foregroundColor(.white)
                                    .animation(.linear, value: transactionTimerRemaining)
                                    
                            }
                            .overlay {
                                Text(isCancelTransactionTimerRunning ? "Cancel" : "Place a bid")
                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color("Purple"))
                                    .opacity(opacity)
                            }
                            .cornerRadius(14)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    withAnimation(.spring()) {
                        isFullScreenNft.toggle()
                    }
                } label: {
                    Image(systemName: isFullScreenNft ? "arrow.up" : "arrow.down")
                }
            }
        }
        .ignoresSafeArea()
    }
    
    private func getTransactionButtonWidth() -> CGFloat {
        let totalWidth = UIScreen.main.bounds.width - 32
        let percentageRemaining = CGFloat(transactionTimerRemaining / 5)
        return totalWidth * percentageRemaining
    }
    
    private func transactionButtonAction() {
        if isCancelTransactionTimerRunning {
            resetTimer()
        } else {
            startTimer()
        }
    }
    
    private func startTimer() {
        isCancelTransactionTimerRunning = true
        transactionTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            transactionTimerRemaining -= 0.1
            opacity -= 0.035
            
            if transactionTimerRemaining <= 0.01 {
                timer.invalidate()
                isSuccessTransaction = true
                HapticManager.playNotificationHaptic(.success)
            }
        }
        if let price = Double(nft.price) {
            self.userBalance -= price
        }
    }
    
    private func resetTimer() {
        isCancelTransactionTimerRunning = false
        transactionTimerRemaining = 5.0
        opacity = 1.0
        transactionTimer?.invalidate()
        transactionTimer = nil
        if let price = Double(nft.price) {
            self.userBalance += price
        }
        HapticManager.playNotificationHaptic(.error)
    }
}

struct DetailNftView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNftView(nft: NftModel(id: 1002, name: "Genesis Box #1272", chain: "etherium", price: "1.0", contractAdress: "0xB75F09b4340aEb85Cd5F2Dd87d31751EDC11ed39", description: "A doodley box of genesis edition wearables for Doodles 2, containing a rare assortment of apparel and accessories.", image: "https://public.nftstatic.com/static/nft/res/nft-cex/S3/1675268049320_didoxs2o5nm3hy6m42orty1myoo08vst.gif"))
    }
}
