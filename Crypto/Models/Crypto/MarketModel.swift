//
//  MarketModel.swift
//  Crypto
//
//  Created by qwotic on 19.02.2023.
//

import Foundation

struct CryptoCoinModel: Identifiable, Codable{
    var id: String
    var symbol: String
    var name: String
    var image: String
    var current_price: Double
    var last_updated: String
    var price_change: Double
    var last_7days_price: GraphModel
    
    enum CodingKeys: String, CodingKey{
        case id
        case symbol
        case name
        case image
        case current_price
        case last_updated
        case price_change = "price_change_percentage_24h"
        case last_7days_price = "sparkline_in_7d"
    }
}

struct GraphModel: Codable{
    var price: [Double]
    enum CodingKeys: String, CodingKey{
        case price
    }
}
