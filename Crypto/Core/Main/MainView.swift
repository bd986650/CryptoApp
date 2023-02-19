//
//  MainView.swift
//  Crypto
//
//  Created by qwotic on 11.02.2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var networkMonitor = NetworkManager()
    @State private var isShowMainView: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if isShowMainView {
                    if networkMonitor.isActive {
                        TabView {
                            NftView()
                                .tabItem {
                                    Label("NFT",systemImage: "hexagon.fill")
                                }
                            
                            CryptoView()
                                .tabItem {
                                    Label("Market",systemImage: "chart.bar.xaxis")
                                }
                            
                            ProfileView()
                                .tabItem {
                                    Label("Profile",systemImage: "person.circle.fill")
                                }
                        }
                    } else {
                        ConnectionErrorView()
                    }
                } else {
                    SplashView()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                    isShowMainView = true
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
