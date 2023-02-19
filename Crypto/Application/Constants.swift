//
//  Constants.swift
//  Crypto
//
//  Created by qwotic on 11.02.2023.
//

import Foundation

enum DefaultSettings {
    // Color Slider Values
    static var rValue: Double = 0.0
    static var gValue: Double = 0.0
    static var bValue: Double = 0.0
    
    // Profile
    static var firstName: String = "Johny"
    static var lastName: String = "Developer"
    static var bio: String = "23 y.o. designer from San Francisco"
    static var balance: Double = 0.0
}

//API URL's
enum API {
    static let nftURL = "https://api.coingecko.com/api/v3/nfts/list?per_page=100"
    
    static let cryptoCoinsURL =  "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=150&sparkline=true&price_change_percentage=24h"
    static let cryptoNewsURL = "https://newsapi.org/v2/everything?q=crypto&apiKey=YOUR_API_KEY"
    
    static let openAIURL = "https://api.openai.com/v1/completions"
    static let openAIKey = ""
}
