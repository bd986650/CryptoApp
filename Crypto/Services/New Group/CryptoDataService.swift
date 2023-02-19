//
//  CryptoDataService.swift
//  Crypto
//
//  Created by qwotic on 11.02.2023.
//

import Foundation

class CryptoDataService: ObservableObject {
    
    @Published var coinMarkets: [CryptoCoinModel] = []
    @Published var cryptoNews: [CryptoNewsModel] = []

    func fetchCoins() {
        guard let url = URL(string: API.cryptoCoinsURL) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }

            do {
                let decodedItems = try JSONDecoder().decode([CryptoCoinModel].self, from: data)
                DispatchQueue.main.async {
                    self.coinMarkets = decodedItems
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func fetchCryptoNews() {
        guard let url = URL(string: API.cryptoNewsURL) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }

            do {
                let decodedItems = try JSONDecoder().decode(CryptoNewsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.cryptoNews = decodedItems.articles
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
