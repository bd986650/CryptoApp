//
//  NftViewModel.swift
//  Crypto
//
//  Created by Данил Белов on 16.02.2023.
//

import Foundation

class NftDataService: ObservableObject {
    @Published var nfts: [NftModel] = []
    
    func loadNFTData() {
        guard let url = Bundle.main.url(forResource: "nftsData", withExtension: "json") else {
            print("Failed to locate items.json in app bundle")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            self.nfts = try JSONDecoder().decode([NftModel].self, from: data)
        } catch {
            print("Failed to decode items.json: \(error.localizedDescription)")
        }
    }
}
