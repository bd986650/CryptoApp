//
//  NftModel.swift
//  Crypto
//
//  Created by qwotic on 16.02.2023.
//

import Foundation

struct NftModel: Codable, Identifiable {
    let id: Int
    let name: String
    let chain: String
    let price: String
    let contractAdress: String
    let description: String
    let image: String
}
