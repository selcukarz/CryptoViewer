//
//  CryptoModel.swift
//  CryptoViewer
//
//  Created by muzaffer on 25.07.2022.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let coins: [Coin]?
}

// MARK: - Coin
struct Coin: Codable {
    let id: String?
    let icon: String?
    let name, symbol: String?
    let rank: Int?
    let price, priceBtc: Double?
    let volume: Double?
    let marketCap, availableSupply, totalSupply, priceChange1H: Double?
    let priceChange1D, priceChange1W: Double?
    let websiteURL: String?
    let twitterURL: String?
    let exp: [String]?
    let contractAddress: String?
    let decimals: Int?
    let redditURL: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id, icon, name, symbol, rank, price, priceBtc, volume, marketCap, availableSupply, totalSupply
        case priceChange1H = "priceChange1h"
        case priceChange1D = "priceChange1d"
        case priceChange1W = "priceChange1w"
        case websiteURL = "websiteUrl"
        case twitterURL = "twitterUrl"
        case exp, contractAddress, decimals
        case redditURL = "redditUrl"
    }
}
