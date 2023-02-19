//
//  NftDataService.swift
//  Crypto
//
//  Created by qwotic on 19.02.2023.
//

import Foundation

class NftDataService: ObservableObject {
    @Published var nfts: [NftModel] = []
    
    func fecthNFTData() {
        if let url = Bundle.main.url(forResource: "nftsData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode([NftModel].self, from: data)
                self.nfts = decodedData
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
}
