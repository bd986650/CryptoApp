//
//  NewsModel.swift
//  Crypto
//
//  Created by qwotic on 19.02.2023.
//

import Foundation

struct CryptoNewsModel: Codable, Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case url
        case urlToImage
        case publishedAt
    }
}

struct CryptoNewsResponse: Codable {
    let articles: [CryptoNewsModel]
}
