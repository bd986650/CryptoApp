//
//  CryptoNewsView.swift
//  Crypto
//
//  Created by qwotic on 11.02.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CryptoNewsView: View {
    
    @ObservedObject private var cryptoVM: CryptoDataService = CryptoDataService()
    
    var body: some View {
        NavigationView {
            VStack {
                List(cryptoVM.cryptoNews, id: \.title) { news in
                    NavigationLink(destination: WebView(title: news.title, link: news.url)) {
                        HStack {
                            VStack(alignment: .leading, spacing: 5){
                                Text(news.title)

                                Text(news.publishedAt)
                                    .font(.system(size: 10))
                                    .opacity(0.4)
                            }

                            Spacer()

                            AnimatedImage(url: URL(string: news.urlToImage))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .onAppear(perform: cryptoVM.fetchCryptoNews)
            .refreshable {
                cryptoVM.fetchCryptoNews()
            }
        }
    }
}

struct CryptoNewsView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoNewsView()
    }
}

